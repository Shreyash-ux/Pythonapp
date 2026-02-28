# ===============================
# Stage 1 — Builder
# ===============================
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ===============================
# Stage 2 — Runtime
# ===============================
FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*
# create non-root user
RUN adduser --disabled-password --gecos '' appuser

WORKDIR /app

# copy dependencies
COPY --from=builder /install /usr/local

# copy app code
COPY app ./app
COPY run.py .
COPY entrypoint.sh .

# make script executable
RUN chmod +x entrypoint.sh

# permissions
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

# healthcheck (VERY IMPORTANT)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD curl -f http://localhost:5000/api/v1/healthcheck || exit 1

CMD ["./entrypoint.sh"]
