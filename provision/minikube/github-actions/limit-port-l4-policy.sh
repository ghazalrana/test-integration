#!/bin/sh


# This example enables all endpoints with the label role=frontend to communicate with all endpoints with the label  run: my-nginx, but they must communicate using TCP on port 80. Endpoints with other labels will not be able to communicate with the endpoints with the label  run: my-nginx, and endpoints with the label role=frontend will not be able to communicate with  run: my-nginx on ports other than 80.


echo "Creating test namespace and multicontainer pod"

kubectl create ns test > /dev/null

kubectl apply -f - << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
  namespace: test
spec:
  selector:
    matchLabels:
      run: my-nginx
  replicas: 1 
  template:
    metadata:
      labels:
        run: my-nginx
    spec:
      containers:
      - name: my-nginx
        image: nginx
        ports:
        - containerPort: 80
      - name: nodongo
        image: lightninglife/nodejs-starter:1.1
        ports:
        - containerPort: 3000

---

apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  namespace: test
  labels:
    run: my-nginx
spec:
  type: NodePort
  ports:
  - port: 80
    protocol: TCP
    name: http
  - port: 3000
    protocol: TCP
    name: node
  selector:
    run: my-nginx

EOF




kubectl apply -f - << EOF
apiVersion: "cilium.io/v2"
kind: CiliumNetworkPolicy
metadata:
  name: "l4-rule"
  namespace: test
spec:
  endpointSelector:
    matchLabels:
       run: my-nginx
  ingress:
  - fromEndpoints:
    - matchLabels:
        role: frontend
    toPorts:
    - ports:
      - port: "80"
        protocol: TCP
        
EOF

kubectl wait --for=condition=Ready pods --all -n test --timeout=10m


echo  "Running Test Pod With Label role=frontend \n"


kubectl run busybox-label --labels="role=frontend" -n test --image=yauritux/busybox-curl -- sleep 999999 > /dev/null

# waiting for the pod to be READY

kubectl wait --for=condition=Ready pods --all -n test --timeout=10m


echo  "01- Running Test To Access Pod at Port 80 (should be accessible) \n "

kubectl exec busybox-label -n test -- curl -sSL my-nginx >> /dev/null 2>&1

if [ $? !=  0 ]; then 
echo "Failed: Port 80 not accessible"
echo "Exiting"
exit 1
else
echo "Passed: Port 80 accessible"

fi

echo " "

sleep 20

echo "02- Running Test To Access Pod other than Port 80 (shouldn't be accessible) \n "

kubectl exec busybox-label -n test -- curl -sSL my-nginx:3000 --connect-timeout 10 >> /dev/null 2>&1

if [ $? -eq 0 ]; then 
echo "Failed: Port 3000 accessible"
echo "Exiting"
exit 1
else
echo "Passed: Port 3000 not accessible"
fi
