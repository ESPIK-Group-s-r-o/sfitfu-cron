FROM ubuntu:22.04

RUN apt-get remove ca-certificates
RUN apt-get update && apt-get install -y ca-certificates cron curl

COPY crontab /sfitftu-cron
COPY entrypoint.sh /entrypoint.sh

RUN crontab sfitftu-cron
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# https://manpages.ubuntu.com/manpages/trusty/man8/cron.8.html
# -f | Stay in foreground mode, don't daemonize.
# -L loglevel | Tell  cron  what to log about jobs (errors are logged regardless of this value) as the sum of the following values:
CMD ["cron","-f", "-L", "2"]
