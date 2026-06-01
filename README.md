# Flight Booker

Flight Booker is a Rails application for searching seeded flights, selecting an itinerary, and creating a booking with passenger details. It demonstrates a complete multi-step reservation flow backed by relational data modeling in PostgreSQL.

## Highlights

- Implements a Rails booking workflow from flight search to passenger entry to booking confirmation.
- Models airports, flights, bookings, and passengers with Active Record associations and PostgreSQL foreign keys.
- Uses nested attributes to save a booking and its passenger records in one form submission.
- Provides seeded sample data so reviewers can run the app locally and exercise the main flow quickly.
- Includes Rails CI, Minitest scaffolding, RuboCop, Brakeman, Bundler Audit, Importmap audit, Docker, and Kamal deployment configuration.

## Features

- Search flights by departure airport, arrival airport, date, and passenger count.
- Display matching flights with route, departure time, and duration.
- Select one available flight and carry the passenger count into the booking form.
- Enter name and email details for each passenger through a nested Rails form.
- Persist bookings with associated passenger records and show a confirmation page.
- Seed airport and flight records for local development and review.

## Tech Stack

- Ruby 3.4.6
- Rails 8.1
- PostgreSQL with Active Record
- ERB views and Rails form helpers
- Hotwire-ready Rails setup with Turbo, Stimulus, and Importmap
- Propshaft asset pipeline
- Minitest, Capybara, and Selenium for testing
- RuboCop Rails Omakase, Brakeman, Bundler Audit, and Importmap audit for quality and security checks
- Docker, Thruster, and Kamal deployment scaffolding

## Architecture / Data Model

The application centers on a simple reservation domain:

- `Airport` has many departing flights and arriving flights.
- `Flight` belongs to a departure airport and an arrival airport, and has many bookings.
- `Booking` belongs to a flight and has many passengers.
- `Passenger` belongs to a booking.

The booking form uses `accepts_nested_attributes_for :passengers`, allowing one request to create the booking and all passenger rows together. Flight search is handled in `FlightsController#index`, while `BookingsController` owns the booking creation and confirmation flow.

## Repository Structure

```text
.
|-- app/
|   |-- controllers/        # Flight search and booking flow controllers
|   |-- models/             # Airport, Flight, Booking, and Passenger models
|   `-- views/              # ERB templates for search, booking, and confirmation
|-- config/
|   |-- routes.rb           # Root route and RESTful flight/booking routes
|   |-- database.yml        # PostgreSQL database configuration
|   `-- deploy.yml          # Kamal deployment configuration
|-- db/
|   |-- migrate/            # Database migrations
|   |-- schema.rb           # Current PostgreSQL schema
|   `-- seeds.rb            # Sample airports and flights
|-- test/                   # Minitest model and controller test files
|-- .github/workflows/      # CI workflow for tests, linting, and security scans
|-- Dockerfile              # Production container image
|-- Gemfile                 # Rails and tooling dependencies
`-- README.md
```

## Getting Started

### Prerequisites

- Ruby 3.4.6
- PostgreSQL
- Bundler

### Setup

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
```

You can also use the Rails setup script:

```bash
bin/setup --skip-server
bin/rails db:seed
```

### Run Locally

```bash
bin/dev
```

Then open:

```text
http://localhost:3000
```

## Testing / Quality

Run the Rails test suite:

```bash
bin/rails test
```

Run the local CI workflow defined in `config/ci.rb`:

```bash
bin/ci
```

Individual quality and security checks are also available:

```bash
bin/rubocop
bin/brakeman
bin/bundler-audit
bin/importmap audit
```

The GitHub Actions workflow runs Ruby security scanning, JavaScript dependency auditing, RuboCop linting, Rails tests, and system tests against PostgreSQL.

## Deployment

The repository includes a production Dockerfile and Kamal configuration. The generated container runs Rails through Thruster and expects production secrets such as `RAILS_MASTER_KEY` to be provided by the deployment environment.

## Author

Nam Do
