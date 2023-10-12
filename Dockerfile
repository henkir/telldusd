FROM debian:stable-slim as build

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libftdi1 \
    libftdi-dev \
    libconfuse-common \
    libconfuse-dev \
    libconfuse2 \
    cmake \
    pkg-config \
    sed \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY build.sh /

RUN ["/bin/sh", "/build.sh" ]

# FROM debian:stable-slim
# 
# RUN apt-get update && \
#     apt-get install -y \
#     libudev-dev \
# #     wget \
#     socat \
#     libftdi1 \
#     && rm -rf /var/lib/apt/lists/*

#COPY --from=build /usr/sbin/telldusd /usr/sbin/tdadmin /usr/sbin/
#COPY --from=build /usr/bin/tdtool /usr/bin/
#COPY --from=build /usr/lib/* /usr/lib/

COPY run.sh /
RUN [ "chmod", "+x", "/run.sh" ]

CMD [ "/run.sh" ]

EXPOSE 50800 50801
