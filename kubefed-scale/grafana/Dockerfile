FROM grafana/grafana:6.6.2
COPY ./provisioning /etc/grafana/provisioning
COPY ./grafana.ini /etc/grafana/grafana.ini
COPY ./default_dashboards /var/lib/grafana/default_dashboards


# Generate TLS certificates to enable HTTPS only access to Grafana Server. [Optional]
# Resources:
#   - https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/
#   - https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs
#   - https://www.linode.com/docs/security/ssl/create-a-self-signed-tls-certificate/
#   - https://hub.docker.com/layers/grafana/grafana/6.4.3/images/sha256-1bfed7ce5f9b635e8dcfb1de0f5c5bc7c12e65ad49bd9d574fd998a53a55281f

# set operating user to root for cert and key generation
USER root

# Create a directory to store certificate and keys. Create keys.
RUN mkdir /https && cd /https && \
    openssl req -new -newkey rsa:4096 -x509 -sha256 \
    -days 365 -nodes \
    -keyout domain.key -out domain.crt \
    -subj "/C=US/ST=California/L=Santa_Clara/O=SOME/OU=scale/CN=some.net"

