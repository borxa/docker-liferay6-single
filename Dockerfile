FROM openjdk:8-alpine

MAINTAINER Borxa Varela <borxa@varelabouzas.net>

RUN apk add --no-cache curl
RUN addgroup -g 1001 liferay && \
    adduser -D -u 1002 -G liferay liferay

ENV LIFERAY_HOME=/usr/local/liferay-portal-6.2-ce-ga6
ENV CATALINA_HOME=$LIFERAY_HOME/tomcat-7.0.62
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV LIFERAY_TOMCAT_URL=https://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.5%20GA6/liferay-portal-tomcat-6.2-ce-ga6-20160112152609836.zip/download

WORKDIR /usr/local

RUN mkdir -p "$LIFERAY_HOME" \
    && set -x \
    && curl -fSL "$LIFERAY_TOMCAT_URL" -o liferay-portal-6.2-ce-ga6-20160112152609836.zip \
    && unzip liferay-portal-6.2-ce-ga6-20160112152609836.zip \
    && rm liferay-portal-6.2-ce-ga6-20160112152609836.zip \
    && chown -R liferay:liferay $LIFERAY_HOME \
    && mkdir -p /data/liferay/document_library \
    && chown -R liferay:liferay /data

COPY ./configs/portal-ext.properties $LIFERAY_HOME/portal-ext.properties

EXPOSE 8080/tcp

CMD ["catalina.sh", "run"]
