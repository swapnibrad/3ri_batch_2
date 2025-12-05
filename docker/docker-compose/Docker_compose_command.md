# 🟢 1. Start Services
Start containers in background
docker compose up -d

Start with fresh rebuild
docker compose up -d --build

Start interactively (see logs)
docker compose up

# 🔴 2. Stop Services
Stop containers
docker compose stop

Stop and remove containers
docker compose down

Remove everything (containers + volumes + networks + images)
docker compose down --volumes --rmi all

# 🔁 3. Restart Services
Restart specific service
docker compose restart api

Restart all services
docker compose restart

# 📦 4. Build Images
Build all services
docker compose build

Build specific service
docker compose build api

# 📄 5. Check Status
List running services
docker compose ps

Show container processes
docker compose top

# 📡 6. View Logs
Logs for all services
docker compose logs

Follow logs (live view)
docker compose logs -f

Logs for a specific service
docker compose logs api

# 🧪 7. Execute Commands in Service Containers
Open shell inside a running service
docker compose exec api sh


(or bash if installed)

Run one command
docker compose exec api ls /app

Run command in stopped container (one-time run)
docker compose run api node server.js

# 🧹 8. Clean Up
Remove stopped containers
docker compose rm

Force remove containers
docker compose rm -f

# 🧰 9. Additional Useful Commands
View service configuration
docker compose config

Validate docker-compose.yml
docker compose config --validate

Show images used by compose
docker compose images

Show networks
docker compose networks

# ⭐ Bonus: Multi-file Compose
Use an override file
docker compose -f docker-compose.yml -f prod.yml up -d