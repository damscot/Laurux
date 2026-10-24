# Editcompte — Dépendances

> Source : `.src/Compta/Impressions/Editcompte.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Editcompte.class` — classe, formulaire associé `Editcompte.form`
- Handlers GUI détectés : 18
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `content1`, `donnees2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Impressions/EditcompteM.module` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `EditcompteM` | `Imprime` |
| `Editeur` | `Prog_Editeur` |
| `Start` | `Musique`, `son` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `dteN0_LostFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Raz`, `content1`, `donnees`, `donnees2`, `Button1_Click`, `Centralisation`, `finmois`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** : `Fmenu.Menu38_Click` (`Fmenu.class:704`, `Editcompte.Show`, auto-instance, menu
  « Grands livres »). `EditcompteM` modifie `Editcompte.Mouse` (l. 100, 274) : dépendance circulaire
  `Editcompte` ↔ `EditcompteM`, à reworker ensemble.
- **Faux positifs « portée réductible »** : `Bsel`, `Bval` (écrits par `TriCpt` via
  `Object.SetProperty`, `TriCpt.class:112-113`).
- **Pseudo-handlers** : `dteN0_LostFocus` et `dteN1_LostFocus` sont détectés comme handlers, mais
  `dteN0`/`dten1` sont dans le groupe `Cmpt` du `.form` : l'événement `LostFocus` serait levé sous le
  nom `Cmpt_LostFocus` (inexistant). Ils ne sont appelés que par `Cmpt_KeyPress`. Ils gardent leur nom
  et leur portée.
- **Tables non vues comme telles** : `Ctrln` (table de travail créée, remplie, détruite ici ; nom en dur
  partagé avec `EditcompteM`, `Extrait`, `FTVA`, `EdImpayes`, `EdNjustifiees`). C'est la seule
  **écriture en base** de l'écran (export). Toutes les autres tables sont en dur (`Fiches_Parametres`,
  `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_Comptes`) : `deps.py` les voit comme littéraux.
- **Contrôles du `.form`** : groupes `Cmpt` (`DteN0` tag 1, `Dten1` tag 2, `Cpt` tag 3, `Cpt2` tag 4) et
  `Btn` (`Button2` tag 1, `Button1` tag 2 — groupe écrit `btn`, insensible à la casse —, `Button6`
  tag 3) ; `Bclient`, `Bfournisseur`, `Bgestion`, `Bbilan`, `Bgen` ; `E0`, `E1`, `N1`…`N5`.
- **`TriCpt` avec `type = "BG"`** : chaîne non reconnue par `TriCpt._new` → mode `Tous` par défaut.
- **Programmes externes** : `Editeur.Prog_Editeur` (ouverture de `~/tmp/Glivre.txt`), `Doc.Open`.
- **Ordre de rework** : EDITCOMPTE-006 (centralisation commune) après la création du helper commun, dans
  le même lot que EDITCOMPTEM-005 et EDITCOMPTEA-004 ; la commonalisation des bornes d'exercice avec
  `Balance` (BALANCE-004) en phase 3.
