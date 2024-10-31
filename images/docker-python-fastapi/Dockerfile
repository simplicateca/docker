FROM tiangolo/uvicorn-gunicorn:python3.10
LABEL maintainer="Steve Comrie <steve@simplicate.ca>"
COPY requirements.txt /tmp/requirements.txt
RUN apt update -y && apt upgrade -y && apt install -y nano
RUN pip install --no-cache-dir -r /tmp/requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]