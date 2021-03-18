FROM opensuse/leap
LABEL maintainer 'Bernardo Albuquerque <bernardo.albuquerque@shoppingbrasil.com.br>'

RUN mkdir /app && \
    mkdir /app/response && \
    zypper update --auto-agree-with-licenses && \
    zypper --non-interactive install python3  && \
    zypper --non-interactive install python3-pip && \
    zypper --non-interactive install zip && \
    zypper --non-interactive install unzip && \
    zypper --non-interactive install curl && \
    pip install --upgrade pip && \
    pip install requests && \
    pip install beautifulsoup4 && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

COPY ["main.py", "scrape-app.sh", "/app/"]

USER root
WORKDIR /app

ENTRYPOINT ["/bin/bash"]
CMD ["scrape-app.sh"]