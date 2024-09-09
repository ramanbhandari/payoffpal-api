# PayoffPal API

## Project Overview

The PayoffPal API provides the backend services and data management for the PayoffPal application. This API is built using Ruby on Rails with the API-only mode, and PostgreSQL is used as the database. The API handles user authentication, data processing, and serves the front-end with necessary endpoints.

## Features

- API endpoints for Debt Tracker
- Payment Calculator data
- Budget Planner
- Debt Repayment Strategies
- Progress Tracker
- Alerts and Reminders
- Educational Resources

## Technologies Used

- Ruby on Rails
- PostgreSQL (or other database)
- RSpec (for testing)

## Getting Started

### Prerequisites

- Ruby
- Rails
- PostgreSQL (or other database)
- Bundler

### Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/your-username/payoffpal-api.git
cd payoffpal-api
bundle install
```

### Database Setup

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

Check DB migrate status:

```bash
rails db:migrate status
```

### Running the Server

Start the Rails server:

```bash
rails server
```

### Test

- RSpec
- FactoryBot

Run the tests:

```bash
bundle exec rspec
```

### Code Quality

RuboCop for linting, run:

```bash
bundle exec rubocop (optional <-a> or <-A>)
```

To check Syntax error, run:

```bash
ruby -c <filePath>
```

### Development

- Explore the app directory for models, controllers, and views.
- Update config/routes.rb to manage API endpoints.
- Manage database schemas and migrations in the db directory.
- Verify Route Configuration
  ```bash
  rails routes
  ```
- Utilize health check endpoint, run:
  ```bash
  http://localhost:3000/up
  ```
- Suggested VS code extensions:
  - Ruby LSP
  - Solargraph
  - Rubocop
