---
name: lato-documentation
description: "**GEM SKILL** — Lato Rails engine: complete documentation and patterns. Auto-applies when working with the Lato gem, Lato:: classes, or lato_ helpers in any Rails project. USE FOR: lato_index, lato_form, lato_page_head, lato_action components; controllers extending Lato::ApplicationController; CRUD interfaces; authenticate_session; session management; Lato initializer config; operations and Lato::ApplicationJob; invitations; layout/sidebar/navbar; Turbo Frame with Lato. ALWAYS read lato-documentation.txt for full reference. DO NOT USE FOR: non-Rails projects; generic Rails without Lato."
---

# Ruby Gem — Lato Documentation

Lato is Rails engine for auth/session/UI scaffolding. This skill defines operational workflow, not full API reference.

**Canonical source**: ALWAYS read `lato-documentation.txt` in same folder for full API/patterns/examples.

## When to use

Use this skill when task includes any of:
- `Lato::` classes/modules
- `lato_` helpers/components
- controllers/layout/session flow built on Lato
- specific Lato patterns (index, form, operations, etc.)

Do not use for generic Rails tasks without Lato usage.

## Mandatory procedure

Follow in order:

1. **Detect Lato scope**
   - Check touched files for `Lato::`, `lato_`, mounted Lato routes, or inherited `Lato::ApplicationController`.
2. **Read targeted sections from `lato-documentation.txt`**
   - Read only sections needed by task (CRUD, components, operations, config, invitations, etc.).
3. **Apply verifiable rules below**
   - For each applied rule, run quick code check in modified files.
4. **Verify behavior locally**
   - Run relevant Rails checks/tests for changed area.
5. **Report rule compliance**
   - In final response, list which Lato rules were applied and where.

## Verifiable rules (trigger + check + exception)

1. **Controller base and layout**
   - Trigger: controller belongs to Lato-backed area.
   - Rule: inherit from `Lato::ApplicationController` and use `layout 'lato/application'`.
   - Check: controller class declaration + layout line present.
   - Exception: explicit project rule uses different base/layout for non-panel/public area.

2. **Session protection**
   - Trigger: page/action should be protected.
   - Rule: enforce `before_action :authenticate_session` (or equivalent guard from Lato session concern).
   - Check: before_action/guard present in controller.
   - Exception: public endpoints (landing, signup flows, webhooks) intentionally unauthenticated.

3. **Session user access**
   - Trigger: need current user id.
   - Rule: prefer `@session.user_id` over `@session.user.id`.
   - Check: no new `@session.user.id` usage in touched code.
   - Exception: full user object required for non-id fields.

4. **Lato index pattern**
   - Trigger: building searchable/sortable paginated index.
   - Rule: use `lato_index_collection`; model defines `lato_index_order` + `lato_index_search` when needed.
   - Check: controller index uses helper; model scopes exist.
   - Exception: trivial static list without Lato index requirements.

5. **Form Turbo/Lato integration**
   - Trigger: Lato form partial or in-page overlay form.
   - Rule: use `turbo_frame_tag dom_id(record, 'form')` and `form_with data: { turbo_frame: '_self', controller: 'lato-form' }`.
   - Check: partial contains frame + form data attributes.
   - Exception: non-overlay standalone form by explicit design.

6. **Action response format**
   - Trigger: CRUD/action endpoints returning browser + API behavior.
   - Rule: provide `respond_to` with `format.html` and `format.json` where applicable.
   - Check: respond_to block covers needed formats.
   - Exception: endpoint explicitly single-format.

7. **Background operations**
   - Trigger: long-running job exposed via Lato operation UI.
   - Rule: job extends `Lato::ApplicationJob` and `perform(params = {})` hash signature.
   - Check: job inheritance/signature + operation generation/start flow.
   - Exception: non-Lato internal jobs not surfaced as operations.

## Output contract (Definition of Done)

Task using this skill is done when:
1. Relevant `lato-documentation.txt` sections were consulted.
2. Applied Lato rules are listed with file paths.
3. Local verification executed (tests/commands) for touched behavior.
4. Any intentional rule deviation documented with reason.

If blocked (missing docs/context/env), return:
- blocker,
- attempted checks,
- minimal user input needed.

## Language

Use same language as user conversation.
