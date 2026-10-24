# ArtPromo — Dépendances

> Source : `.src/Gestion/Tables/ArtPromo.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/ArtPromo.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Intitule_Promo`, `Maj_qteplus`, `Prix_Promo`, `Prix_Promottc`, `art_Promo` |
| `.src/Gestion/Facturation/Facture.class` | `Maj_qtemoins`, `Maj_qteplus`, `art_Promo` |
| `.src/Gestion/Tables/Articles.class` | `art_Promo` |
| `.src/Utils/TarArt.class` | `Prix_Promo`, `art_Promo` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_ArtPromo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Liste des appelants confirmée par grep : `Caisse` (13 appels), `Facture` (11), `Articles` (1),
  `TarArt` (2). Aucun appel dynamique.
- La détermination du code de promotion en cours (`Fiches_Promo`) est faite par chaque appelant
  (`Articles.class:231`, `Caisse.class:218`, `Facture.class:508`) et non par le module : dépendance
  implicite sur la même règle « première promotion active du jour ».
- `art_Promo` renvoie une chaîne (`"T"`/`""`) : `TarArt.class:123` la teste directement dans un
  `If`, les autres l'affectent à un `Boolean`. Tout changement du type de retour doit vérifier ces
  14 sites (ARTPROMO-005).
- Écriture : `Fiches_ArtPromo.qte` (`Maj_qteplus`/`Maj_qtemoins`) ; lecture seule sinon.
- Autres fichiers qui accèdent directement à `Fiches_ArtPromo` sans passer par le module :
  `FpromoArt`, `StatPromo`, `EtiqPromo`, `Changefam.Modifart` (renommage de code).
- Ordre de rework : ARTPROMO-001 à 003 sans dépendance ; ARTPROMO-004 avant ARTICLES-014 et les
  cases équivalentes de `Caisse` et `Facture` ; ARTPROMO-005 dans le même commit que la vérification
  des appelants.
