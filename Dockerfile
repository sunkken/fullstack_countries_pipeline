# Build
FROM node:20 AS build-stage

WORKDIR /usr/src/app

ARG VITE_WEATHER_API_KEY
ENV VITE_WEATHER_API_KEY=${VITE_WEATHER_API_KEY}

COPY . .

RUN npm ci && npm run build

# Production
FROM nginx:1.25-alpine
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html