**Deploying MongoDB and Mongo-Express on Kubernetes using Minikube, including secret, configmap, internal and external service**

In this post, we’ll be guiding you through the process of deploying a Mongo-Express application on Kubernetes using Minikube and Hyper-V, including all the services we need to interact with the mongoDB server and mongo-express through browser. We’ll start by providing a brief introduction to Kubernetes, Minikube, and Hyper-V before diving into the detailed steps required for deployment. By the end of this blog, you’ll have a solid understanding of how to deploy your own applications on Kubernetes using these tools.

We are going to deploy two applications, MongoDB and Express, which demonstrates a typical simple setup of a web application and its database. First, we will create a MongoDB pod and an internal service that only allows components inside the same cluster to talk to it. Then we’ll create an Express deployment and pass the database URL and credentials through environmental variables in its deployment configuration file. We’ll also create a config map containing the database URL and a secret containing the credentials, which we’ll reference in the deployment file. Next, we’ll create an external service to allow external requests to talk to the Express pod. With this setup, the request flow will be from the browser to the external service of Express, which will forward it to the Express pod. The pod will then connect to the internal service of MongoDB to authenticate the request using the credentials.”

*Table of Contents:*
Overview of Kubernetes, Minikube, and Hyper-V
Installing and Configuring Minikube and Hyper-V
Preparing and Deploying the MongoDB
Configuration and Deployment of Secret Service
Configuration and Deployment of Internal Service
Configuration and Deployment of Configmap
Configuration and Deployment of Mongo-express
Configuration and Deployment of external service

*Conclusion*
1. Overview of Kubernetes, Minikube, and Hyper-V
Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. Minikube is a tool that allows you to run Kubernetes locally, simplifying the process of deploying and testing applications. Hyper-V is a virtualization technology developed by Microsoft, enabling you to create and run virtual machines on your personal computer.

2. Installing and Configuring Minikube and Hyper-V
Before we begin, ensure that you have the following prerequisites installed on your PC:

Windows 10 Pro or Enterprise
Hyper-V
kubectl
Minikube
Refer to the official documentation for detailed instructions on installing and configuring these tools.

After configuration, start follwing these steps

a. Start Cluster using minikube

minikube start –-vm-driver=hyperv
Output would be, (if kubectl not found, copy the kubectl.exe file into current directory)

Press enter or click to view image in full size

b. Check status of the cluster, make sure everything is running and configured

minikube status
Press enter or click to view image in full size

c. Check nodes using kubectl, make sure the status should be ready

kubectl get nodes
Press enter or click to view image in full size

3. Preparing and Deploying the Mongodb
To create a MongoDB deployment, Copy the following code into an editor such as Visual Studio Code and save it “mongoDB-config.yaml”. This is how the deployment file for MongoDB will look like and save it

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-deployment
  labels:
    app: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo
        ports:
        - containerPort: 27017
        env:
        - name: MONGO_INITDB_ROOT_USERNAME
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-username
        - name: MONGO_INITDB_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-password
This is a YAML file that describes the MongoDB deployment in Kubernetes. It defines the desired state of the deployment, including the number of replicas to maintain, how to identify which pods the deployment manages, and the template for creating new pods. The file specifies the container specification for the pod, including the container image to use and the ports the container listens to. It also sets environment variables for the container, retrieved from a secretKeyRef. The YAML file is used to create a MongoDB pod in Kubernetes that can be accessed by other components of the web application.

Get Syed Muhammad Ibtisam’s stories in your inbox
Join Medium for free to get updates from this writer.

Enter your email
Subscribe
Next, we need to store username and password, for that we will be using “secret ”service and we have to create and deploy it before the creation of mongoDB deployment.

4. Configuration and Deployment of Secret Service
Press enter or click to view image in full size

We’re going to create the secret where the root username and password will be placed. So let’s create a new file with the name “mongoDB-secret.yaml” and paste the following code, which is actually pretty simple.

apiVersion: v1
kind: Secret
metadata:
    name: mongodb-secret
type: Opaque
data:
    mongo-root-username:
    mongo-root-password:
