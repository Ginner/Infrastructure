{% for app in apps %}
{{ app_subdomain }}.{{ domain_name }}/{{ app.name | lower}} {
    reverse_proxy {{ app.name }}:{{ app.port }}
}
{% endfor %}

{{ app_subdomain }}.{{ domain_name }}/netdata {
    reverse_proxy netdata:19999
    basicauth {
        {{ app_admin_user }} {{ app_admin_password | password_hash('bcrypt') }}
    }
}
