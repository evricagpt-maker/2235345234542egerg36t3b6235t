FROM python:3.12-slim
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends chromium fonts-dejavu-core fonts-noto-core ca-certificates && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir fastapi uvicorn requests beautifulsoup4 reportlab pydantic playwright
COPY app_v2.00a app_v2.00b app_v2.01 app_v2.02 app_v2.03 /tmp/
RUN cat /tmp/app_v2.00a /tmp/app_v2.00b /tmp/app_v2.01 /tmp/app_v2.02 /tmp/app_v2.03 | base64 -d | gzip -d > /app/app.py && python -m py_compile /app/app.py
EXPOSE 8000
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port 8000"]
