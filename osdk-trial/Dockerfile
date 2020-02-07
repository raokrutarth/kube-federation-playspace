FROM golang:1.11-stretch

USER root

# install the operator sdk in the container
ENV RELEASE_VERSION v0.15.1
RUN curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
RUN chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && \
    mkdir -p /usr/local/bin/ && \
    cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && \
    rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
CMD while true; do sleep 30s; done
