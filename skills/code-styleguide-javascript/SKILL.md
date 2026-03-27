---
name: code-styleguide-javascript
description: "**DOMAIN SKILL** — Enforce JavaScript Standard Style and project hygiene. USE FOR: writing or reviewing JavaScript/JSX code; creating new files, functions, or components; refactoring; code reviews. DO NOT USE FOR: non-JavaScript languages; configuration-only changes; documentation-only edits."
---

# Code Style Guide — JavaScript

## Standard Style

All JavaScript code MUST follow [JavaScript Standard Style](https://standardjs.com/). Key rules:

- **No semicolons** — mai usare il punto e virgola a fine riga
- **2 spazi** per l'indentazione, mai tab
- **Singoli apici** per le stringhe (`'hello'`), mai doppi apici
- **Nessuna variabile inutilizzata** — rimuovi import e variabili non usate
- **Spazio dopo le keyword** — `if (condition)` non `if(condition)`
- **Spazio prima delle parentesi graffe** — `function name () {` non `function name(){`
- **Sempre `===`** invece di `==` (tranne per `null` check: `== null`)
- **Gestire `err`** nei callback Node.js
- **Prefisso `window.`** per le globali del browser (tranne `document` e `navigator`)
- **No `var`** — usare `const` di default, `let` solo se la variabile viene riassegnata

### Template literals

Usa i template literals (`` `hello ${name}` ``) invece della concatenazione di stringhe.

### Arrow functions

Preferire le arrow functions per callback e funzioni anonime:

```js
// Sì
const items = list.map((item) => item.name)

// No
const items = list.map(function (item) { return item.name })
```

### Destructuring

Usare destructuring per estrarre valori da oggetti e array:

```js
// Sì
const { name, age } = user
const [first, second] = items

// No
const name = user.name
const age = user.age
```

### Import/Export

Preferire ESM (`import`/`export`) rispetto a CommonJS (`require`/`module.exports`) nei progetti che lo supportano.

## Riuso del codice

Prima di creare una nuova funzione, componente o utility, **cerca sempre nel progetto se esiste già qualcosa di simile o riutilizzabile**.

### Procedura obbligatoria

1. **Cerca prima** — Usa ricerca semantica o grep nel progetto per trovare funzioni, componenti o helper che fanno già quello che serve
2. **Riusa** — Se esiste qualcosa di simile, riusalo direttamente o estendilo aggiungendo parametri/opzioni
3. **Generalizza** — Se una funzione esistente fa quasi la stessa cosa, valuta se generalizzarla invece di crearne una nuova
4. **Crea solo se necessario** — Crea una nuova funzione/componente solo se non esiste nulla di riutilizzabile

### Segnali di duplicazione

Quando stai per scrivere codice, chiediti:
- Esiste già un helper/utility che fa questo?
- C'è un componente simile che potrebbe essere parametrizzato?
- Questa logica è già presente altrove nel progetto?

Se la risposta è sì a una di queste domande, riusa il codice esistente.

### Estrazione di codice comune

Se trovi lo stesso pattern ripetuto in più punti:
- Estrailo in una funzione/componente condiviso
- Posizionalo nella cartella appropriata (vedi sezione successiva)
- Aggiorna i punti esistenti per usare la versione condivisa

## Posizionamento file nel progetto

Quando crei nuovi file, **rispetta la struttura e le convenzioni esistenti** del progetto.

### Procedura obbligatoria

1. **Analizza la struttura** — Prima di creare un file, esplora la struttura del progetto per capire dove vanno posizionati i diversi tipi di file
2. **Segui i pattern** — Se il progetto ha una convenzione (es. componenti in `components/`, utility in `utils/`, hook in `hooks/`), seguila
3. **Coerenza** — Un file dello stesso tipo deve andare nella stessa cartella dei suoi simili
4. **Non creare cartelle nuove** senza necessità — usa quelle esistenti quando possibile

### Regole generali

| Tipo di file | Dove cercarlo |
|---|---|
| Componenti UI | `components/`, `src/components/`, o nella feature corrispondente |
| Utility/Helper | `utils/`, `lib/`, `libs/`, `helpers/` |
| Hook (React) | `hooks/`, `src/hooks/` |
| Costanti | `constants/`, `config/` |
| Tipi/Interfacce | `types/`, o co-locati con il modulo |
| Test | Co-locati (`__tests__/`, `.test.js`) o in `test/` |
| Servizi/API | `services/`, `api/` |
| Store/State | `store/`, `state/` |

Se il progetto non ha una di queste cartelle, **guarda dove sono posizionati file simili** e segui la stessa convenzione.
