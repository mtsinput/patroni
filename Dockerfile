FROM postgres:11

RUN apt-get update -y\
    && apt-get install python3 python3-pip -y\
    && pip3 install --upgrade setuptools\
    && pip3 install psycopg2-binary \
    && pip3 install patroni[consul] \
    && pip3 install python-consul \
    && mkdir /data/patroni -p \
    && chown postgres:postgres /data/patroni \
    && chmod 750 /data/patroni

COPY patroni.yml /etc/patroni.yml
COPY patroni-entrypoint.sh ./entrypoint.sh
RUN chmod 777 ./entrypoint.sh
USER postgres

ENTRYPOINT ["bin/sh", "/entrypoint.sh"]
