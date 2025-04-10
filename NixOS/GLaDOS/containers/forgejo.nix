{
  image = "codeberg.org/forgejo/forgejo:10";

  environment = {
    # JUPYTER_ENABLE_LAB = "yes";  # Ensures JupyterLab is the default interface
    # JUPYTER_TOKEN = "";  # Empty token allows access without authentication
    # JUPYTER_CONFIG_DIR = "/home/jovyan/.jupyter";
    USER_UID = "1000";  # User ID for the notebook user
    USER_GID = "100";   # Group ID for the notebook user
  };

  autoStart = true;

  volumes = [
    "/etc/nixos/containers/forgejo:/data"
    # "/etc/timezone:/etc/timezone:ro"  # Mount the host's timezone file
    # "/etc/localtime:/etc/localtime:ro"  # Mount the host's localtime file
  ];

  ports = [
    "222:22"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=forgejo"
    "--network=pod-net"
  ];
}
