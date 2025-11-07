# Template API

A Rails 8.1 API for managing Companies, Projects, Users, and Tasks.

## Models and Relationships

### Company
- **Attributes**: `name`
- **Relationships**: has many Projects

### Project
- **Attributes**: `name`, `company_id`
- **Relationships**: 
  - belongs to one Company
  - has many Users (through ProjectUsers)
  - has many Tasks

### User
- **Attributes**: `name`, `email`
- **Relationships**: 
  - has many Projects (through ProjectUsers)
  - has many Tasks

### Task
- **Attributes**: `category`, `project_id`, `user_id`
- **Relationships**: 
  - belongs to one Project
  - belongs to one User

### ProjectUser (Join Table)
- Manages the many-to-many relationship between Projects and Users

## Setup

### Prerequisites

- Ruby 3.4.6
- PostgreSQL 13 or higher

### Installation

1. Install dependencies:
```bash
bundle install
```

2. Configure your database:
   - For development, ensure PostgreSQL is running locally
   - The app will connect using default PostgreSQL settings (localhost:5432)
   - No username/password required for local development (uses system user)

3. Create and migrate the database:
```bash
bin/rails db:create
bin/rails db:migrate
```

4. (Optional) Seed the database with sample data:
```bash
bin/rails db:seed
```

This will create:
- 4 Companies
- 8 Projects (2 per company)
- 10 Users with realistic names and emails
- 30+ Tasks distributed across projects
- Multiple user-project assignments (many-to-many relationships)

5. Start the server:
```bash
bin/rails server
```

## API Endpoints

### Companies
- `GET /companies` - List all companies
- `GET /companies/:id` - Show a company
- `POST /companies` - Create a company
  - Body: `{ "company": { "name": "Company Name" } }`
- `PATCH/PUT /companies/:id` - Update a company
- `DELETE /companies/:id` - Delete a company

### Projects
- `GET /projects` - List all projects (includes company)
- `GET /projects/:id` - Show a project (includes company and users)
- `POST /projects` - Create a project
  - Body: `{ "project": { "name": "Project Name", "company_id": 1 } }`
- `PATCH/PUT /projects/:id` - Update a project
- `DELETE /projects/:id` - Delete a project

### Project Users (Many-to-Many)
- `POST /projects/:project_id/users` - Add a user to a project
  - Body: `{ "user_id": 1 }`
- `DELETE /projects/:project_id/users/:id` - Remove a user from a project

### Users
- `GET /users` - List all users
- `GET /users/:id` - Show a user (includes projects)
- `POST /users` - Create a user
  - Body: `{ "user": { "name": "User Name", "email": "user@example.com" } }`
- `PATCH/PUT /users/:id` - Update a user
- `DELETE /users/:id` - Delete a user

### Tasks
- `GET /tasks` - List all tasks (includes project and user)
- `GET /tasks/:id` - Show a task (includes project and user)
- `POST /tasks` - Create a task
  - Body: `{ "task": { "category": "Development", "project_id": 1, "user_id": 1 } }`
- `PATCH/PUT /tasks/:id` - Update a task
- `DELETE /tasks/:id` - Delete a task

## Ruby version

Ruby 3.4.6

## Database

PostgreSQL (development/test/production)

### Database Configuration

- **Development**: `template_api_development`
- **Test**: `template_api_test`
- **Production**: `template_api_production`

For production deployment with Kamal, the PostgreSQL database is configured as an accessory service. See `config/deploy.yml` for details.

## Testing

Run the test suite:
```bash
bin/rails test
```
