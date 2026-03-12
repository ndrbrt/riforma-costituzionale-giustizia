This project aims to provide an easy-to-consult archive of the actual texts and changes related to the Justice Reform (legge costituzionale pubblicata in Gazzetta Ufficiale n. 253 del 30 ottobre 2025, recante "Norme in materia di ordinamento giurisdizionale e di istituzione della Corte disciplinare") and a knowledge base queryable through LLMs.

More details here: [https://www.andreabertoloni.com/riforma-costituzionale-giustizia](https://www.andreabertoloni.com/riforma-costituzionale-giustizia)

## Description

The file `full-text.txt` contains the full text of the reform, taken from the _Gazzetta Ufficiale_ (see [here](https://www.gazzettaufficiale.it/eli/id/2025/10/30/25A05968/sg) and [here](https://www.gazzettaufficiale.it/eli/gu/2025/10/30/253/sg/pdf)).

### Article texts

The files `articles/N/new.txt`, where `N` represents the identifying number of each article of the Constitution affected by the reform, were **manually created** based on the instructions expressed in the full text of the law, starting from the original texts of those same articles, contained in the files `articles/N/old.txt`.

For example, starting from the original text of Art. 87, contained in the file `articles/87/old.txt` and following the instructions in the text of the law regarding the changes to Art. 87, the text contained in the file `articles/87/new.txt` was manually created.

### Diffs

Based on these documents, the files `diffs/N.diff` were automatically generated, highlighting the changes for each of the articles affected by the reform.

### Knowledge base

Finally, the file `docs.md` was created (automatically generated from `docs.md.tmpl`) which constitutes a knowledge base queryable through LLMs, with instructions and structured data to constrain their behaviour and **reduce** the risk of hallucinations or interpretations not grounded in the official texts.

## Contributing

After cloning the project, install the pre-commit hook to avoid creating commits with an outdated version of `docs.md`:

```sh
make install-hooks
```

The only files that should be edited manually are:

- `articles/*` (in case errors are found in the texts)
- `docs.md.tmpl`

The files `diffs/*` and `docs.md` must not be edited, as they are automatically generated from the above, via the command:

```sh
make
```

> **Note:** `make` only updates files whose sources have changed. To force a full regeneration: `make -B`.
