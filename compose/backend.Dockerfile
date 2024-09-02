FROM python:3.12-alpine
WORKDIR /src
COPY backend/requirements.txt ./requirements.txt
COPY backend/src/* .
RUN pip install -r requirements.txt
