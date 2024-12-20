FROM python:latest

WORKDIR /app

COPY . /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"
