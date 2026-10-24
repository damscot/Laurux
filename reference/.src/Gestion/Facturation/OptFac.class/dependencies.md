# OptFac — Dépendances

> Source : `.src/Gestion/Facturation/OptFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/OptFac.class` — classe, formulaire associé `OptFac.form`
- Handlers GUI détectés : 41
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colal_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 368 (1 argument(s), marqueurs aucun)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/Archives.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Facturation/Facturefm.class` | `<type>` |
| `.src/Gestion/Facturation/FacturefmA.class` | `<type>` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Gsm` | `<type>` |
| `LDate` | `<type>`, `G`, `L`, `_call` |
| `ObjFac` | `Stock`, `abonnement`, `adrliv`, `archive`, `autoent`, `badr`, `bl`, `blchif`, `blrecap`, `breg`, `choix`, `colon`, `doclet`, `dtedoc`, `dteech`, `dtmouv`, `entete`, `facture`, `finmois`, `imp`, `ligne2`, `livraison`, `nbexplemplaire`, `numbl`, `numcli`, `numfac`, `pdf`, `pied`, `recap`, `remise`, `resent`, `reserve`, `saisreg`, `simpcond`, `sms`, `tsaisreg`, `ttc` |
| `ObjFacB` | `<type>`, `editebl`, `editef`, `editefm`, `mail`, `visualisation` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `EstDate`, `Name`, `Select`, `Text`, `Type`, `dte`, `reg` |
| `Utils` | `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_AdrlivBL`, `Fiches_AdrlivC`, `Fiches_Bl`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_AdrC`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants (tous `New OptFac(…)` puis `ShowModal`) :
  - `Facture.Bl_Edit` ([Facture.class:9557](../../../../../.src/Gestion/Facturation/Facture.class#L9557) et [Facture.class:9559](../../../../../.src/Gestion/Facturation/Facture.class#L9559)) : facture, BL, commande,
    devis, proforma, atelier, avec `Me.Parent`, `Tottc1.Text`, date et courriel ;
  - `Archives.Button9_Click` ([Archives.class:1464](../../../../../.src/Archivages/Archives.class#L1464)) : facture archivée ;
  - `Facturefm.Button9_Click` ([Facturefm.class:781](../../../../../.src/Gestion/Facturation/Facturefm.class#L781)) : fin de mois, `nfac = "M"` ou `""`
    (suffixe des tables `Fiches_Bl`/`Fiches_BlM`) ;
  - `FacturefmA.Button14_Click` ([FacturefmA.class:640](../../../../../.src/Gestion/Facturation/FacturefmA.class#L640)) : facturation périodique, avec le type
    **fin de mois** (et non `ObjFac.abonnement`) ;
  - `SaiReg.selection_Activate` ([SaiReg.class:581-588](../../../../../.src/Gestion/Facturation/SaiReg.class#L581-L588)) et `SaiReg.Facture`
    ([SaiReg.class:942](../../../../../.src/Gestion/Facturation/SaiReg.class#L942)) : sans `Parent`.
- `deps.py` signale `entete_Click` et `edite_Click` comme jamais référencés : **faux positifs**.
  Les contrôles du `.form` sont déclarés publics (`{ !Entete CheckBox`, `{ !edite Button`) et le
  préfixe `!` n'est pas reconnu par le parseur des `.form` (même cas dans `Facturergbl.form`,
  `Facture.form`). Ces handlers sont levés par Gambas et doivent rester `Public`.
- `Colal_Click` figure dans `replay_dynamic` : appelé par `ReplayObserver.Replay_Click` via
  `Object.Call`, il doit rester `Public` (sans objet si REPLAYOBSERVER-A06 est validée).
- Tous les handlers `Objet_Evenement` restent `Public` (exigence Gambas, et appel dynamique par
  le rejeu) ; `var_*` sont les gestionnaires des événements de l'objet `ObjFacB` créé
  `As "var"`.
- `deps.py` attribue à `ObjFacB` (`<hérité:…>`) les membres hérités d'`ObjFac` : la dépendance
  réelle porte sur les membres publics d'[`ObjFac`](../ObjFac.class/dependencies.md) (≈ 35). Le
  membre `numcl` (`<hérité:numcl>`) n'existe dans aucune des deux classes (OPTFAC-A01).
- Tables : `Fiches_AdrlivBL` (écriture, sans clé `Cbase`), `Fiches_Bl` (`UPDATE ech`, en dur),
  `Fiches_AdrlivC` (via `TabAdrC`).
- Contrainte d'ordre : à reworker **après** `ObjFac` (et `ObjFacB`, lot Gestion/option) si des
  membres publics d'`ObjFac` sont renommés ou réduits.
