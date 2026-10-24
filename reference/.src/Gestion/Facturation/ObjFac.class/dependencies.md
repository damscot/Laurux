# ObjFac — Dépendances

> Source : `.src/Gestion/Facturation/ObjFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/ObjFac.class` — classe, Create Static
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Orig2FactType`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/Archives.class` | `archive` |
| `.src/Caisse/Moulinage.class` | `facture`, `journal`, `magasin`, `nbexplemplaire`, `numbl`, `numerodef`, `numeroecr`, `numfac`, `saisreg`, `tsaisreg` |
| `.src/Gestion/ClotureF.class` | `facture`, `numcli` |
| `.src/Gestion/Facturation/Facture.class` | `atelier`, `bl`, `choix`, `commande`, `devis`, `facture`, `montht`, `montttc`, `monttva`, `numcli`, `proforma` |
| `.src/Gestion/Facturation/Facturefm.class` | `finmois` |
| `.src/Gestion/Facturation/FacturefmA.class` | `finmois` |
| `.src/Gestion/Facturation/OptFac.class` | `Stock`, `abonnement`, `adrliv`, `archive`, `autoent`, `badr`, `bl`, `blchif`, `blrecap`, `breg`, `choix`, `colon`, `doclet`, `dtedoc`, `dteech`, `dtmouv`, `entete`, `facture`, `finmois`, `imp`, `ligne2`, `livraison`, `nbexplemplaire`, `numbl`, `numcli`, `numfac`, `pdf`, `pied`, `recap`, `remise`, `resent`, `reserve`, `saisreg`, `simpcond`, `sms`, `tsaisreg`, `ttc` |
| `.src/Gestion/Facturation/SaiReg.class` | `archive`, `bl`, `facture`, `finmois` |
| `.src/Gestion/Stockmvt.class` | `archive`, `bl` |
| `.src/Gestion/option/Caleditcmat.class` | `dtedoc`, `facture`, `ligne`, `numcli` |
| `.src/Gestion/option/EditfacB.class` | `blchif`, `couleur`, `gestion`, `ligne`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `rescli` |
| `.src/Gestion/option/ObjFacB.class` | `<type>`, `AffClient`, `CopieGedFac`, `adrfac`, `archive`, `bl`, `calcul`, `choix`, `code`, `commande`, `condvent`, `devis`, `dtedoc`, `dteech`, `dtmouv`, `ecrit`, `ecriture`, `ecriturecompt`, `edit`, `facture`, `finmois`, `gestion`, `gmateriel`, `imp`, `joinfac`, `ligne`, `lignetva`, `magasin`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `nbexplemplaire`, `nom`, `num`, `numbl`, `numcli`, `numfac`, `pdf`, `proforma`, `qte`, `remart`, `remmo`, `rescli`, `resent`, `reslig`, `saisreg`, `tab`, `testchem`, `tva`, `type`, `verifdat` |
| `.src/Reports/Editfac.class` | `AffClient`, `Stock`, `abonnement`, `adrfac`, `adrliv`, `adrlogo`, `affref`, `archive`, `atelier`, `autoent`, `bl`, `blchif`, `blrecap`, `choix`, `colon`, `commande`, `couleur`, `couleur2`, `coupon`, `devis`, `devise`, `dtedoc`, `eco`, `entete`, `facture`, `finmois`, `franctva`, `gestion`, `lgo`, `libdev`, `libsire`, `libtaxe`, `ligne`, `livraison`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `numbl`, `numcli`, `numfac`, `pied`, `proforma`, `pxsdec`, `recap`, `remart`, `remmo`, `rescli`, `resent`, `reserve`, `simpcond`, `tab`, `tpied`, `treserve`, `tsaisreg`, `ttc`, `tva`, `txtlibdev`, `txtvldev` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Edit`, `Exec` |
| `EcrAuto` | `<type>`, `ecriture`, `numecr`, `numerodef`, `numfac`, `resjou` |
| `LDate` | `<type>`, `Apres`, `Avant`, `G`, `L`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Clients`, `DTE`, `DelAllTag`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `LPrix` | `_call` |
| `Numtostring` | `Convertir` |
| `Start` | `B`, `B2`, `G`, `G2`, `LocalSettings`, `R`, `R2`, `Societe`, `son` |
| `Utils` | `CDec`, `Calcech`, `arrondi`, `cpoint`, `db`, `totobs` |
| `VarEcr` | `<type>`, `L_ajou`, `Vente`, `compte`, `divers`, `dte`, `dteech`, `etat`, `intitul`, `libelle`, `montantc`, `montantd`, `numdoc`, `numlot`, `plus`, `type` |
| `VerifDate` | `<type>`, `ClotFac` |

