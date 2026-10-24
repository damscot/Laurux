# Cprod — Dépendances

> Source : `.src/Utils/Cprod.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Cprod.class` — classe, formulaire associé `Cprod.form`
- Handlers GUI détectés : 4
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Musique` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Aucun appelant : `grep -rniw cprod .src` ne renvoie que ce fichier.
- **Faux positif deps.py** : `Coul_Dblclick` et `Btn_Click` listés en « portée réductible » ; ce sont
  des handlers de groupes d'événements (`Coul`, `Btn`) déclarés dans `Cprod.form`.
- Réglages écrits : `/Coul/Stk`, `/Coul/Nstk`, `/Coul/Eps`, `/Coul/Spd` ; ils sont aussi écrits par `SetColors` (même clés, `SetColors.form`
  l.87-247) et lus par d'autres écrans : supprimer cette fenêtre ne retire aucune donnée.
- Aucun appel dynamique (`Prgm` ne la référence pas).
