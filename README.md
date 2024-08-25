# Kyledle rest API

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
