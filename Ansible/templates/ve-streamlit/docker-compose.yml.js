version: '3.8'


services:
{{ app_name }}:
    build: {{ application_dir }}/.
    ports:
      - "8501:8501"
    volumes:
      - .:/app

  caddy:
    image: caddy:2
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
