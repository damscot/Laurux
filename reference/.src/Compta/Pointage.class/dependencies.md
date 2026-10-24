# Pointage — Dépendances

> Source : `.src/Compta/Pointage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Pointage.class` — classe, formulaire associé `Pointage.form`
- Handlers GUI détectés : 26
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colrlv_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Calcsolde` | `Calcul` |
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0R`, `Level1R`, `Level2R`, `Level3R`, `Level6` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `L`, `_call` |
| `LPrix` | `_call` |
| `Listextcpt` | `<type>`, `enregistrepointage`, `requete`, `totalpointe` |
| `ObjProp` | `<type>`, `tri` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe` |
| `TextReg` | `<form>`, `EstDate`, `EstNum`, `Name`, `Select`, `Text`, `Type`, `Value`, `dte`, `nbdec` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Tresorerie` |
| `TriGen` | `<type>`, `ExtraSel`, `FontSize`, `GetAllFiltered`, `Refresh_Data`, `Update` |
| `Utils` | `Bip`, `Cdate_Aff`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Rappro`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Update_Req`, `Colrlv_Man`, `cptman`, `ClearChamps`, `ClearChampsAll`, `Calc_Solde`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Point d'entrée unique** : `Fmenu.class:719` (`Pointage.Show`, auto-instance non modale).
- **Faux positif de portée** : `Bsel` et `Bval` sont écrits par `Object.SetProperty` depuis
  `TriCpt.class:112-113` et `TriGen.class:138-139, 228-232` (appel dynamique non vu par `deps.py`) :
  ils restent `Public`. Les autres membres listés (`Update_Req`, `Colrlv_Man`, `cptman`,
  `ClearChamps`, `ClearChampsAll`, `Calc_Solde`) sont bien sans appelant externe.
- **Handlers d'événements d'objets créés par code** : `TriGen_MajSel`, `TriGen_Raz`, `TriGen_Data`
  sont reliés par `New TriGen(...) As "TriGen"` (l. 129), pas par le `.form` ; ils restent `Public`.
- **Handlers de groupe** : `Dte_*` sert à la fois au contrôle `Dte` et au groupe `Dte` (`dtinf`,
  `dtsup`) ; `Sld_*` (`Sldepart`, `Sldfinal`), `Cpt_*`, `Modesel_Click` (`Toutes`, `Enp`, `Ep`,
  `RelUniq`).
- **Tables cachées** : `Listextcpt` interroge et met à jour `Fiches_Mvt1` … `Fiches_Mvt5`
  (`enregistrepointage`, `totalpointe`, requête de liste) : `deps.py` ne les rattache pas à
  `Pointage`. Un replay de pointage doit donc comparer les 6 tables `Mvt`.
- **Couplage textuel** : `Left($lst.requete, -14)` suppose que la requête de `Listextcpt` se termine
  par `" ORDER BY " & " dte"` (tri par défaut) : tout rework de `Listextcpt._new` doit préserver
  cette fin ou être fait en même temps que POINTAGE-006.
- **`Calcsolde`** est un formulaire (`Calcsolde.form`) dont `Calcul` est appelé sur l'auto-instance
  (l. 728) ; l'appel sans journal d'à-nouveaux est l'anomalie CALCSOLDE-A01 (documentée côté
  `Calcsolde`, reprise ici en POINTAGE-A03).
- **Commonalisation inter-fichiers** : sélection multiple `TriGen` avec `GedR` et `TriFacture` (même
  lot en phase 3) ; aucune dépendance circulaire.
