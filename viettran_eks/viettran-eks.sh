# monitor satus pods (realtime)
kubectl get pods -w



# no file yaml, if image push on docker hup update, then dowload (even if exit local) 
kubectl run app1 --image=vietaws/eks:1 --image-pull-policy Always # alway download image on dockerhub

# check if ip exists or not
kubectl get nodes -o wide

# check logs pod, -f: 
kubectl logs app1 -f

# exec
kubectl exec -it app1 -- ls
kubectl exec -it app1 -- cat Dockerfile

# create service
kubectl expose --help
kubectl expose pods app1 --port=8081 --target-port=8080 --name=service1 --type=NodePort

kubectl describe svc service1

# 13. imperative (đặc tả tường minh bằng các gõ lệnh như trên) vs declarative (sử dụng file .yaml)

#15 replicaSet: muon chay mot nhom pod -> include : replicas and pod
# labels dung de group cac tai nguyen voi nhau
# selector dung de group cac lable co cung thuoc tinh (do nguoi dung dn) lai voi nhau de tao thanh mot nhom replicaSet
kubectl get rs
kubectl describe rs  car-serv-deployment-6dcd48b9f5
kubectl describe replicasets.apps  car-serv-deployment-6dcd48b9f5

kubectl delete pod car-serv-deployment-6dcd48b9f5

# Chu ý khi nếu có một pod đang chạy có label mà ta đang muốn tạo replicaset, vd replicas:3 thì khi tạo chỉ tạo 2 pods (vì đã có một con trc đó sử dụng lable trùng với vừa tạo)

# 19 edit replicaset 
kubectl edit replicaset.apps rs3

# 20 deployment | A Deployment provides declarative updates for Pods and ReplicaSets.
kubectl create deployment --help
kubectl get rs
kubectl get delopyment.apps

# 21 scale & expose
kubectl scale --help
kubectl scale  --replicas=2 deployment/deployment

kubectl expose --help

 kubectl expose deployment deployment  --port=8080 --name=svc1 --target-port=80 --type=NodePort

 ## 22 set image (update image)

 kubectl set image --help

 kubectl set image deployment/deployment simaple-app1=vietaws/eks:v3

 kubectl describe rs deployment-cccfc6f7b # check replicaset old ver

 # 23 Rollout  
 kubectl rollout history --help

 kubectl rollout history deployment/deployment
 kubectl rollout status deployment/deployment
 kubectl edit deployment/deployment

 # 24 rollback deployment
 # check detail ver
 kubectl rollout history deploy deployment --revision=1
 kubectl rollout history deploy deployment --revision=2
 kubectl rollout history deploy deployment --revision=3

 kubectl rollout undo deployment/deployment
 kubectl rollout undo deployment/nginx-deployment --to-revision=3