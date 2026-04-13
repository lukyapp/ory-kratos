# Ory Kratos Authentication Server

A containerized deployment setup for **Ory Kratos**, providing secure user authentication and identity management.

Instead of building authentication flows from scratch, this project helps you run Kratos quickly with Docker and PostgreSQL, leveraging all the built-in capabilities maintained by the Ory team.

👉 Official documentation: https://www.ory.com/docs/kratos
## 🚀 Features

This setup allows you to easily deploy and configure **Ory Kratos**, benefiting from its core features, including:

- **User Authentication & Registration**  
  Secure login, signup, and account recovery flows

- **Social Login Support**  
  Integration with external identity providers such as Google OAuth 2.0

- **Session Management**  
  Secure session handling with cookie-based authentication

- **RESTful APIs**  
  Public and admin endpoints for identity and session management

- **PostgreSQL Backend Integration**  
  Reliable persistence for identities, credentials, and sessions

- **Docker & Docker Compose Ready**  
  Containerized environment for local development and production deployment

- **Environment-Based Configuration**  
  Easily customizable setup through variables and config templates

For full Kratos capabilities, refer to the official documentation:  
👉 https://www.ory.com/docs/kratos

## 🛠 Tech Stack

- **Core**: [Ory Kratos](https://www.ory.sh/kratos/) v25.4.0
- **Database**: PostgreSQL 15
- **Docker** - Containerization
- **Docker Compose** - Local development and testing

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/ory-kratos.git
   cd ory-kratos/dev
   ```

2. **Start the services**
   ```bash
   docker-compose up -d
   ```

3. **Verify the services are running**
   ```bash
   docker-compose ps
   ```

4. **Access the services**
   - Kratos Public API: http://localhost:4433
   - Kratos Admin API: http://localhost:4434
   - PostgreSQL: localhost:5433

## 🔧 Configuration

Configuration is managed through environment variables in the `docker-compose.yml` file. Key configurations include:

- `DSN`: Database connection string
- `KRATOS_PUBLIC_URL`: Public base URL of the Kratos server
- `SELF_SERVICE_UI_URL`: URL of the self-service UI
- `COOKIE_SECRET`: Secret for cookie encryption
- `CIPHER_SECRET`: Secret for data encryption
- `PAGINATION_SECRET`: Secret used to protect pagination tokens
- `OIDC_PROVIDERS_*`: OAuth2.0 provider configurations
- `DOMAIN_COOKIE`: Cookie domain for Kratos browser cookies

## 🏗 Project Structure

```
ory-kratos/
├── dev/                  # Development configuration
│   └── docker-compose.yml  # Docker Compose for local development
├── mappers/              # Identity mappers for OIDC providers
├── Dockerfile            # Production Dockerfile
├── entrypoint.sh         # Container entrypoint script
├── kratos.yml.tmpl       # Kratos configuration template
└── identity.schema.json  # Identity schema definition
```

## 🔄 Running Migrations

Database migrations are automatically applied when the container starts with `RUN_MIGRATIONS=true`.

To manually run migrations:

```bash
docker-compose exec kratos kratos migrate sql -e --yes
```
