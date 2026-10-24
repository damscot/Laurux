# Trecarts — Dépendances

> Source : `.src/Compta/Trecarts.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Trecarts.class` — classe, formulaire associé `Trecarts.form`
- Handlers GUI détectés : 4
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ecarts_keypress`, `clear`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `G` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ecarts_keypress`, `clear`, `Button2_Click`, `Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Point d'entrée unique** : `Fmenu.class:1302` (`Trecarts.Show`, auto-instance). Aucun autre
  appelant (`grep -rn "Trecarts" .src`).
- **Faux positifs de portée** : `deps.py` propose `Ecarts_keypress` et `clear` comme réductibles ;
  vérification faite, ce sont du **code mort** (aucun contrôle/groupe `Ecarts` dans `Trecarts.form`,
  aucun appel de `clear`). Les handlers `Btn_Click`, `Montant_*`, `Button1_Click`, `Button2_Click`
  sont liés au `.form` et restent `Public`.
- **Tables non vues par `Cbase`** : toutes les tables sont nommées en dur (`Fiches_Comptes`,
  `Fiches_Parametres`, `Fiches_Mvt` via `Tab2`, `Fiches_MvtM` uniquement dans la chaîne
  `LOCK TABLES`) ; `deps.py` les détecte par littéral.
- **Dépendance implicite** : `Sha1Calc.CalcSha1("Fiches_Mvt", …)` lit `Fiches_MvtM` ; c'est pour cela
  que la table figure dans le `LOCK TABLES` (sinon erreur MySQL « table not locked »).
- **Ordre de rework** : `Maj_Solde`/`ProchainNumeroEcriture` communs avec `Tresor` (et `Saisecrit`)
  → à traiter dans le même lot de commonalisation en phase 3 ; aucune dépendance circulaire.
