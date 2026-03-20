---
name: lato-gem-documentation
description: "**DOMAIN SKILL** — Rails engine Lato gem: authentication, UI components, CRUD, operations, invitations, configuration. USE FOR: building pages/controllers/views with Lato; using lato_index, lato_form, lato_page_head components; creating CRUD interfaces; configuring Lato; managing operations/jobs; authentication/session management; customizing layout/sidebar/navbar. DO NOT USE FOR: non-Rails projects; front-end-only changes without Lato components; generic Rails questions unrelated to Lato."
---

# Lato Gem — Rails Engine

Lato is a Rails Engine that provides a comprehensive web application starter kit with user management, authentication, and UI components for Ruby on Rails 7+.

**IMPORTANT**: Per la documentazione completa e aggiornata su componenti, API, tutorial e pattern d'uso, leggere SEMPRE il file `lato-documentation.txt` presente nella stessa cartella di questa skill. Quel file contiene la documentazione di dettaglio della gemma e viene aggiornato separatamente.

## Features

- **User management** con sistema di autenticazione completo (signin, signup, recover password, email validation, Google Authenticator MFA, ETH wallet connection) e gestione account (settings, password change, email change).
- **Web interface** costruita con Bootstrap e Bootstrap Icons.
- **UI components integrati con Rails**: data tables (`lato_index`), forms (`lato_form`), modals, async job executions (`Lato::Operation`), overlays (actions), invitations, guide in-app.
- **Stack agnostic**: compatibile con PostgreSQL, MySQL, SQLite, Solid Queue, Sidekiq, Delayed Job, Redis, Memcached.
- **Customizable & extendable**: UI e funzionalità completamente personalizzabili. Possibilità di estendere il pannello con nuovi engine.
- **Rails 7+**: ESM import maps, Turbo, Stimulus. Front-end responsive, mobile friendly e accessibile.

## Eco-system

Engine aggiuntivi disponibili:
- **Lato Spaces**: gestione workspace multipli con inviti e ruoli.
- **Lato Settings**: gestione impostazioni applicazione da UI.
- **Lato Storage**: gestione Active Storage da UI.
- **Lato Users**: gestione utenti da UI.

## Installation

### Gemfile Dependencies

```ruby
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "sassc-rails"
gem "lato"
```

### Asset Manifest

File `app/assets/config/manifest.js`:

```js
//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
```

### Install Commands

```bash
bundle
rails active_storage:install
rails lato:install:application
rails lato:install:migrations
rails db:migrate
```

### Routes

In `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  mount Lato::Engine => "/lato"
end
```

### Styles

In `app/assets/stylesheets/application.scss`:

```scss
@import 'lato/application';
```

### JavaScript

In `app/javascript/application.js`:

```js
import "lato/application";
```

### I18n

In `config/application.rb`:

```ruby
config.i18n.available_locales = [:it, :en]
config.i18n.default_locale = :it
```

### Extra Tasks (PWA)

1. Completare la configurazione Lato nell'initializer
2. Aggiungere `public/icon.png` (minimo 512x512px)
3. Eseguire:

```bash
rails lato:generate:favicon
rails lato:generate:pwa
```

### Upgrade

```bash
bundle update lato
rails lato:install:application
rails lato:install:migrations
rails db:migrate
```

---

## Key Rules

1. **Always extend `Lato::ApplicationController`** and use `layout 'lato/application'`.
2. **Always use `before_action :authenticate_session`** for protected pages.
3. **Use `@session.user_id`** instead of `@session.user.id` for performance.
4. **Use `lato_index_collection`** in controllers for back-end powered indexes with pagination, sorting, and search.
5. **Use `turbo_frame_tag dom_id(record, 'form')`** for form partials to enable in-page overlays.
6. **Use `data: { turbo_frame: '_self', controller: 'lato-form' }`** on all `form_with` calls.
7. **Use `respond_to` blocks** with `format.html` and `format.json` in action endpoints.
8. **Define `lato_index_order` and `lato_index_search` scopes** on models that use lato_index with sorting/search.
9. **Define helper methods with format `model_column(record)`** to customize index column rendering.
10. **Jobs MUST extend `Lato::ApplicationJob`** and accept `params = {}` (Hash) in `perform`.
11. **SEMPRE leggere `lato-documentation.txt`** nella stessa cartella di questa skill per la documentazione completa su componenti, API e pattern d'uso.