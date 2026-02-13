---
name: docker-cleanup
description: Audit Docker resource usage and clean up unused containers, images, build cache, and volumes
model: sonnet
allowed-tools: Bash(docker*)
---

## Context

- Docker disk usage: !`docker system df`
- Running containers: !`docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"`

## Instructions

1. Gather detailed resource usage in parallel:
   - `docker system df -v`
   - `docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"`
   - `docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Size}}"`

2. Summarize findings in a table format:
   - **Disk**: build cache, images, stopped containers, volumes (with sizes)
   - **RAM**: per-container memory usage vs Docker VM memory limit
   - **CPU**: per-container CPU usage

3. Run cleanup (skipping anything used in the last 72 hours):
   - `docker container prune -f --filter "until=72h"`
   - `docker image prune -f --filter "until=72h"`
   - `docker builder prune -f --filter "until=72h"`
   - `docker volume prune -f`

4. Run `docker system df` to show reclaimed space.
