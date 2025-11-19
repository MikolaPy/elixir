FROM elixir:1.15

# Install build tools and Node.js (needed for Phoenix assets)
# RUN apk add --no-cache build-base npm git

WORKDIR /app

# RUN adduser --disabled-password appuser
# RUN chown -R appuser:appuser /app
# USER appuser
RUN chown -R root:root /app

# Install hex + rebar
RUN mix local.hex --force && mix local.rebar --force

# Copy mix files first (better caching)
# COPY mix.exs mix.lock ./
# COPY config config

# RUN mix deps.get

# Copy the rest of the app
COPY . ./app

# Expose Phoenix port
EXPOSE 4000

# Run Phoenix server
CMD ["mix", "phx.server"]

