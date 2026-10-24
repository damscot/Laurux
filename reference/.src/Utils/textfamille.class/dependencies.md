# textfamille — Dépendances

> Source : `.src/Utils/textfamille.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/textfamille.class` — classe, hérite de `ScrollView`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdArt1.class` | `<form>`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/Articles.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/CoefTypeC.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/Famille.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/Movr.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/Remisec.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Gestion/Tables/Remisecli.class` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |
| `.src/Utils/Changefam.class` | `<form>`, `<type>`, `Clear`, `Select`, `setfocus`, `text` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Contrôles déclarés dans les `.form` (grep `textfamille`) : `Changefam` (`afam`, `Nfam`, `Afam2`,
  `Nfam2`), `Articles` (`fam`), `EdArt1` (`Fam`, `Fam2`), `Movr` (`fam`), `Famille` (`cdf`),
  `CoefTypeC`, `Remisec`, `Remisecli` (`Cdf`). Les noms de groupe (`Cmpt`, `rem`) font que les
  événements `KeyPress`/`LostFocus` sont reçus par des handlers de groupe des écrans.
- **Faux positif** : `Clear` est appelé sur ces contrôles (`Changefam.class:144,180`), comme
  `setfocus`/`Select` (`Famille.class:418`, `Articles.class:910`) ; l'heuristique ne résout pas les
  méthodes appelées sur les contrôles typés par le `.form`.
- Paramètre partagé avec `Trifam` (`/Soc<XX>/ipr`).
- **Ordre de rework** : avant `Changefam` et les écrans de tables ; l'API (`text`, `Clear`,
  `setfocus`, `Select`, événements `KeyPress`/`LostFocus`/`GotFocus`) doit rester inchangée.
