---
name: docker-cleanup
description: Audit Docker resource usage and clean up unused containers, images, build cache, and volumes
allowed-tools: Bash(docker:*)
---

## Context

- Docker disk usage (verbose): !`docker system df -v`
- Running container stats: !`docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"`
- Exited containers: !`docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Size}}"`

## Instructions

1. Summarize findings in a table format:
   - **Disk**: build cache, images, stopped containers, volumes (with sizes)
   - **RAM**: per-container memory usage vs Docker VM memory limit
   - **CPU**: per-container CPU usage

2. Run cleanup (skipping anything used in the last 72 hours):
   - `docker container prune -f --filter "until=72h"`
   - `docker image prune -f --filter "until=72h"`
   - `docker builder prune -f --filter "until=72h"`
   - `docker volume prune -f`

3. Run `docker system df` to show reclaimed space.
