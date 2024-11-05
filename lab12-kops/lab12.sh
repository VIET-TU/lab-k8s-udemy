#Tạo một EC2 chạy Ubuntu

#Cài đặt AWS CLI:
sudo apt update
    sudo apt install awscli -y
aws --version
#******************************cấp cho Kops instance quyền iam role có policy: AdministratorAccess.**************************88
# Vào IAM: tạo role
# Vào EC2: thêm role vào ec2 chạy Kops, Modify IAM role 
## kiểm tra role: aws s3 ls


#Cài đặt Kubectl & Kops cho server.
#Tham khảo link sau:
#https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl help

#Cài đặt Kops
#Tham khảo link sau: https://kops.sigs.k8s.io/getting_started/install/
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops
kops version

#Chuẩn bị domain, có thể mua tại Route53.
#Kiểm tra domain:
nslookup -type=ns hoanglinhdigital.com
nslookup -type=ns viettu.id.vn

#Tạo một S3 bucket để lưu trữ state của Kops
aws s3api create-bucket --bucket kops-stage-s3-bucket --region ap-southeast-1

#Tạo cluster = KOPS command  (chạy nháp xem trước cấu hình)
kops create cluster --name viettu.id.vn --state=s3://kops-stage-s3-bucket --zones=ap-southeast-1a,ap-southeast-1c --node-count=2 --node-size=t3.small --master-size=t3.small --dns-zone viettu.id.vn --node-volume-size=10 --master-volume-size=10

#Apply thay đổi thực sự:
kops update cluster --name viettu.id.vn --state=s3://kops-stage-s3-bucket --yes --admin

#Validate cluster: (kiểm tra trạng thái)
kops validate cluster --name viettu.id.vn --state=s3://kops-stage-s3-bucket --wait 10m

#getnode:
kubectl get nodes

#output as below is OK
NODE STATUS
NAME                    ROLE            READY
i-03ee28b8c4c2fd0cb     node            True
i-04b3c3d35f590fc60     control-plane   True
i-0cdc0ec740ecf6504     node            True

#kiểm tra Kubenetes config file được tạo ra:
cat ~/.kube/config # file này chứa credential để ta có thẻ thao tác với kube cluster có tên là 
# name: viettu.id.vn
# contexts:
# - context:
#     cluster: viettu.id.vn
#     user: viettu.id.vn
#   name: viettu.id.vn
# current-context: viettu.id.vn

#***************Copy các item trong config và paste vào file ~/.kube/config trên máy local.
#Đối với Windows: C:\Users\{username}\.kube\config


#1. Thiết lập Context
kubectl config use-context my-context

#2. Kiểm Tra Context Hiện Tại
kubectl config current-context

#3. Danh Sách Các Context
kubectl config get-contexts

#5. Xóa Một Context
kubectl config delete-context my-context



#Kiểm tra thông tin cluster:
kubectl cluster-info
kubectl get nodes



#LƯU Ý: Xoá Cluster nếu không sử dụng đến để tránh tốn phí:
kops delete cluster --name viettu.id.vn --state=s3://kops-stage-s3-bucket --yes



#Apply thay đổi thực sự: (Vì token sẽ hết hạn sau 48 tiếng lên chạy lệnh update cluster này để cập nhật token file ~/.kube/config giá trị mới )
kops update cluster --name viettu.id.vn --state=s3://kops-stage-s3-bucket --yes --admin