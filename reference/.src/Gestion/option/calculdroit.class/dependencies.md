# calculdroit — Dépendances

> Source : `.src/Gestion/option/calculdroit.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/calculdroit.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Impressions/Edart4.class` | `droit`, `secu`, `tva` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` | `<type>`, `vol`, `volap` |
| `.src/Gestion/Stock/Mvtex.class` | `<type>`, `droit`, `secu`, `tauxtvadr`, `tauxtvass`, `vol`, `volap`, `volumess` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>`, `droit`, `drsurfac` |
| `.src/Gestion/option/Caleditcmat.class` | `<type>`, `droit`, `secu`, `vol`, `volap`, `volumess` |
| `.src/Gestion/option/EditStkDepart.class` | `<type>`, `vol`, `volap`, `volumess` |
| `.src/Gestion/option/ObjFacB.class` | `<type>`, `codetva`, `cptreg`, `droit`, `drsurfac`, `famille`, `secu`, `suspendu`, `tauxtvadr`, `tauxtvass`, `tvadroit`, `tvasec`, `type`, `vol`, `volap`, `volumess` |
| `.src/Gestion/option/Saisiedecons.class` | `<type>`, `droit`, `drsurfac` |
| `.src/Gestion/option/Tregie.class` | `<type>`, `droit`, `secu` |
| `.src/Gestion/option/artopt.class` | `<type>`, `droit`, `secu` |
| `.src/Gestion/option/facopt.class` | `<type>`, `droit`, `drsurfac`, `lib`, `secu`, `suspendu`, `tva`, `vol`, `volap` |
| `.src/Gestion/option/fourconsdroi.class` | `<type>`, `drsurfac`, `suspendu`, `vol`, `volap` |
| `.src/Utils/TarArt.class` | `<type>`, `droit`, `drsurfac`, `secu`, `suspendu` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `arrondi`, `db` |

### Tables SQL référencées

`Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Constructions** (vérifiées par `grep`, 17 appels) : `TarArt:31`, `Saisiedecons:281`,
  `fourconsdroi:108` (code mort), `facopt:525`, `Caleditcmat:334,556`, `Tregie:482`, `artopt:321`,
  `EditStkDepart:139`, `Validinv:251`, `ValidBR:664`, `Mvtex:524,715`, `ObjFacB:140,181,436,484`
  (5 arguments avec `fam`). Toutes passent 4 ou 5 arguments, compatibles avec la signature.
- `Facture.class:4875` : `Dim cdr As Calculdroit` sans usage (variable locale morte de Facture).
- `Caleditcmat:334` reconstruit le volume unitaire à partir de `Fiches_ligregie` (`volume / qte ×
  100`) : la classe doit garder exactement la même formule de volume.
- Aucune réduction de portée possible ; aucune fonction morte ; aucun appel dynamique.
- `fourconsdroi` (code mort) est le seul utilisateur des propriétés dans une structure.
- Ordre de rework : indépendant de `calculdroit1` sauf pour CALCULDROIT1-006 (lecture de régie
  commune, même commit).
- **FACOPT-A04** (colonne libellé vide dans `facopt.affdroit`, `facopt.class:531`) : vérifié,
  `lib_Read` renvoie `$slib` = `Fiches_regie.nom` (l. 86) dans le cas nominal ; `lib` n'est vide que
  si `dra` est vide (sortie l. 48), si la TVA de la régie est absente (sortie l. 55) ou si la régie
  est inconnue. Rattaché à CALCULDROIT-A02 ; la cause de FACOPT-A04 est à rechercher dans les
  données (`art_dra = ''` passe le filtre `IS NOT NULL` de `facopt`) plutôt que dans `lib_Read`.
