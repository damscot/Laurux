# EditfacB — Dépendances

> Source : `.src/Gestion/option/EditfacB.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/EditfacB.class` — classe, hérite de `Editfac`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `code_data`, `intitule_Data`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/ObjFacB.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Editfac` | `<type>`, `clr`, `lgint`, `longueur` |
| `ObjFac` | `blchif`, `couleur`, `gestion`, `ligne`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `rescli` |
| `ObjFacB` | `<type>`, `aimprimer`, `ascise`, `borientation`, `consigne`, `decons`, `deconsigne`, `droit`, `nbdecons`, `poid`, `secu`, `totap`, `totvolume` |
| `Utils` | `Option`, `totobs` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`code_data`, `intitule_Data`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Héritage** : `Inherits Editfac` (`.src/Reports/Editfac.class`, report). `code_data` et
  `intitule_Data` **surchargent** les handlers `code_Data`/`intitule_Data` d'`Editfac` (contrôles
  `code` et `intitule` de `Editfac.report`) : faux `unused` et fausse « portée réductible » de
  `deps.py` ; ils doivent rester `Public`.
- **Construction** : `New EditfacB(Me, Me)` dans `ObjFacB` (658, 726, 773, 800, 866) ; le premier
  argument est consommé par `Editfac._new(vfac As ObjFacB)`.
- **Membres d'`ObjFacB` lus** : `borientation`, `poid`, `aimprimer`, `decons`, `nbdecons`,
  `consigne`, `deconsigne`, `droit`, `secu`, `ascise`, `totvolume`, `totap` ; membres hérités
  d'`ObjFac` : `blchif`, `couleur`, `gestion`, `ligne`, `montart`, `montmo`, `montht`, `monttva`,
  `montttc`, `rescli` (attribués à `ObjFac` dans son bloc « Utilisé par »).
- **Handlers créés par code** : `palette`, `coli`, `bout`, `montcons`, `cu`, `pourc`, `ve`, `ap`
  (`New ReportLabel(…) As "<nom>"`).
- **Dépendance circulaire** `ObjFacB` ↔ `EditfacB` ; à reworker avec `ObjFacB` (OBJFACB-011 /
  EDITFACB-005 dans le même commit) et `Editfac`.
- Aucune table ni appel dynamique.

