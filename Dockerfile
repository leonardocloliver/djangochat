FROM python:latest 

ARG ENV

ENV ENV=${ENV} \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VERSION=1.1.13

RUN pip install --upgrade pip \
    && pip install --no-cache-dir poetry==${POETRY_VERSION}

ADD djangochat/  /app/djangochat
ADD chat/ /app/chat
ADD templates/ /app/templates 
ADD manage.py /app
ADD poetry.lock pyproject.toml /app/
WORKDIR /app

RUN poetry config virtualenvs.create false \
  && poetry install $(test "$ENV" == production && echo "--no-dev") --no-interaction --no-ansi

RUN python manage.py makemigrations \
    && python manage.py migrate 


EXPOSE 8000

CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "djangochat.wsgi:application"]

