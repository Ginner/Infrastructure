{
  image = "quay.io/jupyter/scipy-notebook:latest";

  environment = {
    JUPYTER_ENABLE_LAB = "yes";  # Ensures JupyterLab is the default interface
    NB_UID = "1000";  # User ID for the notebook user
    NB_GID = "100";   # Group ID for the notebook user
  };

  autoStart = true;

  ports = [
    "8888:8888"  # Map container port 8888 to host port 8888
  ];

  volumes = [
    "/home/ginner/notebooks:/home/jovyan/work"  # Replace with your desired path to store notebooks
  ];

  extraOptions = [
    "--pull=newer"
    "--name=jupyterlab"
    "--network=pod-net"
  ];
}
