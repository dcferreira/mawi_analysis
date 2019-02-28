FROM python:3.7-alpine3.9
COPY --from=cluster.cn.tuwien.ac.at:5000/dferreira/go-flows /go-flows /usr/bin/go-flows

RUN apk --no-cache add wireshark-common
RUN pip install requests humanfriendly

RUN addgroup -g 1000 -S localuser && adduser -u 1000 -S localuser -G localuser
RUN chmod -R 757 /home/localuser
USER localuser
WORKDIR /home/localuser

ADD generate_url.py generate_url.py
ADD process_date.sh process_date.sh

ENTRYPOINT ["/home/localuser/process_date.sh"]

