# ---- Build stage: make static site ----
FROM node:lts-alpine AS build
WORKDIR /app

# Install dependencies first for better caching
COPY package*.json ./
RUN npm ci

# Build
COPY . .
RUN npm run build

# ---- Run stage: Caddy serves static files with HTTPS ----
FROM caddy:2-alpine

# Static files go to /srv (arbitrary, referenced in Caddyfile)
COPY --from=build /app/dist /srv

# The static files needs a server. I'll use a simple 'internal' caddy for that
# Caddyfile configuration
COPY Caddyfile-internal /etc/caddy/Caddyfile

# Optional: drop everything except what's needed to bind 80/443
# (Caddy image is already minimal; you can add more hardening in compose)
