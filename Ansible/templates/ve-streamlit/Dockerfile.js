FROM python:3.12-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY .{{ application_dir }} .

RUN pip3 install -r requirements.txt

EXPOSE {{ port }}

ENTRYPOINT ["python", "-m", "streamlit", "run", "./apps/{{ app_name }}.py", "--server.port={{ port }}", "--server.address=0.0.0.0"]