### Tables SQL référencées

`Fiches_AdrlivBL`, `Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Echeances`, `Fiches_Fam`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_LibelFac`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Suivis`, `Fiches_Tleg`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Orig2FactType`, `FactType2Orig`, `Origine`, `treg`, `sauvpdf`, `nblfac`, `poids`, `mdepo`, `pdfchemin`, `cheque`, `intcheque`, `cptcheque`, `intcarte`, `cptcarte`, `intaut`, `cptaut`, `joinsms`, `ligneart`, `lignecom`, `nomfm`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Héritage** : `ObjFac` n'est instancié que via sa sous-classe `ObjFacB`
  (`.src/Gestion/option/ObjFacB.class`, `Inherits ObjFac`). Les instances `ObjFacB` sont créées
  par `OptFac` ([OptFac.class:40](../../../../../.src/Gestion/Facturation/OptFac.class#L40)), `Facture` (l. 1589, 2124), `Moulinage` (l. 1310, 2869),
  `ClotureF` (l. 136), `Caleditcmat` (l. 106), `Stockmvt` (l. 673-676), `Archives` via `OptFac`,
  et `ObjFacB._call`. Le constructeur `ObjFac._new(num, choi, dte)` reçoit les arguments de
  `New ObjFacB(num, choix)` (`ObjFacB._new` n'a pas de paramètre).
- **Faux positifs `unused` de `deps.py`** : `calcul` et `verifdat` sont appelés par
  `Super.calcul(nom)` ([ObjFacB.class:71](../../../../../.src/Gestion/option/ObjFacB.class#L71)) et `Super.verifdat(dtef, dtech)`
  ([ObjFacB.class:923](../../../../../.src/Gestion/option/ObjFacB.class#L923)) ; `calcul` l'est aussi sur des instances `ObjFacB` (`Facture`,
  `ClotureF`, `Caleditcmat`). Les appels `Super.x` ne sont pas résolus par l'outil. Seul
  `Orig2FactType` est réellement mort.
- **Faux positifs `scope_reducible`** : `deps.py` attribue les accès `vfac.devise`,
  `$vfac.adrliv`, `fac.numeroecr`… à `ObjFacB` (`<hérité:…>`) et non à `ObjFac`. Le tableau
  « Membres publics : usage réel » d'architecture.md donne l'usage vérifié ; seuls `Origine`,
  `FactType2Orig`, `treg`, `sauvpdf`, `nblfac`, `pdfchemin`, `ligneart`, `lignecom` sont
  réductibles, et 11 variables sont mortes.
- **Membres `<inconnu:…>` attribués à `VarEcr`** (`addtag`, `addtags`, `delalltag`, `ht`,
  `pdfdupli`, `supprime`, `ttc`) : la variable locale `lg` est typée `LGed` dans `CopieGedFac` et
  `VarEcr` dans `calcul`/`ecriturecompt` ; ces membres appartiennent en réalité à `LGed`.
- **Appelants externes directs** (auto-instance, énumération) : `Facture`, `OptFac`, `SaiReg`,
  `Facturefm`, `FacturefmA`, `Archives`, `Moulinage`, `ClotureF`, `Stockmvt`, `Caleditcmat`,
  `Editfac` (constantes `ObjFac.bl`, `ObjFac.facture`, …).
- **Table de travail `Bl`** (sans clé `Cbase`, hors `db_control.csv`) lue en fin de mois : créée
  par `Facturefm` (colonnes `num, code, nom, date, ht, ttc`), `SaiReg.Facture` (idem),
  `FacturefmA` (**sans `nom`**) et `Facturergbl` (`numbl` au lieu de `num`). `calcul` lit
  `bl!num` et, pour un client divers, filtre sur `nom` : avec la table de `FacturefmA` ce filtre
  échoue (colonne absente) — voir FACTUREFMA-A04.
- Événements : `nombre`, `fttc`, `echeance` ont pour gestionnaires `OptFac.var_*` ; `modreg`
  n'a aucun gestionnaire.
- Tables en dur hors `Cbase` (voir architecture.md) ; `Fiches_AdrlivBL` et `Fiches_Reglements`
  n'ont pas de clé `Cbase`.
- **Contraintes d'ordre de rework** : `ObjFac` → `ObjFacB` (lot Gestion/option) → `OptFac`,
  `Editfac`, `EditfacB`. Toute réduction de portée d'un membre doit être vérifiée contre `ObjFacB`
  (accès hérités sans qualification ou par `Me.`). La commonalisation GED dépend de LGED-007.
