# Build Container

FROM elixir:1.8-alpine AS build
ARG MIX_ENV=prod

RUN apk update && \
      apk upgrade --no-cache && \
      apk add build-base git --no-cache && \
      mix do local.hex --force, local.rebar --force

COPY . .

RUN mix do deps.get, compile --force, release --silent && \
      find _build/ -iname clock.tar.gz -exec cp {} . \; && \
      mkdir -p /opt/app/ && \
      tar -xf clock.tar.gz -C /opt/app

# Production Container

FROM alpine:3.9
ENV HOME=/opt/app

RUN apk update && \
      apk upgrade --no-cache && \
      apk add --no-cache -q bash openssl ca-certificates zlib ncurses-libs && \
      # mkdir -p /opt/app/ && \
      mkdir -p ${HOME} && \
      adduser -s /bin/bash -u 1001 -G root -h /opt/app -S -D default && \
      chown -R 1001:0 ${HOME}

USER default

WORKDIR ${HOME}

COPY --from=build /opt/app .

ENTRYPOINT [ "bin/clock" ]

CMD [ "foreground" ]
