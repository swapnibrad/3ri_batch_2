# student3tier — 3-tier Helm practical (Web → Tomcat → MariaDB)

## Overview
This repo contains everything to deploy a 3-tier application:
- Web: Apache httpd static form (index.html)
- App: Tomcat running a Java servlet to insert student data into MariaDB
- DB: MariaDB with init SQL creating the `students` table

Data: name, contact_number, address, created_at (timestamp), id (auto-increment)

## Architecture flow
User Browser -> LoadBalancer (student-web) -> index.html -> POST -> Tomcat (student-app) -> MariaDB (student-db)

## Prerequisites
- Kubernetes cluster with LoadBalancer support (EKS, GKE, AKS) OR minikube with `minikube tunnel`
- kubectl configured
- helm v3
- Docker
- AWS CLI configured (if pushing to ECR)
- Maven (for local build of app WAR if needed)

## Files
(see project layout)

## Build & push images to AWS ECR
1. Create ECR repos:
   aws ecr create-repository --repository-name student-web --region <region>
   aws ecr create-repository --repository-name student-app --region <region>

2. Login:
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com

3. Build & push:
   # web
   cd web
   docker build -t student-web:latest .
   docker tag student-web:latest <ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/student-web:latest
   docker push <ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/student-web:latest

   # app
   cd ../app
   docker build -t student-app:latest .
   docker tag student-app:latest <ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/student-app:latest
   docker push <ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/student-app:latest

4. Update `values.yaml` image fields to the ECR URIs.

## Secrets
Edit `values.yaml` to set DB root password and user credentials. The chart will create a Kubernetes Secret.

## Install helm chart
helm upgrade --install student3tier ./student3tier -n student --create-namespace

## Access frontend
kubectl get svc student-web -n student
- If EXTERNAL-IP assigned, open http://<EXTERNAL-IP> in browser.
- If using NodePort, open http://<node-ip>:<nodePort>.

## Verify DB entries
From a pod with mysql client or by port-forward:
kubectl port-forward deployment/student-db 3306:3306 -n student
Then connect with your favorite mysql client:
mysql -h 127.0.0.1 -P 3306 -u <user> -p<password> <database>
select * from students;

## Common troubleshooting
- EXTERNAL-IP pending: cluster does not support cloud LoadBalancer. Use NodePort or `minikube tunnel`.
- CORS or cross-domain POST issues: enable CORS in servlet, or proxy from web server.
- DB init only runs when MySQL data directory is empty — if schema not created, delete PVC to reinitialize (careful: destroys data).

## Clean up
helm uninstall student3tier -n student
kubectl delete pvc student-db-pvc -n student
