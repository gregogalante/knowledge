---
name: local-env-python
description: "**WORKFLOW SKILL** — Python local environment setup via Conda. USE FOR: running Python scripts; installing Python packages; creating or activating Python environments; any task requiring the Python interpreter or pip. DO NOT USE FOR: non-Python tasks; Node.js/Ruby environments."
---

# Local Env — Python

## Setup

Python è installato e gestito tramite **Conda**. Non è disponibile un Python di sistema globale: per usare Python bisogna sempre attivare un environment Conda.

## Regole obbligatorie

### 1. Chiedere PRIMA di attivare un environment

**PRIMA** di eseguire qualsiasi comando Python o installare pacchetti, chiedi SEMPRE all'utente:

> Vuoi usare l'environment Conda **base** oppure preferisci crearne uno dedicato per questo progetto?

Attendi la risposta prima di procedere.

### 2. Attivare l'environment scelto

- **Se l'utente sceglie `base`**: attiva con `conda activate` (senza argomenti attiva base).
- **Se l'utente vuole un environment dedicato**: chiedi il nome da usare, poi crea e attiva:
  ```sh
  conda create -n <nome_env> python -y
  conda activate <nome_env>
  ```

### 3. Installazione pacchetti

- Preferire `conda install <pacchetto>` quando disponibile.
- Usare `pip install <pacchetto>` solo se il pacchetto non è disponibile su Conda.

### 4. Verifica

Dopo l'attivazione, verifica che l'environment sia corretto con:

```sh
which python
python --version
```