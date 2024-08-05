kubectl=kube control
TODO: Fix kubernetes dashboard
kubectl get deployments
kubectl create deployment first-app --image=samueltorga/kub-first-app #Images should come from Docker hub
Deployment goes to master node (Control Plane)

Services exposes pods to the cluster or exernally
- Internal PODS can change its IPs
- Services keep a accessible IP to pods inside a cluster

ClusterIP = Accessible only internal
LoadBalancer depends on where K8s is running

kubectl expose deployment first-app --type=LoadBalancer --port=8080 #port that are exposed from the container

Update deployment with another image:
- Build image with new tag
- `kubectl set image deployment/first-app kub-first-app=samueltorga/kub-first-app:2` kub-first-app is the service
- kubectl rollout status deployment/first-app
- kubectl rollout undo deployment/first-app
- kubectl rollout undo deployment/first-app --to-revision=1
- kubectl rollout history deployment/first-app
- kubectl apply -f=

