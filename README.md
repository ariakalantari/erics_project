# Mobility46 Stockholm Parking Demo

A small Ruby on Rails app showing live parking availability and EV charging across central Stockholm. Click a marker on the map to see spot details, change its status, and watch the activity feed update in real time.

Built as an interview showcase for [Mobility46](https://www.mobility46.se/).

## Stack

- **Ruby on Rails 8.1** (Ruby 3.3) — monolithic
- **SQLite** for storage
- **Tailwind CSS v4** via `tailwindcss-rails` (no Node)
- **Hotwire** (Turbo + Stimulus) for the live UI — no React, no JSON API
- **Leaflet** + **CartoDB Positron** tiles for the map (no API key required)
- **Importmap** for JavaScript (no bundler)
- **Docker Compose** for the dev environment

## Run it

You only need Docker installed.

```bash
docker compose up -d
```

Then open **http://localhost:9898/**.

The first start builds the image and seeds the database with 28 Stockholm parking areas, ~890 spots, and ~165 EV chargers.

## Use it

- **Browse the map** — pins are color-coded by status (green = available, grey = occupied, amber = reserved, red = out of service, blue ring = EV charger).
- **Filters card** (top-left) — toggle status types or filter to EV-only / accessible-only.
- **Areas dropdown** (top-right of the topbar) — pick an area to fly the map to it.
- **Click a pin** → the spot detail card appears bottom-right with status, type, charger info, and four action buttons to change the status.
- **Change a status** → marker color updates live, stat card re-counts, and a new entry appears in the recent activity feed (top-right). Open the app in two tabs — both update together.
- **Click an entry in recent activity** → the map flies to that spot and reopens its detail card.

## Common commands

```bash
docker compose logs -f web                              # tail logs
docker compose exec web bin/rails console               # Rails console
docker compose exec web bin/rails db:seed               # re-seed (idempotent)
docker compose exec web bin/rails db:drop db:create db:migrate db:seed   # reset
docker compose down                                     # stop
```

## Project layout

Standard Rails 8 conventions. The interesting bits:

- `app/models/` — `ParkingArea`, `ParkingSpot`, `Charger`, `Activity`
- `app/controllers/dashboard_controller.rb` — the map view
- `app/controllers/parking_spots_controller.rb` — spot show + status update
- `app/views/dashboard/` — page partials (stat card, filters, activity feed, …)
- `app/javascript/controllers/` — Stimulus controllers (map, filters, drawer, …)
- `db/seeds.rb` — the seeded Stockholm data
- `Dockerfile.dev` + `docker-compose.yml` — dev environment
