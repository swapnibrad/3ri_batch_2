# tomcat-3tier Helm Chart


## Install
1. (Optional) add nginx ingress controller to your cluster (if not installed):
- use `helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace`


2. Install the chart:

helm install my-tomcat ./tomcat-3tier-chart --set ingress.host=tomcat.example.com

3. To upgrade after changing image tag or values:

helm upgrade my-tomcat ./tomcat-3tier-chart --set image.tag=9-jdk11

4. To uninstall:

helm uninstall my-tomcat
Notes for AWS EKS

If using private ECR images, ensure nodes have IAM permissions or use imagePullSecrets.

The StatefulSet will create EBS volumes via the cluster default StorageClass unless overridden.

For production use consider running MariaDB as a managed RDS/Aurora for HA.

*The chart above provides a templated, reusable Helm package for deploying the 3-tier Tomcat architecture to Kubernetes/EKS.*