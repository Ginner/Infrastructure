{{ ansible_ssh_host }}:80 {
    reverse_proxy {{ app_name }}:8501
}
