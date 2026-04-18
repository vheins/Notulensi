# Example Output: environment-setup

**Expected Output Shape:**
```
Prerequisites:
- Node.js 20+ (brew install node / apt install nodejs)
- PostgreSQL 15+ (brew install postgresql@15 / apt install postgresql-15)
- Redis 7+ (brew install redis / apt install redis-server)
- npm 10+ (included with Node.js)

Setup Script (setup.sh):
#!/bin/bash
set -e

echo "🔧 Setting up development environment..."

# Install dependencies
npm install

# Copy env file
if [ ! -f .env ]; then
  cp .env.example .env
  echo "⚠️  .env created — please fill in DATABASE_URL and JWT_SECRET before continuing"
  exit 1
fi

# Run database migrations
npm run db:migrate

# Seed development data
npm run db:seed

# Verify services
node -e "require('./src/health').check()" && echo "✅ Setup complete"

.env.example:
# Server
PORT=3000
NODE_ENV=development

# Database — replace with your local PostgreSQL credentials
DATABASE_URL=postgresql://postgres:password@localhost:5432/ecommerce_dev

# Redis — default local Redis, no auth needed in dev
REDIS_URL=redis://localhost:6379

# Auth — CHANGE THIS: generate with: openssl rand -base64 32
JWT_SECRET=CHANGE_ME_generate_with_openssl_rand_base64_32
JWT_EXPIRES_IN=7d

README Getting Started:


**Expected Output Shape:**
```
Prerequisites:
- Python 3.11+ (brew install python / winget install Python.Python.3.11)
- MySQL 8+ (brew install mysql / Docker recommended)
- Docker Desktop (docker.com/products/docker-desktop)
- pip + virtualenv

Setup Steps:
1. python -m venv .venv && source .venv/bin/activate
2. pip install -r requirements.txt
3. cp .env.example .env && fill in DB credentials
4. docker compose up -d mysql
5. alembic upgrade head
6. uvicorn app.main:app --reload

Verification:
- curl http://localhost:8000/health → {"status": "ok"}
- mysql -u root -p analytics_db -e "SHOW TABLES;"
```
