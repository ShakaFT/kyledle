# Kyledle

## Secrets

### .env

You should add `.env/` folder

```bash
# .env/.env.dev
API_KEY=
REDIS_USERNAME=
REDIS_PASSWORD=

# .env/.env.prod
API_KEY=
DISCORD_WEBHOOK_URL=
REDIS_USERNAME=
REDIS_PASSWORD=
```

### redis.conf

```bash
# Only in dev and prod environments
user default off
user webapp on >"" ~* &* +@all
user shakaft on >"" ~* &* +@all
user nonudian on >"" ~* &* +@all
```

## Debian VPS configuration

```bash
# Install git
sudo apt update
sudo apt upgrade -y
sudo apt install git

# Generate SSH Key
ssh-keygen -t ed25519
# Next, add public ssh key in `deploy keys` of Github repository

# Install Docker
# Documentation: https://docs.docker.com/engine/install/debian/
sudo apt-get install docker-compose-plugin
sudo chmod 666 /var/run/docker.sock

# Set Paris timezone
timedatectl set-timezone Europe/Paris

# Doc to disable IPV6: https://github.com/docker/hub-feedback/issues/2421#issuecomment-2491140211

# Add Supervisor file config
[program:kyledle-dev-backend]
command=/home/debian/kyledle-dev/run.bash dev -b
directory=/home/debian/kyledle-dev
autostart=true
autorestart=true
stderr_logfile=/var/log/kyledle-dev-backend.err.log
stdout_logfile=/var/log/kyledle-dev-backend.out.log

[program:kyledle-dev-frontend]
command=/home/debian/kyledle-dev/run.bash dev -f
directory=/home/debian/kyledle-dev
autostart=true
autorestart=true
stderr_logfile=/var/log/kyledle-dev-frontend.err.log
stdout_logfile=/var/log/kyledle-dev-frontend.out.log

[program:kyledle-prod-backend]
command=/home/debian/kyledle-prod/run.bash prod -b
directory=/home/debian/kyledle-prod
autostart=true
autorestart=true
stderr_logfile=/var/log/kyledle-prod-backend.err.log
stdout_logfile=/var/log/kyledle-prod-backend.out.log

[program:kyledle-prod-frontend]
command=/home/debian/kyledle-prod/run.bash prod -f
directory=/home/debian/kyledle-prod
autostart=true
autorestart=true
stderr_logfile=/var/log/kyledle-prod-frontend.err.log
stdout_logfile=/var/log/kyledle-prod-frontend.out.log

# Execute these commands to refresh supervisor
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl status
```
