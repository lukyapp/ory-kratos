# Development Environment Setup

This guide will help you set up a complete development environment for Ory Kratos with PostgreSQL.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git

## Quick Start

1. **Clone and navigate to the project:**
   ```bash
   git clone <repository-url>
   cd ory-kratos/dev
   ```

2. **Start the services:**
   ```bash
   docker-compose up -d
   ```

3. **Check that everything is running:**
   ```bash
   docker-compose ps
   ```

## Services

The setup includes:

- **PostgreSQL** (port 5432): Database for Kratos
- **Kratos Public API** (port 4433): Public endpoints for authentication flows
- **Kratos Admin API** (port 4434): Admin endpoints for management

## Access Points

- **Public API**: http://localhost:4433
- **Admin API**: http://localhost:4434
- **Database**: localhost:5432 (user: kratos, password: password, database: kratos)

## Test Kratos

Open your browser and navigate to:
```
http://localhost:4433/self-service/login/browser
```

## Environment Variables

The `.env` file contains all necessary configuration. Key variables:

- `COOKIE_SECRET` & `CIPHER_SECRET`: Security secrets (auto-generated)
- `PAGINATION_SECRET`: Secret used to protect pagination cursors
- `DSN`: Database connection string
- `KRATOS_PUBLIC_URL`: Public URL for Kratos
- `SELF_SERVICE_UI_URL`: URL for your frontend application
- `DOMAIN_COOKIE`: Cookie scoping and SameSite behavior

## Google OAuth Setup (Optional)

If you want to enable Google OAuth:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add your redirect URI: `http://localhost:4433/self-service/methods/oidc/callback/google`
6. Update `.env` with your client ID and secret

## Useful Commands

**View logs:**
```bash
docker-compose logs -f kratos
```

**Stop services:**
```bash
docker-compose down
```

**Reset everything (including database):**
```bash
docker-compose down -v
```

**Run database migrations manually:**
```bash
docker-compose run --rm kratos-migrate
```

**Access Kratos CLI:**
```bash
docker-compose exec kratos kratos --help
```

## Development Workflow

1. Make changes to configuration files
2. Restart services: `docker-compose restart kratos`
3. Check logs for any errors
4. Test your changes via the browser or API

## Troubleshooting

**Port conflicts:** If ports 4433, 4434, or 5432 are in use, modify them in `docker-compose.yml`

**Database connection issues:** Ensure PostgreSQL is healthy before Kratos starts

**Migration failures:** Check the database connection string and permissions

## File Structure

```
dev/                          # Development environment
├── docker-compose.yml        # Docker services configuration
├── .env                      # Environment variables
├── DEV_SETUP.md             # This setup guide
└── ../                       # Parent directory contains:
    ├── Dockerfile           # Kratos container build
    ├── kratos.yml.tmpl      # Kratos configuration template
    ├── entrypoint.sh        # Container entry point script
    ├── identity.schema.json # Identity schema definition
    └── mappers/             # OAuth identity mappers
        └── google.jsonnet
```
