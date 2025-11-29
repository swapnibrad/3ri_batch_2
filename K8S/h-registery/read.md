***Deploy Web Server Using an Existing Helm Repository (Bitnami Apache)***

Bitnami provides a ready-to-use Apache Web Server Helm chart.

Step 1 — Add Bitnami Repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

Step 2 — Install Apache Web Server on EKS
helm install my-web bitnami/apache
    (This deploys a running web server with a default page.)

Step 3 — Check Pods
kubectl get pods

You should see something like:
    my-web-apache-xxxx Running

Step 4 — Get Service
Bitnami Apache uses LoadBalancer on cloud clusters like EKS:
    kubectl get svc

Example output:
    my-web-apache  LoadBalancer  EXTERNAL-IP   <pending>|34.xxx.xxx.xxx

Once you get the EXTERNAL-IP, open it in your browser:
🌐 Browser URL
http://<EXTERNAL-IP>
You will see the Apache welcome page.

*** Install with Custom Homepage ***

You can provide your own index.html using a values override.
Create a file:

values.yaml
    content:
    index.html: |
        <html>
        <body style="font-family:Arial;">
            <h1>Hello from Helm on EKS!</h1>
            <p>This is a custom web page deployed using Bitnami Apache.</p>
        </body>
        </html>

Install using:
    helm install my-web bitnami/apache -f values.yaml