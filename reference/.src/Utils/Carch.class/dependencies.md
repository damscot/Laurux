# Carch — Dépendances

> Source : `.src/Utils/Carch.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Carch.class` — classe, formulaire associé `Carch.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `.src/Communs/Fmenu.class:1417` (`Menu156_Click`), menu parent « Etiquettes » dont le `Click` n'est probablement jamais levé (à confirmer) ; deps.py ne le détecte pas (appel `Classe.Show`).
- **Faux positif deps.py** : `Coul_Dblclick` et `Btn_Click` listés en « portée réductible » ; ce sont
  des handlers de groupes d'événements (`Coul`, `Btn`) déclarés dans `Carch.form`.
- Réglages écrits : `/Coul/Facts`, `/Coul/Avs` ; ils sont aussi écrits par `SetColors` (même clés, `SetColors.form`
  l.87-247) et lus par d'autres écrans : supprimer cette fenêtre ne retire aucune donnée.
- Aucun appel dynamique (`Prgm` ne la référence pas).
