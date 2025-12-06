====  Microservices-Based 3-Tier Application  ====

✅ 1. Project Overview 
	This system is a microservices-driven web application deployed on Kubernetes, built using a 3-tier architecture:
		Web Tier → React/Angular/Node (frontend container)
		App Tier → Microservices (API layer)
		Database Tier → MongoDB (Stateful backend)

	Kubernetes handles:
		Orchestration
		Scaling
		Load balancing
		Service discovery
		Config & secrets management
		Docker is used for:
		Building images
		Packaging microservices

✅ 2. Tier-by-Tier Architecture Breakdown
		🟦 Tier 1 — Web Server Layer (Frontend)
				React/Angular/Vue application containerized using Docker
				Deployed on K8s Deployment
				Exposed via K8s Service (NodePort / LoadBalancer)
			K8s Components Used
			Deployment → maintains pods for frontend
			ReplicaSet → ensures number of frontend pods
			Service → exposes frontend to users
			ConfigMap → stores UI config (API URL)

		🟧 Tier 2 — Application Layer (Microservices)
				Multiple microservices (Auth, Orders, Payments, Users, etc.)
				Each service packaged as a separate Docker image
				Each microservice has its own Deployment, Service, ConfigMap, and Secrets
			K8s Components Used
			Deployment → runs pods for each microservice
			ReplicaSet → maintains replication
			Service (ClusterIP) → internal communication
			ConfigMap → environment configs (API keys, URLs, configs)
			Secrets → passwords, tokens, DB credentials
			Horizontal Pod Autoscaler → optional auto scaling

		🟩 Tier 3 — Database Layer (MongoDB)
				MongoDB is deployed as:
				StatefulSet (for stable network identity)
				Persistent Volume Claim (PVC)
				Persistent Volume (PV)
			K8s Components Used
			StatefulSet → maintains stable MongoDB instances
			Service (Headless) → internal access
			Secrets → store DB username/password
			PVC + PV → permanent data storage

✅ 3. Complete Kubernetes Architecture Diagram (ASCII)


✅ 4. DevOps Pipeline (CI/CD)
		Tools Used
			Stage	        Tool
			Code Repo   => 	Bitbucket / GitHub
			Build	    =>  Maven / Node / Docker
			CI/CD	    =>  Jenkins
			Security    =>	SonarQube
			Image Registry	 => JFrog Artifactory / DockerHub
			Infra Automation =>	Terraform
			Monitoring	=>  Prometheus + Grafana / Datadog
		Pipeline Steps
			Developer pushes code → Bitbucket
			Jenkins triggers pipeline
			SonarQube checks code quality
			Docker image is built
			Image stored in Artifactory
			Terraform deploys infra to K8s
			Jenkins applies manifests → Deployments, Services, Secrets
			Datadog monitors containers

✅ 5. Real Issue Faced in Production
		Issue:
			Microservices were crashing due to incorrect configuration values, especially in dev/QA:
			Wrong API URLs
			Missing database passwords
			Hardcoded values in code
			Secrets exposed accidentally
		This caused:
			Failed pod startups
			500 errors from backend
			Service-to-service communication failure

✅ 6. Solution Implemented
	✔ Centralized Configuration with K8s ConfigMaps & Secrets
		Instead of hardcoding configs:
		All external config stored in ConfigMaps
		All sensitive data moved into Secrets
		Services load configs dynamically
	Benefits:
		No need to rebuild images after config changes
		Secure secret management
		Easy switching of environments (dev/qa/prod)
		Zero-downtime deployments