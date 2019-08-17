FROM debian:stretch-slim
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		curl \
		unzip \
        xvfb \
		ca-certificates && \
	curl -sL https://deb.nodesource.com/setup_10.x | bash && \
	apt-get update && \
	apt-get install nodejs -y && \
    dpkg --add-architecture i386 \
		&& apt-get update \
		&& apt-get install -y --no-install-recommends \
				wine \
				wine32 \
		&& rm -rf /var/lib/apt/lists/*
