# Yêu cầu:
# Tạo một file cấu hình cho nginx service dạng NodePort (kèm theo deployment).
# Apply file cấu hình cho Kubernetes cluster.
# Kiểm tra Service & Deployment được tạo ra.
# Sử dụng câu lệnh sau để check IP của minikube, open địa chỉ <minikube_ip>:<node_port> trên trình duyệt để xem kết quả.
>minikube ip

 #mikikybe ip được sử dụng để lấy địa chỉ IP của cụm Kubernetes đang chạy trong Minikube. Địa chỉ IP này có thể được sử dụng để truy cập các dịch vụ đang chạy trên cụm Minikube từ bên ngoài. 
# Địa chỉ IP của Minikube không phải là 127.0.0.1 (localhost) vì Minikube tạo một máy ảo hoặc một container riêng biệt để chạy cụm Kubernetes. Địa chỉ 127.0.0.1 chỉ trỏ đến localhost của máy chủ (host) mà bạn đang chạy Minikube trên đó.

# Minikube hoạt động bằng cách thiết lập một môi trường Kubernetes trong một máy ảo hoặc container riêng biệt, và máy ảo/container này có địa chỉ IP riêng của nó. Đây là lý do tại sao bạn cần sử dụng lệnh minikube ip để lấy địa chỉ IP của máy ảo/container đó, chứ không phải địa chỉ IP localhost (127.0.0.1) của máy chủ của bạn.

# Nếu bạn sử dụng địa chỉ 127.0.0.1, bạn đang trỏ đến máy chủ của chính bạn chứ không phải máy ảo/container Minikube. Địa chỉ IP được trả về bởi lệnh minikube ip là địa chỉ IP của máy ảo/container nơi Minikube đang chạy, và bạn cần địa chỉ này để truy cập các dịch vụ được triển khai trên Kubernetes cụm Minikube.

# Ví dụ, sau khi chạy lệnh minikube ip, bạn nhận được địa chỉ IP là 192.168.99.100. Địa chỉ này là địa chỉ của máy ảo/container Minikube. Bạn cần sử dụng địa chỉ này để truy cập các dịch vụ Kubernetes chạy bên trong Minikube.

#==================
# Create a file named nginx-nodeport.yaml
# Apply the configuration file to the Kubernetes cluster
kubectl apply -f nginx-nodeport.yaml
# Check the Service & Deployment
kubectl get service
kubectl get service nginx-service -o wide
kubectl get deployment
kubectl get pods -o wide

#Kiểm tra IP của minikube
minikube service list
minikube ip
#Lưu ý: Địa chỉ này chỉ có tác dụng trọng mạng nội bộ của Kubernetes, không thể truy cập từ bên ngoài.

#Cần phải sử dụng câu lệnh tạo một tunnel để có thể truy cập từ bên ngoài (nếu dùng window thì minikube chỉ ip nội bộ, nếu muốn truy cập phải export ra bên ngoài)
minikube service nginx-service --url
#Copy URL dán vào trình duyệt, vd:
http://127.0.0.1:64451

#Xoá resource:
kubectl delete -f nginx-nodeport.yaml

