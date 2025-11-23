1️⃣ Create a Node.js app
2️⃣ Build a Docker image
3️⃣ Push it to Amazon ECR
4️⃣ Use that ECR image in your Kubernetes Deployment (AWS EKS)

This is the standard DevOps workflow.

✅ STEP 1 — Create a Node.js Application
Create a file named app.js:

const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hello from Node.js on AWS EKS using ECR image!\n");
});

server.listen(3000, () => {
  console.log("Server started on port 3000");
});

✅ STEP 2 — Create a Dockerfile
Create a file named Dockerfile in the same folder:

FROM node:16-alpine
WORKDIR /app
COPY app.js .
EXPOSE 3000
CMD ["node", "app.js"]

⚙️ STEP 3 — Build Docker Image
docker build -t nodejs-app:v1 .
Verify image:
docker images

🔐 STEP 4 — Create an ECR Repository
aws ecr create-repository --repository-name nodejs-app
It will return something like:
123456789012.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app

Save this value as:
ECR_REPO=123456789012.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app

🔑 STEP 5 — Authenticate Docker to ECR
aws ecr get-login-password --region ap-southeast-1 \
| docker login --username AWS --password-stdin 659474939385.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-batch

📦 STEP 6 — Tag the Docker Image
docker tag nodejs-app:v1 $ECR_REPO:v1

🚀 STEP 7 — Push to ECR
docker push $ECR_REPO:v1


You now have:
123456789012.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app:v1

Use this inside Kubernetes.

🎯 STEP 8 — Update Your Deployment YAML

Your deployment.yaml should look like this:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-deployment
  labels:
    app: nodejs-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
        - name: nodejs
          image: 123456789012.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app:v1
          ports:
            - containerPort: 3000

🚀 STEP 9 — Apply Deployment in AWS EKS
kubectl apply -f deployment.yaml


Check pods:
kubectl get pods

Check logs:
kubectl logs -l app=nodejs-app

You should see:
Server started on port 3000

🌍 STEP 10 — Access Using Service + Ingress (if configured)
Your Node.js app will now run from the ECR image!

🎉 DONE!