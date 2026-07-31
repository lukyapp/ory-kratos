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

- **Core**: [Ory Kratos](https://www.ory.sh/kratos/) v26.2.0
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
- `KRATOS_SMTP_*`: SMTP courier settings for verification and recovery emails

### SMTP courier

Kratos sends verification and recovery emails through the standard SMTP
courier. The application does not depend on a provider-specific adapter; switch
providers by changing the SMTP URI and sender variables.

Local development uses Mailpit:

- SMTP endpoint from containers: `mailpit:1025`
- Web inbox: http://localhost:8025
- Connection URI: `smtp://mailpit:1025/?disable_starttls=true`

Production secrets should be configured in the runtime environment. For example,
with Resend over SMTP:

```env
KRATOS_SMTP_CONNECTION_URI=smtp://resend:RE_RESEND_API_KEY@smtp.resend.com:587/
KRATOS_SMTP_FROM_ADDRESS=no-reply@example.com
KRATOS_SMTP_FROM_NAME=Example App
```

Use a dedicated Resend API key for Kratos and a verified sender domain. Port
`587` uses STARTTLS; if a provider requires implicit TLS, use `smtps://` with
port `465`. The entrypoint always runs Kratos with `--watch-courier` so queued
verification emails are actually delivered. Use `KRATOS_EXTRA_ARGS` only for
temporary runtime tests.

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
