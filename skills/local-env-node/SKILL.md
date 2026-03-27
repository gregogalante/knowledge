---
name: local-env-node
description: "**WORKFLOW SKILL** — Node.js local environment setup via nvm. USE FOR: running Node.js scripts; installing npm/yarn packages; switching Node.js versions; any task requiring node, npm, or npx. DO NOT USE FOR: non-Node.js tasks; Python/Ruby environments."
---

# Local Env — Node.js

## Setup

Node.js è installato e gestito tramite **nvm** (Node Version Manager). Non è disponibile un Node di sistema globale: per usare Node bisogna prima inizializzare nvm.

## Regole obbligatorie

### 1. Chiedere PRIMA di attivare una versione

**PRIMA** di eseguire qualsiasi comando Node.js, npm o npx, chiedi SEMPRE all'utente:

> Vuoi usare la versione Node.js **di default** oppure preferisci usarne una specifica?

Attendi la risposta prima di procedere.

### 2. Attivare la versione scelta

- **Se l'utente sceglie la versione di default**: esegui `nvm use default`.
- **Se l'utente vuole una versione specifica**: installa (se necessario) e attiva:
  ```sh
  nvm install <versione>
  nvm use <versione>
  ```

### 3. Installazione pacchetti

- Usare `npm install <pacchetto>` per i pacchetti.
- Se il progetto usa yarn o pnpm, rispettare il lock file presente.

### 4. Verifica

Dopo l'attivazione, verifica che la versione sia corretta con:

```sh
which node
node --version
npm --version
```