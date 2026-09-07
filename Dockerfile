FROM python:3.12-slim
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends fonts-dejavu-core ca-certificates && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir fastapi uvicorn requests beautifulsoup4 reportlab pydantic
COPY app.b64 /tmp/app.b64
RUN base64 -d /tmp/app.b64 | gzip -d > /app/app.py && python -m py_compile /app/app.py
EXPOSE 8000
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"]
