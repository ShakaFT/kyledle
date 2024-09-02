# slim required to run bash scripts
FROM python:3.12-slim
WORKDIR /src
COPY scripts/requirements.txt ./requirements.txt
COPY scripts .
RUN pip install -r requirements.txt
