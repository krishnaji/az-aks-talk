# Build docker container
docker build -t nodeapp --platform=linux/amd64 .
# TAG the container
docker tag nodeapp:latest fancy.azurecr.io/nodeapp:latest
# RUN the container
docker run -it --rm --platform=linux/amd64 -p 8080:8080 fancy.azurecr.io/nodeapp:latest
# Push to Azure Container Registry
docker push fancy.azurecr.io/nodeapp:latest

# Run single pod in kubernetes
kubectl run nodeapp --image=fancy.azurecr.io/nodeapp:latest --port=8080
# Local access to kubernetes pod
kubectl port-forward pods/nodeapp 8080:8080 
# Expose the pod as a service
kubectl expose pod nodeapp --type=LoadBalancer --port=8080

# Run multiple pods in kubernetes
kubectl apply -f k8s-deployment.yaml

# Automatically scale the pods
kubectl autoscale deployment nodeapp-deployment --cpu-percent=50 --min=1 --max=10

# Generate load agaist deployment ( * Get Service IP)
kubectl run -i --tty load-generator-1 --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- nodeapp-deployment/load; done"
kubectl run -i --tty load-generator-2 --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- nodeapp-deployment/load; done"

# Delete HPA (Horizontal Pod Autoscaler)
kubectl delete hpa nodeapp-deployment

# Delete deployment
kubectl delete -f k8s-deployment.yaml
