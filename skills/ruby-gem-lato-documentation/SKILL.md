---
name: ruby-gem-lato-documentation
description: "**DOMAIN SKILL** — Rails engine Lato gem: authentication, UI components, CRUD, operations, invitations, configuration. USE FOR: building pages/controllers/views with Lato; using lato_index, lato_form, lato_page_head components; creating CRUD interfaces; configuring Lato; managing operations/jobs; authentication/session management; customizing layout/sidebar/navbar. DO NOT USE FOR: non-Rails projects; front-end-only changes without Lato components; generic Rails questions unrelated to Lato."
---

# Ruby Gem — Lato Documentation

Lato is a Rails Engine that provides a comprehensive web application starter kit with user management, authentication, and UI components for Ruby on Rails 7+.

**IMPORTANT**: For complete and up-to-date documentation on components, API, tutorials, and usage patterns, ALWAYS read the `lato-documentation.txt` file in the same folder as this skill. That file contains detailed gem documentation and is updated separately.

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
11. **ALWAYS read `lato-documentation.txt`** in the same folder as this skill for complete documentation on components, API, and usage patterns.
