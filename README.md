# jetbrains-license-server
A dockerized JetBrains License Server (current version is build 17955, released Sept 28, 2018), based on tomcat:8.5. Available on Docker Hub at [racerpeter/jetbrains-license-server](https://hub.docker.com/r/racerpeter/jetbrains-license-server/).

## Getting Started
Getting started with jetbrains-license-server is easy:

1. Configure the license server using the environment variables below
2. Run `docker-compose up`
3. Navigate to your license server (default: `http://localhost:8080`)
4. You should be prompted to log in to your JetBrains account to configure the license server. *Your license server data will be stored in the mounted data directory so that the license server configuration is persisted across restarts.*

### Environment Variable Options
- `LICENSE_SERVER_HOST` The hostname at which this license server will be available. This setting is required when [exposing the license server from behind a reverse proxy](https://www.jetbrains.com/help/license_server/configuring_secure_connection.html) (optional, disabled by default)
- `LICENSE_SERVER_SMTP_SERVER` SMTP server to use for sending [stats emails](https://www.jetbrains.com/help/license_server/detailed_server_usage_statistics.html) (optional, stats emails disabled by default)
- `LICENSE_SERVER_SMTP_PORT` Defaults to 25
- `LICENSE_SERVER_SMTP_USERNAME` Optional, auth is disabled by default
- `LICENSE_SERVER_SMTP_PASSWORD` Required if LICENSE_SERVER_SMTP_USERNAME is provided
- `LICENSE_SERVER_STATS_FROM` From address for stats emails
- `LICENSE_SERVER_STATS_RECIPIENTS` Recipient address(es) for stats emails (comma delimited)
- `LICENSE_SERVER_STATS_TOKEN` Enables an auth token for the [stats API](https://www.jetbrains.com/help/license_server/detailed_server_usage_statistics.html) at /reportApi (method: POST)
- `LICENSE_SERVER_USER_RESTRICTIONS` Enables user restrictions loaded from `$LICENSE_SERVER_USER_RESTRICTIONS` (/root/access-config.json by default, which is mounted from the Docker host when using docker-compose.yml, otherwise it must be copied into the container. *Note: only configured when the file is non-empty.*)

### Requirements:
- Docker
- docker-compose
