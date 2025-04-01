FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY main.py .

EXPOSE 8080
ENV FLASK_APP=app

CMD ["python", "main.py"]