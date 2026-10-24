# VerifDate — Architecture

> Source : `.src/Utils/VerifDate.class`

## Vue d'ensemble

`VerifDate` est une **date (`Inherits LDate`) qui sait si elle tombe dans une période close**. Elle
contrôle la date d'un document ou d'un mouvement par rapport :
- à la clôture comptable mensuelle (`DateCom`, colonne `dtefedec`) ;
- à la période de facturation en cours (`DateGes`, colonne `dtepec`, format `mm.yyyy`) ;
- en option viticole/spiritueux (`Utils.Option()` = `"B"` ou `"T"`), aux clôtures de la
  comptabilité matières (CM) en droits suspendus (`DateSus`) et acquittés (`DateAcq`), déduites du
  dernier mouvement `I`/`M` de `Fiches_ligregie`, ou à défaut de `Fiches_Parametres.arrete` + 1 mois.

Les prédicats `Clot*` renvoient `True` quand la date est **refusée**, après avoir affiché un
`Message.Warning`.

Construction : `New VerifDate(date)` — les arguments vont au constructeur de `LDate` (héritage
Gambas : le parent consomme les arguments, `VerifDate._new` n'en prend aucun), puis
`VerifDate._new` lit les paramètres. **Chaque instance exécute 1 à 3 requêtes SQL.**

Nature globale : **mixte** : SQL et règles de clôture d'une part, `Message.Warning` d'autre part.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$opt` | var | Private |  | String | 7 |
| `$respar` | var | Private |  | Result | 8 |
| `DateSus` | var | Public |  | LDate | 10 |
| `DateAcq` | var | Public |  | LDate | 11 |
| `DateCom` | var | Public |  | LDate | 12 |
| `DateGes` | var | Public |  | LDate | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-50 | Public | 9 | 32 | 0 | méthode spéciale |
| `_call` | 52-59 | Public | 1 | 5 | 0 | méthode spéciale |
| `ClotComptable` | 61-69 | Public | 2 | 7 | 1 |  |
| `ClotGestion` | 71-86 | Public | 3 | 13 | 0 | portée réductible ? |
| `ClotFac` | 88-94 | Public | 3 | 5 | 3 |  |
| `ClotSuspendu` | 97-120 | Public | 10 | 21 | 0 | portée réductible ? |
| `ClotAcquite` | 122-145 | Public | 10 | 21 | 0 | portée réductible ? |
| `ClotDroi` | 148-154 | Public | 3 | 5 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : calcul + SQL].
  - `$opt = Utils.Option()` ;
  - `SELECT dtepc, dtepec[, arrete], dtefedec FROM Fiches_Parametres` (nom de table **en dur**, pas
    de `Cbase.Table("TabParam")`, pas de test `Available`) ;
  - `DateCom = LDate(dtefedec)` ; `DateGes = LDate("01." & dtepec)` (premier jour de la période) ;
  - option B/T : `DateSus` (resp. `DateAcq`) = date du dernier `dtmouv` de `Fiches_ligregie` jointe
    à `Fiches_regie` (`suspendu = True`, resp. `False`, types `I`/`M`) ; à défaut, premier jour du
    mois qui suit `arrete` ; si `arrete` est vide : `Error.Raise("Veuillez compléter la date
    d'arrêté…")` qui remonte à l'appelant.
  Les requêtes sur `Fiches_ligregie`/`Fiches_regie` sont écrites sans paramètre ni `Cbase.Table`
  (pas de clé `Cbase` pour ces tables) ; `suspendu = True` repose sur le littéral booléen SQL
  (accepté par MySQL et SQLite ≥ 3.23).
- **`_call(…)`** [portée : réductible — **code mort**] [nature : calcul]. Fabrique `New VerifDate(…)`.
  Aucun appel `VerifDate(…)` sans `New` dans le projet (`deps.py` compte les `New VerifDate` comme
  `_call` : faux positif).
- **`ClotComptable()`** [portée : nécessaire] [nature : mixte]. `True` + `Message.Warning` si
  `Me.Avant(DateCom)` (non strict : la date de clôture elle-même est refusée).
  Appelant : `SaiReg.class:247`.
- **`ClotGestion()`** [portée : réductible] [nature : mixte]. Refuse une date strictement avant
  `DateGes` (début de période) ou strictement après la fin du mois suivant
  (`DateGes + 1 mois`, `.FinMois.FinJour`). La fenêtre autorisée couvre donc **deux mois** (période
  en cours et suivante). Appelée seulement par `ClotFac`.
- **`ClotFac()`** [portée : nécessaire] : `ClotComptable() Or ClotGestion()` (court-circuit : un
  seul message). Appelants : `Facturefm:538`, `ObjFac:842`, `ObjFacB:907`.
- **`ClotSuspendu(nart, droi)`** (CC 10) [portée : réductible] [nature : mixte + SQL]. Hors option
  B/T : `False`. Si `nart` est fourni, lit `art_dra` dans `Fiches_Art` ; si le droit est fourni,
  lit `Fiches_regie` et sort `False` si le droit n'est pas suspendu. Refuse (`True` + message) une
  date strictement avant `DateSus`.
- **`ClotAcquite(nart, droi)`** [portée : réductible] : symétrique pour les droits acquittés et
  `DateAcq`. Les deux fonctions sont **identiques à 4 détails près** (test `suspendu`, date de
  référence, texte du message).
- **`ClotDroi(nart, droi)`** [portée : nécessaire] : `ClotSuspendu Or ClotAcquite`. Appelants :
  `Facture:6511` (appel **statique** `VerifDate.ClotDroi(cart.Text)`, voir anomalie A02),
  `Facture:10258`, `Mvtex:348`, `commande1:761`, `ObjFacB:938`.
- `Public DateSus`, `DateAcq`, `DateGes` : lus seulement en interne ; `DateCom` est lu par
  `commande1.class:750` (`dt.DateCom.Apres(…)`).

## État global utilisé

- `Utils.Option()` (option métier B/T), `Utils.db`.
- Tables (en dur) : `Fiches_Parametres` (`dtepc`, `dtepec`, `dtefedec`, `arrete`), `Fiches_ligregie`,
  `Fiches_regie`, `Fiches_Art` (`art_dra`).
- Auto-instance statique (`Create Static`) : créée au premier appel statique
  (`VerifDate.ClotDroi` dans `Facture`) avec la date et les paramètres de cet instant, puis
  conservée pour toute la session.

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner `ClotSuspendu`/`ClotAcquite` dans une fonction privée
  `ClotCM(nart, droi, suspendu As Boolean)` ; les deux `Public` deviennent des appels d'une ligne.
- Extraire dans `_new` un helper privé `DateCloture(suspendu As Boolean, arrete) As LDate` pour les
  deux blocs identiques.
- Remplacer `Fiches_Parametres`/`Fiches_Art` par `Cbase.Table("TabParam")`/`Cbase.Table("TabArt")`
  (même nom physique, aucun changement de comportement). `Fiches_regie`/`Fiches_ligregie` n'ont pas
  de clé `Cbase` : à laisser en dur (ou ajouter une clé `Cbase`, hors périmètre de ce fichier).

### Commonalisation avec d'autres fichiers

- Le calcul « premier jour de la période `mm.yyyy` » (`"01." & dtepec`) se retrouve dans
  `Moulinage.class:1035` (`LDate(rResult!dtepec).PFin`) et dans d'autres écrans de facturation :
  candidat d'un accesseur commun (par ex. `VerifDate.DateGes` réutilisé par `Moulinage`).
- Les fonctions d'exercice de [`LDate`](../LDate.class/architecture.md) et ce fichier lisent tous
  deux `Fiches_Parametres` : un module de lecture des paramètres de clôture partagé éviterait les
  requêtes dispersées (phase 3).

### Réduction de portée

- `_call` : code mort (aucun appel sans `New`).
- `ClotGestion`, `ClotSuspendu`, `ClotAcquite` : pas d'appel externe ; passage en `Private`
  possible si couverts via `ClotFac`/`ClotDroi`.
- `DateSus`, `DateAcq`, `DateGes` : lecture interne uniquement → `Private` possible ;
  `DateCom` reste `Public` (`commande1`).

### Séparation traitement / GUI

- Chaque `Clot*` mélange la règle et le `Message.Warning`. Proposition : prédicats purs privés
  (`EstAvantClotureComptable()`, …) qui renvoient la raison du refus, le message (même texte) restant
  dans la fonction `Public` actuelle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `dtepec` et `arrete` sont stockés en texte `mm.yyyy` : un type `DATE` (premier jour du mois)
  supprimerait la concaténation `"01." & …`.
- Les dates de clôture de CM sont recalculées à chaque instance par un `ORDER BY dtmouv DESC
  LIMIT 1` : un index `(type, dtmouv)` sur `Fiches_ligregie` ou une colonne de clôture explicite dans
  `Fiches_regie` accélérerait la construction.
