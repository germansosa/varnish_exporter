FROM gsosa/docker-varnish:4.1.4

USER 0

ENV VARNISH_EXPORTER_VERSION 1.3.1
ENV VARNISH_EXPORTER_FILENAME prometheus_varnish_exporter-${VARNISH_EXPORTER_VERSION}.linux-amd64.tar.gz
ENV VARNISH_EXPORTER_SHA256 d81256567889160c813f3a0c8af54bffd1167f499334a263c4caffdf09264029
RUN set -xe \
	&& mkdir /tmp/varnish_exporter \
	&& cd /tmp/varnish_exporter \
	&& curl -fsL https://github.com/jonnenauha/prometheus_varnish_exporter/releases/download/${VARNISH_EXPORTER_VERSION}/${VARNISH_EXPORTER_FILENAME} -o ${VARNISH_EXPORTER_FILENAME} \
	&& echo "$VARNISH_EXPORTER_SHA256 *$VARNISH_EXPORTER_FILENAME" | sha256sum -c - \
	&& tar -xzf $VARNISH_EXPORTER_FILENAME --strip=1 \
	&& mv prometheus_varnish_exporter /usr/local/bin/varnish_exporter \
	&& chmod +x /usr/local/bin/varnish_exporter \
	&& cd .. \
	&& rm -rf varnish_exporter

USER 1001

CMD varnish_exporter
