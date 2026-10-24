# FRelance — Dépendances

> Source : `.src/Compta/Relances/FRelance.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/FRelance.class` — classe, formulaire associé `FRelance.form`
- Handlers GUI détectés : 8

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Txt_Relances`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:775` (`Frelance.Show`, casse différente, résolution insensible à la
  casse). Aucun appel dynamique.
- Liens fonctionnels non détectés (même table `Fiches_Txt_Relances`) : `FEditrel.class:534`,
  `Ligcli.class:61` et `:272`, `Dup.class:151` (duplication de société).
- `.form` associé : `FRelance.form` (contrôles `Niveau`, `Rel1`, `Rel2`, `Button1/2/4/6`).
- Aucune contrainte d'ordre de rework.
