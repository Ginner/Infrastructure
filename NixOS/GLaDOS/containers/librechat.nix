{ config, ...}:

let
  authFile = config.age.secrets.ghcr-token.path;
  envFile = config.age.secrets.namecheap-api.path;
in
{
  # LibreChat API service
  librechat-api = {
    image = "ghcr.io/danny-avila/librechat-dev:latest";

    environment = {
      HOST = "0.0.0.0";
      MONGO_URI = "mongodb://chat-mongodb:27017/LibreChat";
      MEILI_HOST = "http://chat-meilisearch:7700";
      RAG_PORT = "\${RAG_PORT:-8000}";
      RAG_API_URL = "http://rag_api:\${RAG_PORT:-8000}";
    };

    autoStart = true;

    volumes = [
      "/path/to/your/.env:/app/.env" # Update with the path to your actual .env file
      "/path/to/librechat/images:/app/client/public/images"
      "/path/to/librechat/uploads:/app/uploads"
      "/path/to/librechat/logs:/app/api/logs"
    ];

    extraOptions = [
      "--pull=newer"
      "--name=LibreChat"
      "--network=pod-net"
      "-p=\${PORT}:\${PORT}" # Make sure PORT is set in your environment
      "--add-host=host.docker.internal:host-gateway"
      "--user=\${UID}:\${GID}" # Make sure UID and GID are set in your environment
    ];
  };

  # MongoDB service
  librechat-mongodb = {
    image = "mongo";

    autoStart = true;

    volumes = [
      "/path/to/librechat/data-node:/data/db"
    ];

    cmd = [
      "mongod"
      "--noauth"
    ];

    extraOptions = [
      "--pull=newer"
      "--name=chat-mongodb"
      "--network=pod-net"
      "--user=\${UID}:\${GID}" # Make sure UID and GID are set in your environment
    ];
  };

  # Meilisearch service
  librechat-meilisearch = {
    image = "getmeili/meilisearch:v1.12.3";

    environment = {
      MEILI_HOST = "http://chat-meilisearch:7700";
      MEILI_NO_ANALYTICS = "true";
      MEILI_MASTER_KEY = "\${MEILI_MASTER_KEY}"; # Make sure MEILI_MASTER_KEY is set in your environment
    };

    autoStart = true;

    volumes = [
      "/path/to/librechat/meili_data_v1.12:/meili_data"
    ];

    extraOptions = [
      "--pull=newer"
      "--name=chat-meilisearch"
      "--network=pod-net"
      "--user=\${UID}:\${GID}" # Make sure UID and GID are set in your environment
    ];
  };

  # Vector database service
  librechat-vectordb = {
    image = "ankane/pgvector:latest";

    environment = {
      POSTGRES_DB = "mydatabase";
      POSTGRES_USER = "myuser";
      POSTGRES_PASSWORD = "mypassword";
    };

    autoStart = true;

    volumes = [
      "pgdata2:/var/lib/postgresql/data"
    ];

    extraOptions = [
      "--pull=newer"
      "--name=vectordb"
      "--network=pod-net"
    ];
  };

  # RAG API service
  librechat-rag-api = {
    image = "ghcr.io/danny-avila/librechat-rag-api-dev-lite:latest";

    environment = {
      DB_HOST = "vectordb";
      RAG_PORT = "\${RAG_PORT:-8000}";
    };

    environmentFiles = [
      "/path/to/your/.env" # Update with the path to your actual .env file
    ];

    autoStart = true;

    extraOptions = [
      "--pull=newer"
      "--name=rag_api"
      "--network=pod-net"
    ];
  };
}
