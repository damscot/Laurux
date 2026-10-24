# Typec — Architecture

> Source : `.src/Gestion/Tables/Typec.class`

## Vue d'ensemble

Écran de la **table des types clients** (`Fiches_Typec` : `code` varchar(2) clé primaire,
`libelle` varchar(25) ; `Laurux01.sql` : Maçon, Plombier, Agriculteur). Les types clients servent
aux tarifs et remises par type (`TarTypeCli`, `CoefTypeC`, `Remisec`, `GesTar`, `TarArt`), à la
facturation (`Facture`, `Facturefm`), aux statistiques (`StatTypCli`, `Histocliart`), aux
éditions et à l'emailing (21 fichiers lecteurs). Ouvert par `Fmenu.class:1423` (`Typec.show`).

Copie du squelette de [Centrales](../Centrales.class/architecture.md) (similarité 0,92). Différences :
- nom de table **en dur** (`Tab = "Fiches_Typec"`) alors que `Cbase.Table("TabTypec")` existe
  (la clé est d'ailleurs déclarée deux fois dans `Cbase.module`, lignes 230 et 236) ;
- variable `son` ; en-tête erroné (« Typeco.class ») ;
- aide active : `Doc.Open("Typec")`.

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$bForceKey` | var | Private |  | Boolean | 27 |
| `CoulZns` | var | Private |  | Integer | 28 |
| `CoulFoc` | var | Private |  | Integer | 29 |
| `son` | var | Private |  | Integer | 30 |
<!-- /AUTO:declarations -->

Remarque : `CoulZns`, `CoulFoc` et `son` (lignes 28-30, sans mot-clé, donc `Private`) ne figurent
pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-58 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 60-75 | Public | 3 | 13 | 0 | handler GUI |
| `Coltype_Click` | 77-81 | Public | 1 | 3 | 0 | handler GUI |
| `Refresh` | 83-90 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 92-98 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 100-115 | Public | 4 | 13 | 0 | handler GUI |
| `Button3_Click` | 117-138 | Public | 3 | 19 | 0 | handler GUI |
| `Button3_KeyPress` | 140-144 | Public | 1 | 3 | 0 | handler GUI |
| `OBS_GotFocus` | 146-156 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 158-166 | Public | 4 | 7 | 0 | handler GUI |
| `IsValidKey` | 168-173 | Public | 6 | 4 | 0 | portée réductible ? |
| `SetObservers` | 175-187 | Public | 4 | 10 | 0 | portée réductible ? |
| `Cdtype_LostFocus` | 189-193 | Public | 2 | 3 | 0 | handler GUI |
| `Cdtype_KeyPress` | 195-202 | Public | 2 | 6 | 0 | handler GUI |
| `Quitte_Cdtype` | 204-206 | Public | 1 | 2 | 0 | portée réductible ? |
| `Libeltype_LostFocus` | 208-212 | Public | 2 | 3 | 0 | handler GUI |
| `Libeltype_KeyPress` | 214-220 | Public | 2 | 5 | 0 | handler GUI |
| `Quitte_Libeltype` | 222-224 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button4_Click` | 226-230 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 235-239 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : couleurs, observateurs `OBS`, colonnes.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_Typec` (sans tri), remplit `Coltype`.
- **`Coltype_Click()`** [handler] : `Maj_Zones` ; rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.
- **`Refresh()`**, **`Maj_Zones()`** [portée : réductible] [nature : GUI].
- **`Button2_Click()`** [handler] [nature : mixte] : `DELETE … WHERE code = &1` avec
  `Coltype.Current[0]` (ligne 110) : ligne sélectionnée et non code saisi, erreur sans sélection.
  Aucun contrôle d'usage alors que le type est référencé par les fiches clients et les tables de
  tarifs/remises par type (`Fiches_RemTypec`, `Fiches_CoeffTypec`…).
- **`Button3_Click()`** [handler] [nature : mixte] : `SELECT` **concaténé** (ligne 125), puis
  `UPdate … SET code = &1, libelle = &2 WHERE code = &1` ou `INSERT`.
- **`Button3_KeyPress()`** [handler] : toute touche sur le bouton Enregistrer enregistre.
- **`Button4_Click()`** [handler] : ferme ; **`Button1_Click()`** [handler] : `Doc.Open("Typec")`.
- **`OBS_GotFocus()` / `OBS_LostFocus()`** [handlers `OBS`] : couleurs de focus.
- **`IsValidKey()`**, **`SetObservers()`** [portée : réductible] : identiques à Centrales.
- **`Cdtype_KeyPress()`**, **`Libeltype_KeyPress()`**, **`Cdtype_LostFocus()`**,
  **`Libeltype_LostFocus()`** [handlers] : navigation.
- **`Quitte_Cdtype()` / `Quitte_Libeltype()`** [portée : réductible] : vides (code mort).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.FColr` ; `Start.LocalSettings`, `Start.Societe`,
  `Start.Son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabTypec")` au lieu du nom en dur ; nettoyages identiques à Centrales.

### Commonalisation avec d'autres fichiers

- Socle « table code/libellé » avec [Centrales](../Centrales.class/architecture.md),
  [Identite](../Identite.class/architecture.md), [Statut](../Statut.class/architecture.md).

### Réduction de portée

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype` →
`Private`. Les usages relevés par `deps.py` dans `TarTypeCli` portent sur son contrôle `TypeC`
(homonyme, insensible à la casse), pas sur ce formulaire.

### Séparation traitement / GUI

`EnregistreTypec(sCode, sLib)`, `SupprimeTypec(sCode)` (ou fonctions du socle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `Fiches_RemTypec`, `Fiches_CoeffTypec` et fiches clients → `Fiches_Typec.code`
  avec suppression contrôlée.
