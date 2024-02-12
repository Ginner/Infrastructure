{{ app_subdomain }}.{{ domain_name }} {
    reverse_proxy {{ app_name }}:8501
}

netdata.{{ domain_name }} {
    reverse_proxy netdata:19999
    basicauth {
        {{ app_admin_user }} {{ app_admin_password | password_hash('bcrypt') }}
    }
}
