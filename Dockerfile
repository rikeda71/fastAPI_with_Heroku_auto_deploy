FROM python:3.8-alpine

RUN apk add --no-cache --update bash build-base mariadb-connector-c-dev \
    && pip3 install --no-cache-dir -q fastapi uvicorn \
    && adduser -D myuser

USER myuser

ADD ./main.py /opt/webapp/
WORKDIR /opt/webapp

CMD uvicorn main:app --host 0.0.0.0 --port $PORT
