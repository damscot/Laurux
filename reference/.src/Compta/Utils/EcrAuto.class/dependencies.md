# EcrAuto — Dépendances

> Source : `.src/Compta/Utils/EcrAuto.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/EcrAuto.class` — classe, Create Static
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>`, `ecriture` |
| `.src/Compta/Utils/EcrReg.class` | `<type>`, `Vecr`, `resjou` |
| `.src/Gestion/Facturation/ObjFac.class` | `<type>`, `ecriture`, `numecr`, `numerodef`, `numfac`, `resjou` |
| `.src/Gestion/Facturation/SaiReg.class` | `FinImp`, `Imp`, `Impression`, `ecriture` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `FinImp`, `Imp`, `Impression`, `ecriture`, `numecr` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec`, `LockIncrement` |
| `DocActif` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `LDate` | `G`, `L`, `_call` |
| `LGed` | `<type>`, `AddTags`, `Comptabilite`, `PDFDupli`, `Search`, `Supprime` |
| `LVar` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `Listextcpt` | `<type>`, `Controle`, `Ecart`, `letcpt`, `letgroupe`, `rechechelot`, `resext` |
| `Mreglement` | `lcr_acc`, `sans_lcr` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `arrondi`, `db` |
| `VarEcr` | `<type>`, `Autre`, `L_ajou`, `L_caisse`, `L_modif`, `L_sup`, `L_valide`, `Tlettrage`, `Treso`, `Vente`, `collectif`, `compte`, `divers`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `lind`, `montantc`, `montantd`, `nb`, `numdoc`, `numero`, `numlot`, `plus`, `somme`, `type` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Traites`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Appelants réels** :
  - `ObjFac.class:994-1002` : `New EcrAuto("", lignecom)` (vente, journal pris dans les paramètres),
    puis `ecriture`, `resjou`, `numfac`, `numecr`, `numerodef` ;
  - `ValidBR1.class:259`, `:303` : `New EcrAuto(jrnal5, vecr)`, `ecriture`, `Imp`, `Impression`,
    `FinImp` (via `validefin`), `numecr` ;
  - `EcrReg` (héritage) et, par lui, `SaiReg.class:968`, `:1060` et `Moulinage.class:2561` ;
  - `EcrAuto.Lettrage` lui-même (`New EcrAuto(jrnod, ecrdif)`, récursion).
- `Moulinage.class:2522` déclare une variable `EcrAuto` (type seulement).
- **`Create Static` inutilisé** : aucun accès `EcrAuto.<membre>` statique (grep `EcrAuto\.`).
- **Héritage** : `EcrReg` lit `Me.Vecr` et `Me.resjou` ; toute modification de ces membres touche
  `EcrReg`.
- **Effets de bord transverses** : verrous `LOCK TABLES` MySQL (neutralisés sous SQLite par
  `DB_Connection`), verrou applicatif `DocActif` « Reglement », compteurs de `Fiches_Parametres`,
  clé chaînée `Sha1Calc`.
- **SQLite** : `insert … value (…)` dans `traite` n'est pas traduit par `DB_Connection` (erreur
  SQLite) ; `provisoire=False` est accepté par SQLite ≥ 3.23 (à confirmer selon la version livrée).
- **Ordre de rework** : `VarEcr` → `EcrAuto` → `EcrReg`, après stabilisation de `LGed.Archive` et
  du helper `LVar` ; replays de `ObjFac`, `ValidBR1`, `SaiReg`, `Moulinage` à repasser.
