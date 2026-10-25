# Validinv — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` — classe, formulaire associé `Validinv.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cstock` | `Calc_stock` |
| `DB_Connection` | `Create9`, `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `G`, `L`, `_call` |
| `Start` | `LocalSettings`, `Musique` |
| `TextReg` | `<form>`, `EstDate`, `Type`, `dte` |
| `Utils` | `Observers`, `Option`, `db` |
| `calculdroit` | `<type>`, `vol`, `volap` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_HisInvT`, `Fiches_Inv`, `Fiches_Parametres`, `Fiches_ligregie`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu84_Click` (`Fmenu.class:1064`, `Validinv.Show`).
- **Effet indirect** : `Validinv.class:190` → `Cstock.Calc_stock("", "")` → instance automatique
  cachée de `Calcstock` (ses radios par défaut) : aucun recalcul (CSTOCK-A01). À reworker dans le
  même commit que `Cstock` (CSTOCK-003) et `Calcstock`.
- `UTILS-A04` cite `Validinv` comme appelant de `Utils.Cdate_Comp` : ce n'est le cas que dans le
  code **commenté** (l. 98-153) ; aucun appel actif (faux positif à corriger dans Utils).
- Tables par littéral (non `Cbase`) : `Fiches_Parametres`, `Fiches_ligregie`, `Fiches_regie`,
  `Fiches_Inv`, `Fiches_Art` (dans `button4_Click`), `Fiches_HisInvT`.
- Tables **non** touchées malgré le lien métier : `Fiches_StkDepots`, `Fiches_Sdepots`.
- Consommateurs de `dteinv` / `art_stkdep` écrits ici : `Cstock`, `Stockmvt`, `Calcstock`.
- Signaux `deps.py` : aucun (vérifié). Aucun appel dynamique.
