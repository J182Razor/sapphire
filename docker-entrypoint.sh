#!/bin/bash
set -e

# Create all user subdirectories that Sapphire needs at startup.
# Must run before the app so dirs exist when the volume is mounted.
mkdir -p \
    /app/user/logs \
    /app/user/history \
    /app/user/public/avatars \
    /app/user/plugins \
    /app/user/plugin_state \
    /app/user/webui/plugins \
    /app/user/continuity \
    /app/user/ssl \
    /app/user/prompts \
    /app/user/toolsets \
    /app/user/personas \
    /app/user/spice_sets \
    /app/user/story_engine

exec "$@"
