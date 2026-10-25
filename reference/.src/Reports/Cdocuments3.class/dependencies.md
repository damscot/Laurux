# Cdocuments3 — Dépendances

> Source : `.src/Reports/Cdocuments3.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cdocuments3.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Lines`, `Level3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdPrep.class` | `<type>`, `BasPage`, `Basep`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level2b`, `adresse`, `adresse2`, `cadre`, `carre` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `B2`, `G`, `G2`, `R`, `R2` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Lines`, `Level3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `EdPrep` (`Dim pdf2 As Cdocuments3`, `EdPrep.class:65` ; création ligne
  184). Toutes les méthodes sauf `Lines` et `Level3` y sont appelées (vérifié par
  `grep -n 'pdf2\.' EdPrep.class`) : `Entete` (213, 284), `Entete2` (214, 267, 285), `cadre`,
  `adresse`, `adresse2`, `Level1`, `Level2` (258), `carre` (259), `Level2b` (276), `BasPage`
  (266, 283, 296), `Basep` (295). `deps.py` est exact pour ce fichier.
- **Saut de page sans nouvelle page** (à reporter dans EDPREP, lié à EDPREP-A02) : dans la boucle
  des commentaires (`EdPrep.class:265-273`), le saut à `PosY >= 266` appelle `BasPage`,
  `Entete2`, `cadre`, `adresse`, `adresse2`, `Level1` **sans `Entete`**, seule méthode qui fait
  `AddPage` : l'en-tête et les lignes suivantes sont réimprimés sur la même page, par-dessus les
  lignes 86 à 266 (le saut automatique de `PdfWriter`, à 295 mm, n'intervient pas). Voir
  CDOCUMENTS3-A01.
- Le PDF est imprimé directement (`Impression.Facture(Filename2, 1)`) : les tests doivent
  rediriger l'impression vers un fichier (imprimante PDF ou réglage `/FACpdf`, à confirmer avec
  `Impression`).
- Aucun appel dynamique, aucune table, aucune dépendance circulaire.
- Ordre de rework : avec le socle PDF commun (CDOCUMENTS-005) ; la méthode `EntetePage`
  (CDOCUMENTS3-004) se fait dans le même commit que la mise à jour d'`EdPrep`.
