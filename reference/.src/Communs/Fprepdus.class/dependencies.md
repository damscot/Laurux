# Fprepdus — Dépendances

> Source : `.src/Communs/Fprepdus.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fprepdus.class` — classe, formulaire associé `Fprepdus.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`TraitementC`, `TraitementF`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.lblClm3_MouseDown` (l.1993, `Fprepdus.show()`, auto-instance) —
  ouverture par clic sur un libellé de la fenêtre principale.
- **Auto-instance** : le calcul étant dans `_new`, il n'est fait qu'à la création ; une seconde
  ouverture sans fermeture préalable réaffiche les mêmes chiffres (à confirmer).
- **Table en dur** : `Fiches_Comptes` (bien détectée par `deps.py`) ; `TabComptes` existe dans
  `Cbase`.
- **Données lues** : `Fiches_Comptes.solde` (double) est maintenu par `Calcsolde`/`Csolde` et les
  saisies comptables ; la synthèse dépend donc de soldes à jour.
- **Ordre de rework** : indépendant.

