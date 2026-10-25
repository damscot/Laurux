# barselection — Dépendances

> Source : `.src/Gestion/option/barselection.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/barselection.class` — classe
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Tables/Mreglement.class` | `<type>`, `estcreer`, `estmodif` |
| `.src/Gestion/option/Tchauffeur.class` | `<type>` |
| `.src/Gestion/option/Tconsigne.class` | `<type>`, `estcreer`, `estmodif` |
| `.src/Gestion/option/Tregie.class` | `<type>`, `estcreer`, `estmodif` |
| `.src/Gestion/option/Tregion.class` | `<type>`, `estcreer`, `estmodif` |
| `.src/Gestion/option/Ttourne.class` | `<type>`, `estcreer`, `estmodif` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instanciations** (`As "bar1"`) : `Mreglement:22` (`"001110010"`), `Tconsigne:12` et
  `Ttourne:11` (`"111111111"`), `Tregie:23`, `Tregion:12`, `Tchauffeur:7` (`"111111110"`).
- **Événements traités** (`bar1_*`) : `Mreglement` (creer, modif, annule, valide, suprimer,
  quitter, recherche — ce dernier jamais levé), `Tconsigne` et `Ttourne` (les 11), `Tregie` et
  `Tregion` (tous sauf recherche), `Tchauffeur` (**aucun** : barre sans effet ; `Tchauffeur`
  lui-même n'est ouvert nulle part, voir sa doc).
- **Contrôles créés par code** sans nom de `.form` (groupes `bout`, `butval`) : rejouabilité à
  vérifier en phase 2.
- `Export` : classe exportée ; aucune dépendance externe au projet connue.
- **Ordre de rework** : avant les écrans appelants si le cycle commun (MREGLEMENT-006) est
  déplacé ici.

