# TestCaisses — Dépendances

> Source : `.src/Caisse/TestCaisses.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/TestCaisses.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Ouverture.class` | `TestCai` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants confirmés : `Ouverture.Caissiere_Click` (`Ouverture.class:132`) et
  `Ouverture.Button1_Click` (`Ouverture.class:200`).
- **Dépendance de données non vue par `deps.py`** : format des fichiers `~/Caisse<N>.lock`
  écrits par `Ouverture.Button1_Click` (première ligne = `caissiere.Text & "O"`) ; toute
  modification de ce format casse `TestCai`. `Fondcaisse.class:322` supprime `~/Caisse.lock`.
- Homonyme mort : `Dcaisses.TestCai(Cai)` (signature différente).
- Ne pas confondre avec un harnais : aucun lien avec `Internal_Test` ni `./Laurux -t`.
- Ordre de rework : avec `Ouverture` (même lot) pour la commonalisation des verrous.
