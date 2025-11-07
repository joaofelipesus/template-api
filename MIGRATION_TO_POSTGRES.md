# Migration from SQLite to PostgreSQL

This document outlines the changes made to migrate the application from SQLite to PostgreSQL.

## Changes Made

### 1. Gemfile
- Replaced `sqlite3` gem with `pg` gem (PostgreSQL adapter)

### 2. Database Configuration (`config/database.yml`)
- Changed adapter from `sqlite3` to `postgresql`
- Updated database names:
  - Development: `template_api_development`
  - Test: `template_api_test`
  - Production: `template_api_production`
- Added PostgreSQL-specific configuration (host, port, username, password)
- Production uses environment variables for connection details

### 3. Dockerfile
- Replaced `sqlite3` package with `postgresql-client`
- Added `libpq-dev` for building the pg gem

### 4. Kamal Deployment (`config/deploy.yml`)
- Added PostgreSQL as an accessory service using `postgres:17` image
- Configured environment variables for database connection
- Added persistent volume for PostgreSQL data
- Removed SQLite-specific volume configuration

### 5. Kamal Secrets (`.kamal/secrets`)
- Added `DATABASE_PASSWORD` for Rails app
- Added `POSTGRES_PASSWORD` for PostgreSQL container

## Next Steps

### For Local Development

1. **Install PostgreSQL** (if not already installed):
   ```bash
   # macOS with Homebrew
   brew install postgresql@17
   brew services start postgresql@17
   
   # Ubuntu/Debian
   sudo apt-get install postgresql postgresql-contrib
   sudo systemctl start postgresql
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Create and migrate the database**:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

4. **Seed the database** (optional):
   ```bash
   bin/rails db:seed
   ```

5. **Start the server**:
   ```bash
   bin/rails server
   ```

### For Production Deployment with Kamal

1. **Set up environment variables**:
   Before deploying, ensure you have set the following environment variables or update `.kamal/secrets`:
   ```bash
   export DATABASE_PASSWORD="your-secure-password"
   export POSTGRES_PASSWORD="your-secure-password"
   ```

2. **Deploy the PostgreSQL accessory**:
   ```bash
   bin/kamal accessory boot db
   ```

3. **Deploy the application**:
   ```bash
   bin/kamal deploy
   ```

4. **Run migrations on production**:
   ```bash
   bin/kamal app exec "bin/rails db:migrate"
   ```

## Database Connection Details

### Development
- Host: localhost (or via Unix socket)
- Port: 5432 (default)
- Database: `template_api_development`
- User: Your system user (no password required by default)

### Production
- Host: Set via `DATABASE_HOST` environment variable (default: 192.168.0.1)
- Port: Set via `DATABASE_PORT` environment variable (default: 5432)
- Database: `template_api_production`
- User: Set via `DATABASE_USER` environment variable (default: template_api)
- Password: Set via `DATABASE_PASSWORD` environment variable (required)

## Troubleshooting

### Connection Issues in Development

If you encounter connection issues:

1. Ensure PostgreSQL is running:
   ```bash
   # macOS
   brew services list
   
   # Linux
   sudo systemctl status postgresql
   ```

2. Check if you can connect manually:
   ```bash
   psql -U $(whoami) -d postgres
   ```

3. If needed, create a PostgreSQL user:
   ```bash
   createuser -s $(whoami)
   ```

### Production Deployment Issues

1. Check if the PostgreSQL accessory is running:
   ```bash
   bin/kamal accessory details db
   ```

2. Check database logs:
   ```bash
   bin/kamal accessory logs db
   ```

3. Verify environment variables are set correctly:
   ```bash
   bin/kamal app exec "env | grep DATABASE"
   ```

## Rollback Instructions

If you need to rollback to SQLite:

1. Revert the Gemfile changes
2. Revert `config/database.yml`
3. Revert the Dockerfile
4. Revert `config/deploy.yml`
5. Run `bundle install`
6. Recreate the SQLite databases with `bin/rails db:create db:migrate`

## Notes

- All existing migrations are compatible with PostgreSQL
- No schema changes were required
- The application code remains unchanged
- Active Storage files are still stored in the `/rails/storage` volume

