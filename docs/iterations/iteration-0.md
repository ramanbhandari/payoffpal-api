# Iteration 0: Planning and Setup

## 1. Overview
**Objective**: The goal of Iteration 0 is to set up the development environment, establish project structure, and plan the features and tasks for the first development iteration.

## 2. Project Setup

### Repository Structure

- **Backend**: The backend codebase will be in the `payoffpal-api` repository. The structure will include:
  - `app/`: Contains models, controllers, views, jobs, mailers.
  - `config/`: Configuration files for the application.
  - `db/`: Database-related files, migrations, seeds.
  - `docs/`: Documentation, including iterations.

### Environment Setup

- **Backend**:
  - Install Ruby and Rails.
  - Set up PostgreSQL.
  - Install dependencies via `bundle install`.
  - Run database migrations with `rails db:migrate`.

### Version Control
- **Git Workflow**: Use `main` for production-ready code, `develop` for ongoing development, and feature branches for individual tasks.
- **Commit Guidelines**: Use descriptive commit messages following the pattern: `feat:`, `fix:`, `chore:`, etc.

## 3. Goals for Iteration 0

### Feature Planning
- Identify core MVP features.
- List specific tasks for Iteration 0.

### Research & Prototyping
- Research OAuth integration.
- Prototype the authentication mechanism.

## 4. Tasks & Assignments
- **Setup CI/CD**
- **Create Initial API Endpoints**
- **Implement Redux**

## 5. Deliverables
- A working development environment.
- Basic API with routes.
- Initial frontend setup with React and Redux.
- Documentation on setup and running the project.

## 7. Timeline
- **Week 1 - September 1, 2024 to September 7, 2024**: Complete environment setup and initial API routes.
- **Week 2 September 1, 2024 to September 7, 2024**: Implement Redux and create initial React components.