Il progetto vuole fornire un archivio di facile consultazione degli effettivi testi e modifiche relativi alla Riforma della Giustizia (legge costituzionale pubblicata in Gazzetta Ufficiale n. 253 del 30 ottobre 2025, recante "Norme in materia di ordinamento giurisdizionale e di istituzione della Corte disciplinare") e una _knowledge base_ interrogabile tramite LLM.

Maggiori dettagli qui: [https://www.andreabertoloni.com/riforma-costituzionale-giustizia](https://www.andreabertoloni.com/riforma-costituzionale-giustizia)

## Descrizione

Il file `full-text.txt` contiene il testo completo della riforma, ripreso dalla Gazzetta Ufficiale (vedi [qui](https://www.gazzettaufficiale.it/eli/id/2025/10/30/25A05968/sg) e [qui](https://www.gazzettaufficiale.it/eli/gu/2025/10/30/253/sg/pdf)).

### Testi degli articoli

I file `articles/N/new.txt`, dove `N` rappresenta il numero identificativo di ogni articolo della Costituzione interessato dalla riforma, sono stati **creati manualmente** basandosi sulle indicazioni espresse nel testo integrale della legge, partendo dai testi originali dei medesimi articoli, contenuti nei file `articles/N/old.txt`.

Per esempio, partendo dal testo originale dell' Art. 87, contenuto nel file `articles/87/old.txt` e seguendo le indicazioni del testo della legge relative alle modifiche all' Art. 87, è stato creato manualmente il testo contenuto nel file `articles/87/new.txt`.

### Diff

Sulla base di questi documenti sono stati generati automaticamente i file `diffs/N.diff`, che evidenziano le modifiche per ognuno degli articoli interessati dalla riforma.

### Knowledge base

È stato infine creato il file `knowledge-base.md` (generato automaticamente a partire da `knowledge-base.md.tmpl`) che costituisce una _knowledge base_ interrogabile tramite LLM, con istruzioni e dati strutturati per vincolarne il comportamento e **ridurre** il rischio di allucinazioni o interpretazioni non fondate sui testi ufficiali.

## Contributi

Dopo aver clonato il progetto, installare il pre-commit hook per evitare di creare commit con una versione non aggiornata di `knowledge-base.md`:

```sh
make install-hooks
```

Gli unici file che vanno editati manualmente sono:

- `articles/*` (qualora si dovessero riscontrare degli errori nei testi)
- `knowledge-base.md.tmpl`

I file `diffs/*` e `knowledge-base.md` non devono essere editati, ma vengono generati automaticamente a partire dai precedenti, tramite il comando:

```sh
make
```

> **Nota:** `make` aggiorna solo i file le cui sorgenti sono cambiate. Per forzare la rigenerazione completa: `make -B`.
