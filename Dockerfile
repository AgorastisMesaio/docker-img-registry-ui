# Dockerfile for Registry Server
FROM joxit/docker-registry-ui:main

# Install necessary tools
RUN apk update && apk add --no-cache \
    curl

# Copy healthcheck
ADD healthcheck.sh /healthcheck.sh
RUN chmod +x /healthcheck.sh

# My custom health check
# I'm calling /healthcheck.sh so my container will report 'healthy' instead of running
# --interval=30s: Docker will run the health check every 'interval'
# --timeout=10s: Wait 'timeout' for the health check to succeed.
# --start-period=3s: Wait time before first check. Gives the container some time to start up.
# --retries=3: Retry check 'retries' times before considering the container as unhealthy.
HEALTHCHECK --interval=30s --timeout=10s --start-period=3s --retries=3 \
  CMD /healthcheck.sh || exit $?

