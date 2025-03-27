FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/gurkanakdeniz/example-flask-crud.git .

RUN python3 -m venv venv

ENV PATH="/app/venv/bin:$PATH"

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

ENV FLASK_APP=crudapp.py

RUN flask db init

RUN flask db migrate -m "entries table"

RUN flask db upgrade

EXPOSE 80

CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]