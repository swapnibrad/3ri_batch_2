====  3-tier Architecture  ====

📌 1. Project Overview (Real-World Explanation)
    This project is a 3-tier enterprise application commonly used in banking, e-commerce, and healthcare platforms.
    It follows a structured architecture divided into:

        Web Tier (Presentation Layer)
        Application Tier (Business Logic Layer)
        Database Tier (Data Storage Layer)
            Each layer is load-balanced, ensuring high availability & zero downtime.

📌 2. Layer-by-Layer Explanation
    🔵 Layer 1: Web Server Layer (Presentation Layer)
            This is the entry point for users.
            Hosted behind an AWS Application Load Balancer (ALB).
            ALB distributes HTTP/HTTPS traffic across web servers.

    🟠 Layer 2: Application Server Layer (Business Logic)
            Receives traffic from the Web Layer
            Hosted behind a Network Load Balancer (NLB)
            Runs backend logic
            Designed for high performance
            Communicating with DB Layer

    🟣 Layer 3: Database Layer (Storage Layer)
        ✔ Primary Database Instance
            Handles read/write traffic
            Stores all system data
        ✔ Standby Database Instance (DR / High Availability)
            Used for failover
            DB Types:
            AWS RDS (MySQL/PostgreSQL)
                Responsibilities:
                Store persistent application data
                Ensure durability & integrity
                Provide backup & restore capabilities

📌 3. Architecture Diagram (ASCII)


📌 4. DevOps & Tooling Used
		CI/CD Pipeline
			Jenkins builds and deploys the application
			Infrastructure created using Terraform
			Code stored in Bitbucket / GitHub / GitLab
			Artifacts stored in JFrog Artifactory
			Static code analysis using SonarQube
        Monitoring
            Datadog / CloudWatch
            Monitors CPU, Memory, Disk, Load Balancers, DB replication
        Alerting
            Email / Slack / PagerDuty alerts for failures

📌 5. Issue Faced & Solution
        Issue:
            During peak traffic, some application servers became overloaded.
            ALB distributed load evenly to the web layer,
            but the App layer NLB forwarded heavy bursts to fewer healthy instances.

        This caused:
            Slow response times
            Service unavailability
            DB connection overload
            Solution Implemented:
            Enabled Auto Scaling for Application Layer
            CPU, memory-based scaling
            Dynamic EC2/ECS instance launch
            Health checks improved
            Unhealthy nodes removed instantly
            Connection pooling optimized
            Reduced DB overload
            Enabled Read Replicas (optional)
            For reporting and analytics

📌 6. Points to Explain
		This is a 3-tier enterprise application.
		Traffic flows from ALB → Web Tier → NLB → App Tier → Primary DB.
		Standby DB ensures high availability & disaster recovery.
		Load balancers ensure zero downtime and scalability.
		DevOps tools automate build, deployment, infrastructure, and monitoring.
		Scalability & high availability are the main benefits of this architecture.
		Real issue: App layer overload during spikes.
		Solution: Auto-Scaling, improved health checks, optimized DB pooling.