# BordereauxC — Dépendances

> Source : `.src/Compta/Impressions/BordereauxC.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/BordereauxC.class` — classe, formulaire associé `BordereauxC.form`
- Handlers GUI détectés : 8

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Bordereaux` | `<hérité>` |
| `Cbase` | `Table` |
| `Cbordereaux` | `<type>`, `Entete`, `Level6`, `Level7`, `Level8`, `Ligne`, `TitreB` |
| `Csolde` | `Solde_caisse` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Cdate_Dbase`, `Fcolr`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_BordereauxC`, `Fiches_ClientCaisse`, `Fiches_Comptes`, `Fiches_Journaux`, `Fiches_LigTicketz`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Recup_Cheques`, `Imp_Bordereaux`, `Maj_Collectif`, `Parametres`, `Ecritures`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu321_Click` (`.src/Communs/Fmenu.class:2427`, menu « Bordereaux
  chèques (ancienne version) »).
- **Portée réductible** : confirmée pour `Recup_Cheques`, `Imp_Bordereaux`, `Maj_Collectif` ;
  à ajouter `Parametres` et `Ecritures` (aucun appel externe, `grep -rn "BordereauxC\." .src`).
  **Faux positif** : `Grd1_Save` est l'événement `Save` de la `TableView` `Grd1` : il doit rester
  `Public`.
- **Dépendance vers le formulaire de caisse** : la ligne `Bordereaux | <hérité>` correspond à
  `Bordereaux.Text` (l. 370), qui référence l'auto-instance de `.src/Caisse/Bordereaux.form` (titre
  vide) au lieu du champ `Nbordereau` ; dépendance accidentelle à supprimer avec BORDEREAUXC-A01.
- **Tables** : `Fiches_LigTicketz` est un **faux positif** (variable `Tab` affectée et jamais
  utilisée). Tables réellement touchées : `Fiches_BordereauxC` (lecture, insertion, mise à jour,
  suppression), `Fiches_Mvt` (insertions, mises à jour, lecture des lots), `Fiches_Comptes`
  (lecture, mise à jour du solde du collectif), `Fiches_Parametres` (lecture et mise à jour des
  compteurs), `Fiches_Journaux`, `Fiches_ClientCaisse`.
- **Écrivains de `Fiches_BordereauxC`** : cet écran seul (saisie dans `Grd1`) ; `LauruxMaj` crée la
  table. Le moulinage de caisse ([Moulinage](../../../Caisse/Moulinage.class/dependencies.md)) ne
  l'alimente plus depuis `d2a027d8` (2020, passage aux règlements `EcrReg`) : il ne la cite que
  dans son `LOCK TABLES`, et son message « effacer les bordereaux » est obsolète (MOULINAGE-A15).
- **Liens avec le lot Caisse** : `Maj_Collectif`, `Ecritures`, `Parametres` sont partagés avec
  [Moulinage](../../../Caisse/Moulinage.class/architecture.md) (MOULINAGE-014, MOULINAGE-A01) ;
  `Bordereaux.Text` vise le formulaire [Caisse/Bordereaux](../../../Caisse/Bordereaux.class/dependencies.md).
- **Services comptables appelés** : `Csolde.Solde_caisse` (recalcul complet du solde d'un compte)
  et `Sha1Calc.CalcSha1` (empreinte de l'écriture `numr`) : tous deux modifient la base.
- **Code dupliqué** : `Moulinage.Ecritures` (l. 2206), `Moulinage.Parametres` (l. 2235),
  `Moulinage.Maj_Collectif` (l. 2618) ; tout rework commun doit être fait dans le même lot que
  Moulinage (Caisse, gros fichier legacy : changement minimal).
- Aucun appel dynamique ; pas de dépendance circulaire.
