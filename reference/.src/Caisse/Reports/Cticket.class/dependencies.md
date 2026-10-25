# Cticket — Dépendances

> Source : `.src/Caisse/Reports/Cticket.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Reports/Cticket.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `newPage`, `Entete2`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `SetFont`, `SetXY` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`newPage`, `Entete2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- `jamais_reference` vérifié : `grep -rnw Cticket .src .project` ne trouve que le fichier
  lui-même ; aucun `.form`, `.report` ni chaîne ne le cite. Le binaire `.gambas/CTICKET` est
  compilé mais jamais chargé.
- `unused` (`newPage`, `Entete2`) : conséquence de l'absence d'instanciation.
- `Me.seto` (ligne 24) : membre absent de `PdfWriter`, non détecté par `deps.py` (les appels sur
  `Me` d'une classe héritée ne sont pas vérifiés).
- Aucune contrainte d'ordre : suppression indépendante.
