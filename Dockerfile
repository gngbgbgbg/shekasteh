FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0:11434

RUN apt-get update && \
    apt-get install -y python3 curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/open-webui/open-webui/archive/refs/heads/main.tar.gz \
    -o /tmp/open-webui.tar.gz

WORKDIR /app
RUN tar -xzf /tmp/open-webui.tar.gz --strip-components=1 && \
    pip3 install --no-cache-dir -r backend/requirements.txt

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080 11434

CMD ["/start.sh"]
