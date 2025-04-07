{
  image = "quay.io/jupyter/scipy-notebook:latest";

  environment = {
    # JUPYTER_ENABLE_LAB = "yes";  # Ensures JupyterLab is the default interface
    # JUPYTER_TOKEN = "";  # Empty token allows access without authentication
    # JUPYTER_CONFIG_DIR = "/home/jovyan/.jupyter";
    NB_UID = "1000";  # User ID for the notebook user
    NB_GID = "100";   # Group ID for the notebook user
  };

  autoStart = true;

  volumes = [
    "/home/ginner/notebooks:/home/jovyan/work"
    "/etc/nixos/containers/jupyter/config:/home/jovyan/.jupyter"  # For persistent configuration
  ];

  cmd = [
    "start.sh"
    "jupyter"
    "lab"
    "--LabApp.ip='0.0.0.0'"
    "--LabApp.open_browser=false"
    "--LabApp.allow_origin='*'"
    "--LabApp.token=''"
    # "--ServerApp.allow_origin='*'"
    # "--ServerApp.allow_remote_access=true"
    # "--ServerApp.password_required=false"
    # # "--NotebookApp.base_url='/jupyter'"
    # "--NotebookApp.token=''"
    # "--NotebookApp.ip='0.0.0.0'"
  ];

  extraOptions = [
    "--pull=newer"
    "--name=jupyter"
    "--network=pod-net"
  ];
}
