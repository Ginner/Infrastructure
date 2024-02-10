version: '3.8'


services:
  {{ app_name }}:
    build: .
    container_name: {{ app_name }}
    restart: unless-stopped
    ports:
      - "8501:8501"

  caddy:
    image: caddy:latest
    container_name: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
