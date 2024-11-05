
# Get all namespace
kubectl get namespaces

# Create a new namespace
kubectl create namespace demo-namespace

# Set the namespace for the current context => set namespace default, when create prod not specify namespace then default namepase set demo-namespace
kubectl config set-context --current --namespace=demo-namespace

#Get current namespace
kubectl config view --minify | grep namespace:

#set default
kubectl config set-context --current --namespace=default