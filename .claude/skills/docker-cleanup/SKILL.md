---
name: docker-cleanup
description: Audit Docker resource usage and clean up unused containers, images, build cache, and volumes
---

## Context

- Docker disk usage: !`docker system df`
- Running container stats: !`docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}"`
- Exited containers: !`docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Status}}\t{{.Size}}"`

## Instructions

1. Summarize disk (images, containers, build cache, volumes), RAM (per-container vs VM limit), and CPU in a table.

2. Run cleanup in this order (containers first so their pinned images become prunable):
   - `docker container prune -f`
   - `docker image prune -a -f`
   - `docker builder prune -f`
   - `docker volume prune -f`

3. Run `docker system df` to show reclaimed space.
