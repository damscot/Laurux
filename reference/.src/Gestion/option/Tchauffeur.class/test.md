# Tchauffeur — Tests

> Source : `.src/Gestion/option/Tchauffeur.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran inatteignable depuis l'application (aucun appelant) : aucun scénario de replay n'est
possible sans modifier le code. Le seul test utile est un contrôle statique qui fige l'absence
d'appelant, à repasser avant la suppression éventuelle (TCHAUFFEUR-A01).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TCHAUFFEUR-T01 | gbtest | Absence d'appelant (contrôle statique) | `grep -rn -i 'Tchauffeur' .src/ --include=*.class --include=*.module` hors du fichier lui-même | aucune ligne | `tests/absence_appelant/` | à faire |

## Détail des tests

- **T01** : script `check_output.py` (pas de module gb.test nécessaire) ; il échoue si un appelant
  apparaît, ce qui invaliderait l'anomalie A01.
- **Cas non testables** : l'affichage de la barre `Barselection` sans handler ; il faudrait ouvrir
  l'écran par code (non souhaité).
- `Utils.Observers(Me)` n'est pas appelé : l'écran ne serait de toute façon pas rejouable.
