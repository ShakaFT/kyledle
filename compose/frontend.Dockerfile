FROM node:22-alpine AS build
ARG API_KEY
ARG API_URL
ENV VITE_API_KEY=$API_KEY
ENV VITE_API_URL=$API_URL
COPY frontend .
RUN npm i
RUN npm run build

FROM nginx:alpine AS server
COPY nginx/nginx-frontend.conf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html
COPY --from=build /dist /usr/share/nginx/html
RUN ls -l /usr/share/nginx/html
