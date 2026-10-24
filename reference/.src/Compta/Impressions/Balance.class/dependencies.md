# Balance — Dépendances

> Source : `.src/Compta/Impressions/Balance.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Balance.class` — classe, formulaire associé `Balance.form`
- Handlers GUI détectés : 16
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `donnees2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Impressions/BalanceM.module` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `BalanceM` | `Imprime` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `Start` | `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde`, `General` |
| `TypeClient` | `<form>`, `where` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `dteN0_LF`, `dteN1_LF`, `Compdate`, `compdate2`, `Raz`, `donnees2`, `donnees1`, `Button1_Click`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** : `Fmenu.Menu31_Click` (`Fmenu.class:741`, `Balance.Show`, auto-instance). `BalanceM`
  ne fait que modifier `Balance.Mouse` (l. 78, 251, 257) : il dépend de l'**auto-instance** du
  formulaire, ce qui interdit d'ouvrir l'écran par `New Balance`.
- **Faux positifs « portée réductible »** : `Bsel` et `Bval` sont écrits par `TriCpt`
  (`Object.SetProperty($obj, "Bsel"/"Bval")`, `TriCpt.class:112-113`) après `Button4_Click`/`Button5_Click`.
  Ils restent `Public`.
- **Homonymes** : `Caisse/Preferences.class:35-223` utilise un contrôle nommé `Balance` (case à cocher
  de balance de caisse) : sans rapport avec cette classe. `Echeancier.class:5` cite « Balance.class »
  dans un commentaire d'en-tête copié.
- **Tables** : `Fiches_Mvt` … `Fiches_Mvt5` via `Cbase.Table("TabMvt…")` (choix dynamique dans
  `Tab0`) ; `Fiches_Cli` en dur dans l'export client (l. 647) ; `Fiches_Parametres`, `Fiches_Societes`,
  `Fiches_Comptes` via `Cbase`. Aucune écriture en base.
- **Contrôles du `.form` utilisés** : `Bclient`, `Bfournisseur`, `Bgestion`, `dteN0`, `dteN1`, `Cpt`,
  `Cpt2`, `E0`…`E1`, `N1`…`N5`, `Impcumul`, `Impc`, `TypeClient1` (classe `TypeClient`, `Compta/Utils`).
  Groupes : `Bal` (4 `TextBox`, `Tag` 1 à 4) et `Btn` (`Button2` tag 1, `Button1` tag 2, `Button6`
  tag 3).
- **Dépendances fonctionnelles non vues** : `Editeur.Prog_Editeur` et `Doc.Open` lancent des programmes
  externes (éditeur texte, navigateur) ; `Utils.Cdate_calc` peut afficher un `Message.Error`.
- **Ordre de rework** : `Balance` et `BalanceM` forment un couple (signature de `BalanceM.Imprime`) :
  BALANCE-008 et BALANCEM-007 se font dans le même commit. La commonalisation des bornes d'exercice
  (BALANCE-004) se fait en phase 3 avec `Editcompte`, `EditcompteA` et les autres éditions de
  `Compta/Impressions`, après la décision sur l'emplacement du helper (LDate).
