FROM python:3.7-alpine
WORKDIR /app
RUN apk --no-cache add dnsmasq bind-tools && pip install requests

COPY *.py ./
COPY run.sh ./

EXPOSE 53 53/udp
CMD ["./run.sh"]
