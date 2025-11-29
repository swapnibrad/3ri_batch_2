🚀 Install the Chart

From inside the directory containing nginx-chart/:

helm install mynginx ./nginx-chart


Check deployment:

kubectl get deploy
kubectl get pods

♻️ Upgrade chart
helm upgrade mynginx ./nginx-chart

❌ Uninstall chart
helm uninstall mynginx