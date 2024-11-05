kubectl apply -f nginx-pod.yaml
kubectl get pods
kubectl get pods -o wide
kubectl describe pod nginx-pod
kubectl delete -f nginx-pod.yaml

## namespace
kubectl get namespaces

#Trong lệnh kubectl apply -f <file>, tùy chọn -f là một viết tắt của --filename. Nó cho biết cho kubectl biết rằng bạn đang cung cấp một tệp YAML hoặc JSON để áp dụng (hoặc cập nhật) tài nguyên của Kubernetes.