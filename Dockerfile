FROM gushry/play2
MAINTAINER Gushiken

COPY . /opt/myplay2

WORKDIR /opt/myplay2
RUN ./activator compile stage

EXPOSE 9000
ENTRYPOINT ["./target/universal/stage/bin/docker-play2"]