We have a kind secret, metadata with the name of the secret, and type opaque which is actually a default type that is the most basic key-value secret type. Other types, for example, include TLS certificates, so you can create a secret specifically with the TLS certificate type and a couple of more types, but mostly you’re going to use the default one. These are the actual contents, so you have the data and here you have key-value pairs, which of course, are the names you come up with. We’re going to specify the root username and password. Here’s the thing, the values in these key-value pairs are not plain text, so when we are creating a secret, the value must be base64 encoded. We can do that by using the commands below,

echo -n 'username' | base64
echo -n 'password' | base64
Place the result of these commands into mongoDB-secret.yaml file. Lets now deploy the secret service first.

Deploying Secret Service
kubectl apply -f mongoDB-secret.yaml
Now it can be reference in deployment file

Deploying mongodb deployment
kubectl apply -f mongoDB-config.yaml
Now we will create internal service so that other components/pods can talk to this mongodb

5. Configuration Deployment of Internal Service
We will create the service configuration for MongoDB in the same YAML file. In YAML, multiple documents can be included in one file by using three dashes for document separation. Append the following code into “mongoDB-config.yaml” file and save.

---
apiVersion: v1
kind: Service
metadata:
  name: mongodb-service
spec:
  selector:
    app: mongodb
  ports:
    - protocol: TCP
      port: 27017
      targetPort: 27017
The selector is important because it connects the service to the pod, and the labels allow the service to find the parts that it will attach to. The service port is exposed, and the target port is the container or pod port. Now deploy “mongoDB-config.yaml”, it will automatically update the pod

kubectl apply -f mongoDB-config.yaml
Now check the services by using the command

kubectl get service

Now what we left is configmap, mongo-express and its external service

Press enter or click to view image in full size

Before mongo-express deployment file, we have to create configmap service so that we can reference the URL in the mongo-express so for that we have to create a separate file

6. Configuration and Deployment of Configmap
Create file with the name “mongo-configmap.yaml”, paste the following code and save it.

apiVersion: v1
kind: ConfigMap
metadata:
  name: mongodb-configmap
data:
  database_url: mongodb-service
Now deploy by using the command

kubectl apply -f mongo-configmap.yaml
7. Configuration and Deployment of Mongo-express
Create a file with the name “mongo-express.yaml”, paste the following code and save it

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongo-express
  labels:
    app: mongo-express
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongo-express
  template:
    metadata:
      labels:
        app: mongo-express
    spec:
      containers:
      - name: mongo-express
        image: mongo-express
        ports:
        - containerPort: 8081
        env:
        - name: ME_CONFIG_MONGODB_ADMINUSERNAME
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-username
        - name: ME_CONFIG_MONGODB_ADMINPASSWORD
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-password
        - name: ME_CONFIG_MONGODB_SERVER
          valueFrom:
            configMapKeyRef:
              name: mongodb-configmap
              key: database_url
Three environmental variables are needed for Express: the MongoDB address, admin username, and admin password. These are added to the configuration file, with the MongoDB address being an external configuration that can be included in a config map created before. Now deploy it by using the command

kubectl apply -f mongo-express.yaml
Now check that all the pods are listening by using the following command

kubectl get pods

Now final step to access from the browser and to do that, we need to create external service for mongo-express.

8. Configuration and Deployment of external service
Append the following code into “mongo-express.yaml” same as we do previously and save it.

---
apiVersion: v1
kind: Service
metadata:
  name: mongo-express-service
spec:
  selector:
    app: mongo-express
  type: LoadBalancer  
  ports:
    - protocol: TCP
      port: 8081
      targetPort: 8081
      nodePort: 30000
Overall, this YAML configuration is used to create a Service object in Kubernetes that allows external traffic to access the Express application using the specified port. The LoadBalancer type ensures that the external traffic is distributed across the pods, making the application highly available. The nodePort field ensures that the service is exposed on a specific node port, which can be useful in certain situations.

Now after changing the file, deploy it again to make the changes in the cluster

kubectl apply -f mongo-express.yaml
Now get all the pods to see the IP and ports

Kubectl get pods
