# Kyledle rest API

## Secrets

### .env

You should add `.env/` folder

```bash
# .env/.env.local
API_KEY="No API Key"

# .env/.env.dev
API_KEY=
REDIS_USERNAME=
REDIS_PASSWORD=

# .env/.env.prod
API_KEY=
REDIS_USERNAME=
REDIS_PASSWORD=
```

### redis.conf

```bash
user default off
user webapp on >"" ~* &* +@all
user shakaft on >"" ~* &* +@all
user nonudian on >"" ~* &* +@all
```
