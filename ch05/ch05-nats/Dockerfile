FROM mcr.microsoft.com/windows/nanoserver:1809

# The NAT Server will look for this environment variable.
# When set, it prevents the use of the service API to detect
# if it is running in interactive mode or not, which is
# failing in the context of a Docker container.
# (https://github.com/nats-io/gnatsd/issues/543)
ENV NATS_DOCKERIZED=1

WORKDIR c:/gnatsd
COPY --from=nats:1.4.1-nanoserver C:/gnatsd/gnatsd.exe gnatsd.exe
COPY --from=nats:1.4.1-nanoserver C:/gnatsd/gnatsd.conf gnatsd.conf

# Expose client, management, and cluster ports
EXPOSE 4222 8222 6222

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]