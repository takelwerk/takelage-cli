FROM alpine:latest

ARG version

COPY infinite.sh /entrypoint.py

RUN chmod 755 /entrypoint.py

COPY finite.sh /loginpoint.py

RUN chmod 755 /loginpoint.py

RUN echo "$version" > /version

CMD ["/entrypoint.py"]
