FROM --platform=linux/amd64 python:3.12-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y apache2-utils \
    && chmod +x /app/generate-votes.sh \
    && sed -i 's/\r$//' /app/generate-votes.sh \
    && python make-data.py

EXPOSE 9000
CMD ["./generate-votes.sh"]
