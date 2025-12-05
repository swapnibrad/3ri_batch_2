# ▶️ 1. Build & Start the Microservices
Step 1 — Build & run
## docker compose up -d --build

Step 2 — Check running containers
## docker compose ps

Expected Output:
nginx-gateway  running
api-service    running
mongodb        running

# 📜 2. Verify Each Microservice
🔍 Check API Logs
## docker compose logs api -f


You should see:

MongoDB Connected
API running on port 3000

🔍 Check Mongo Logs
## docker compose logs mongo


Should show:

init.js executed

🔍 Nginx Logs
## docker compose logs nginx

# 🧪 3. Test With # curl (Complete Testing)
✅ 1. Test Through Nginx Gateway
Check API root
## curl http://localhost/

Expected:
Node.js API is Running!

✅ 2. Insert User Into MongoDB
## curl -X POST http://localhost/user  -H "Content-Type: application/json"  -d '{"name":"Swapnil","email":"swapnil@example.com"}'

Expected:
{"message":"User created","data":{...}}

✅ 3. Get All Users
## curl http://localhost/users


Expected:

[
  {"_id":"...","name":"admin","email":"admin@example.com"},
  {"_id":"...","name":"Swapnil","email":"swap@example.com"}
]

# 🛑 4. Stop & Remove Services
Stop
## docker compose stop

Remove
## docker compose down

🔁 Restart Services
## docker compose restart

🧹 Cleanup Completely
## docker compose down --volumes --rmi all