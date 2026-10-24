# Variables — Dépendances

> Source : `.src/Utils/Variables.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Variables.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriEqu.class` | `$Codearticle`, `Bsel` |
| `.src/Affichages/TriFac.class` | `Bsel`, `numeroFac` |
| `.src/Affichages/TriFac2.class` | `Bsel`, `numeroFac` |
| `.src/Affichages/TriMo.class` | `$Codemo`, `Bsel` |
| `.src/Affichages/Tricp.class` | `Bsel`, `Bureaudistributeur`, `codepostal` |
| `.src/Archivages/Archives.class` | `bRemise` |
| `.src/Caisse/FClientcarte.class` | `Bsel`, `Bureaudistributeur`, `codepostal` |
| `.src/Gestion/Facturation/Facture.class` | `$Codearticle`, `Bsel`, `Bureaudistributeur`, `FMateriel`, `bRemise`, `codepostal`, `numeroFac` |
| `.src/Gestion/Facturation/Facturergbl.class` | `bRemise` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Stock/Tarifs/MajEqu.module` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Stock/Tarifs/MajTarifP.class` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Stock/ValidBR.class` | `inumr` |
| `.src/Gestion/Tables/Articles.class` | `ArtCode`, `ArtHt`, `ArtTva`, `Artintitule`, `OrgCoefTypeCli`, `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Tables/CoefTypeC.class` | `ArtCode`, `ArtHt`, `ArtTva`, `Artintitule`, `OrgCoefTypeCli` |
| `.src/Gestion/Tables/ComMail.class` | `sTexte` |
| `.src/Gestion/Tables/FClient.class` | `SMajCli`, `Sexport`, `Sprix`, `sTexte` |
| `.src/Gestion/Tables/FFournisseur.class` | `SMajFour`, `Sexport`, `Sprix` |
| `.src/Gestion/Tables/Famille.class` | `SMajArt`, `Sexport`, `Sprix` |
| `.src/Gestion/Tables/Materiel.class` | `Bsel` |
| `.src/Gestion/option/ObjFacB.class` | `sTexte` |
| `.src/Gestion/option/Ttarfioul.class` | `Bsel` |
| `.src/Reports/Cdocuments.class` | `EnvoiMail`, `Qte`, `TypeL`, `bImpref`, `bRemise` |
| `.src/Reports/ChxImp.class` | `impr` |
| `.src/Serveur.module` | `Schmprix` |
| `.src/Statistiques/TBord.class` | `Musique`, `son` |
| `.src/Utils/Changefour.class` | `Bsel` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Simport`, `OrgTarCli`, `OrgTarTypeCli`, `$TarTypeCli`, `Codearticle`, `Cfour`, `obs`, `$fic`, `$doc`, `$Codeclient`, `numerobl`, `Bselection`
<!-- /AUTO:dependances -->

## Notes d'analyse

- La carte lecteurs/écrivains complète, variable par variable, est dans
  [architecture.md](architecture.md) (grep `Variables.X`, hors commentaires).
- Écrivains principaux : `TriEqu`, `TriFac`, `TriFac2`, `TriMo`, `Tricp` (dialogues de recherche),
  `Articles`, `Facture`, `Facturergbl`, `Archives`, `ComMail`, `FClient`, `ValidBR`, `ChxImp`,
  `Materiel`, `Ttarfioul`, `Changefour`.
- Lecteurs principaux : `Facture`, `FClientcarte`, `Cdocuments`, `CoefTypeC`, `ObjFacB`, `Serveur`,
  écrans de tarifs (`Impart`, `MajTarif*`, `MajFbtarif2`, `MajEqu`), `Articles`, `FClient`,
  `FFournisseur`, `Famille`, `TBord`.
- Le module ne dépend que de `Start` (`LocalSettings`, `Societe`) à l'initialisation : **ordre
  d'initialisation** sensible, `Start.Societe` doit être fixé avant le premier accès à `Variables`.
- Aucun appel dynamique. Aucune dépendance circulaire (Start ne lit pas `Variables`).
- Ordre de rework : la suppression des variables mortes (VARIABLES-001/002) est autonome ; l'étape
  `Cdocuments` (VARIABLES-003) doit être faite dans le même commit que le rework de `Cdocuments`.
