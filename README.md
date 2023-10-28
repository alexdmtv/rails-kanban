# Example of a Kanban Board Application created using Rails & Hotwire

Welcome to my Rails Kanban Board application. It's a demonstration project created from scratch using
the [FrontEnd Mentor figma design and images](https://www.frontendmentor.io/challenges/kanban-task-management-web-app-wgQLt-HlbB).
I've utilized standard Rails MVC practices along with Turbo and Stimulus JS from the Hotwire toolset to make the app
interactive and provide a SPA-like experience.

## Features

* **Boards**: Create and manage multiple Kanban boards.
* **Lists** (Columns): Create lists to organize your tasks. Rearrange them by dragging.
* **Cards** (Tasks): Create tasks with descriptions. Rearrange them within or between lists by dragging.
* **Subtasks**: Add actionable subtasks to your main tasks for a more detailed level of granularity.
* **Real-time Updates**: Utilizing Hotwire, observe real-time updates without the need for full-page reloads.
* **Drag & Drop**: Powered by Sortable JS, offering a seamless user experience in organizing tasks and columns.
* **Authentication**: Powered by the Devise gem. Supports GitHub social login as well as standard email + password.

## Quick Start

1. Clone the repository.
2. For complete functionality, set up all related third-party accounts (Postmark and GitHub app for SSO).
3. Copy and rename `.env.template` to `.env` and fill in the missing values (GitHub secret and Postmark).
4. Set up a Postgres database with the username and password "postgres."
5. Run `bin/bundle install` to install all Ruby dependencies.
6. Install the Yarn package manager.
7. Run `yarn install` to install JavaScript dependencies.
8. Run `bin/rails db:prepare` to create the database and run migrations.
9. Run `bin/dev` to start the server.

This application is deployed and can be accessed via the following
URL: [https://rails-kanban-production.up.railway.app/](https://rails-kanban-production.up.railway.app/)