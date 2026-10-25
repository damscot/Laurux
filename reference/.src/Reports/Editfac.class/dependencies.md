# Editfac — Dépendances

> Source : `.src/Reports/Editfac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Editfac.class` — classe, formulaire associé `Editfac.report`
- Handlers GUI détectés : 10

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/EditfacB.class` | `<type>`, `clr`, `lgint`, `longueur` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `LTaxe` | `<type>` |
| `ObjFac` | `AffClient`, `Stock`, `abonnement`, `adrfac`, `adrliv`, `adrlogo`, `affref`, `archive`, `atelier`, `autoent`, `bl`, `blchif`, `blrecap`, `choix`, `colon`, `commande`, `couleur`, `couleur2`, `coupon`, `devis`, `devise`, `dtedoc`, `eco`, `entete`, `facture`, `finmois`, `franctva`, `gestion`, `lgo`, `libdev`, `libsire`, `libtaxe`, `ligne`, `livraison`, `montart`, `montht`, `montmo`, `montttc`, `monttva`, `numbl`, `numcli`, `numfac`, `pied`, `proforma`, `pxsdec`, `recap`, `remart`, `remmo`, `rescli`, `resent`, `reserve`, `simpcond`, `tab`, `tpied`, `treserve`, `tsaisreg`, `ttc`, `tva`, `txtlibdev`, `txtvldev` |
| `ObjFacB` | `<type>` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `db`, `totobs` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`$vfac`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Report gb.report** : la mise en page est dans `Editfac.report` (analysé par `deps.py` comme
  un `.form`, champ `ui`). Les dix handlers `*_Data` sont levés par le moteur de report pour les
  contrôles répétés de la bande `ligne` ; ils ne sont pas des fonctions mortes.
- **Instanciation** : jamais directe. `grep -rn 'Editfac' .src` ne trouve que
  `EditfacB.class:3` (`Inherits Editfac`) et une variable homonyme sans rapport
  (`Facture.class:115`, `Editfac As String`, drapeau « facture imprimable »). `EditfacB` est créé
  par `New EditfacB(Me, Me)` dans `ObjFacB` (lignes 658, 726, 773, 800, 866) ; le premier argument
  va à `Editfac._new(vfac As ObjFacB)`. Le report est imprimé via `ObjFac.edit` (`Public edit As
  Report`) par `edit.Print(imp)` (`ObjFac.class:899/905/942`, `ObjFacB.class:803/868`).
- **Handlers surchargés** (limite connue de `deps.py`) : `EditfacB.code_data` et
  `EditfacB.intitule_Data` remplacent `Editfac.code_Data` et `Editfac.intitule_Data` (résolution
  des handlers sur la classe réelle de l'objet, noms insensibles à la casse). Comme `Editfac`
  n'est créé qu'à travers `EditfacB`, les versions d'`Editfac` ne s'exécutent jamais ; elles
  restent nécessaires si une autre sous-classe ou une création directe apparaît. Les autres
  handlers (`stk_Data`… `tx_Data`) ne sont pas surchargés.
- **Membres utilisés par la sous-classe** : `lgint`, `clr`, `longueur` (portée `Public`
  nécessaire) ; `$vfac` n'est pas utilisé par `EditfacB` (portée réductible confirmée par grep).
- **Dépendances circulaires** : `ObjFacB` → `EditfacB` → `Editfac` → `ObjFacB` (type du paramètre
  de `_new` et de `$vfac`) et `ObjFac` (constantes de l'énumération `choix`). Un rework qui change
  un membre d'`ObjFac`/`ObjFacB` lu ici (60 membres, voir le bloc « Utilise ») repasse les tests
  de ce fichier.
- **Tables** : `Fiches_Societes` (`WHERE cd_sc = &1`, filtré par société : pas le défaut « sans
  WHERE » d'`Einvmat`/`Ecomptamat`/`Edart4`) et `Fiches_Bl` (comptage par client, sans filtre de
  type : EDITFAC-A03), noms en dur au lieu de `Cbase.Table`.
- **Interaction utilisateur** dans le constructeur (`Message.Question`, ligne 86) : à prévoir dans
  les scénarios de replay (réponse enregistrée) et dans les chaînes non interactives (mail).
- Aucun appel dynamique.
- **Ordre de rework** : après `ObjFac`/`ObjFacB` (contrat des membres lus) ; `LigneDoc` dans le
  même commit que les reworks d'`EditfacB` sur ses handlers ; l'en-tête société après la création
  de `LEnteteSoc` (CDOCUMENTS-006).
