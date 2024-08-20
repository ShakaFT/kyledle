# Scripts

## Secrets

```bash
# .env
REDIS_USERNAME=
REDIS_PASSWORD=
```

## Google Cloud Storage Public Bucket CORS

Documentation: <https://cloud.google.com/storage/docs/using-cors?#storage_cors_configuration-python>

```python
bucket = storage_client.bucket(BUCKET_NAME)
bucket.cors = [
    {
        "origin": ["https://kyledle.web.app"],
        "method": ["GET"],
    }
]
bucket.patch()
```
