FROM python:latest 

ADD requirements.txt /app/requirements.txt

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /app/requirements.txt 

ADD djangochat/  /app/djangochat
ADD chat/ /app/chat
ADD templates/ /app/templates 
ADD manage.py /app
WORKDIR /app

RUN python manage.py makemigrations \
    && python manage.py migrate 


EXPOSE 8000

CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "djangochat.wsgi:application"]

