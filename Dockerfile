# Dockerfile
FROM python:3.9-alpine3.13
LABEL maintainer="Javi Garcia"

ENV PYTHONUNBUFFERED 1

# Establecer la variable de entorno DJANGO_SETTINGS_MODULE
ENV DJANGO_SETTINGS_MODULE=proyecto_django.settings

# Copiar archivos de la aplicación y configurar el entorno virtual
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip &&\
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
