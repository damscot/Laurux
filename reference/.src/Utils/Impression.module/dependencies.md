# Impression — Dépendances

> Source : `.src/Utils/Impression.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Impression.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Facture`, `Ticket` |
| `.src/Gestion/Facturation/Facturergbl.class` | `Facture` |
| `.src/Gestion/Impressions/EdPrep.class` | `Facture` |
| `.src/Gestion/Lcr/Bordrx.class` | `<hérité>` |
| `.src/Gestion/option/ObjFacB.class` | `Facture` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep : `Impression.Ticket` → `Caisse/Caisse.class:5285,5287` ;
  `Impression.Facture` → `Caisse/Caisse.class:6750,6752`, `Gestion/Facturation/Facturergbl.class:974`,
  `Gestion/Impressions/EdPrep.class:306`, `Gestion/option/ObjFacB.class:678,680,683,729,731,734,776,778`.
- **Appel vers un membre inexistant** : `Gestion/Lcr/Bordrx.class:383` → `Impression.Prog_Editeur`
  (à rediriger vers `Editeur.Prog_Editeur`), avec `Start.Soc` également inexistant (aussi utilisé dans
  `Gestion/Depots/Sdepots.class`). `deps.py` peut l'afficher comme membre utilisé sans le signaler :
  faux négatif de contrôle (la compilation `gbc3` ne le détecte vraisemblablement pas non plus, à confirmer).
- Réglages écrits par `Caisse/Preferences.class:183-198` sous `/Soc<XX>/caisse/…` ; clés globales
  `/FACpdf`, `/CmdImp`, `/choiximp2`, `/Cimp` jamais écrites dans le code.
- Programmes externes : `lpr` (ou commande configurée).
