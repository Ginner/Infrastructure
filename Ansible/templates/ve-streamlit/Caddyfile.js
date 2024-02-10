{{ app_web_address }} {
    reverse_proxy {{ app_name }}:8501
}
