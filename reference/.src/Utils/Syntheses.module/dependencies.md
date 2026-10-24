# Syntheses — Dépendances

> Source : `.src/Utils/Syntheses.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Syntheses.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/RazClientd.class` | `Message` |
| `.src/Archivages/RazDevis.class` | `Message` |
| `.src/Archivages/RazHistoFac.class` | `Message` |
| `.src/Archivages/RazHistoFbl.class` | `Message` |
| `.src/Archivages/RazHistoTk.class` | `Message` |
| `.src/Archivages/RazRlvb.class` | `Message` |
| `.src/Communs/FRestore.class` | `Message` |
| `.src/Communs/Fmenu.class` | `Message` |
| `.src/Communs/Fsoc.class` | `Message` |
| `.src/Compta/Utils/Verbal.class` | `Message` |
| `.src/Gestion/Facturation/Facture.class` | `Message` |
| `.src/Gestion/Facturation/Facturergbl.class` | `Message` |
| `.src/Utils/AffRdv.module` | `Message` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Grep `Syntheses\.Message` (insensible à la casse) : `Archivages/RazClientd:40`, `RazDevis:57`,
  `RazHistoFac:57`, `RazHistoFbl:41`, `RazHistoTk:41`, `RazRlvb:38`, `Communs/Fmenu:207,218,415`,
  `Communs/FRestore:126`, `Communs/Fsoc:518,557,619`, `Compta/Utils/Verbal:415`,
  `Gestion/Facturation/Facture:1697`, `Facturergbl:652`, `Utils/AffRdv:12` (`Syntheses.message`).
- Programmes externes : `pico2wave` (paquet libttspico), `aplay` (alsa-utils) ; fichier son
  `son/warning2.ogg` embarqué.
- Aucun appel dynamique, aucun cycle.
