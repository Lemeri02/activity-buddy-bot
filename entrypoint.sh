#!/bin/bash
set -e

# setup DB
bin/rails db:exists && bin/rails db:migrate || bin/rails db:setup

# Clean logs
bin/rails log:clear tmp:clear

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"