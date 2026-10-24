# FCloture — Architecture

> Source : `.src/Compta/Clotures/FCloture.class`

## Vue d'ensemble

Écran de **clôture mensuelle** (clôture de période) de la comptabilité. Il affiche la dernière
période clôturée (`Fiches_Parametres.dtepc`) et la période à clôturer (mois suivant). La
validation :

1. refuse la clôture s'il reste des écritures **provisoires** (`provisoire = 1`) dans le mois ;
2. parcourt les écritures validées du mois (`Fiches_Mvt`, tri par `numero`), **vérifie la clé
   SHA-1** de chacune (`Sha1Calc.CalcSha1_Verify`) et arrête tout à la première clé invalide ;
3. pose `cloturee = 1`, `dteval = <aujourd'hui>` et, si l'écriture n'a pas encore de numéro
   définitif, `numerodef = <compteur>` (une incrémentation par changement de `numero`) ;
4. met à jour `Fiches_Parametres.dtepc` (dernier jour du mois clôturé) et `numecriture2`
   (compteur des numéros définitifs).

Ouvert en modal par `Fmenu.Menu46_Click` (après contrôle du tunnel de réplication). Le bouton
« Clôture annuelle » ouvre seulement la documentation HTML (`Doc.Open("ClotureAn")`).

Nature globale : **mixte** ; tout le traitement est dans le handler `Button1_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dtpc` | var | Private |  | String | 29 |
| `Dpc` | var | Private |  | String | 30 |
| `Depc` | var | Private |  | String | 31 |
| `dtepc` | var | Private |  | String | 32 |
| `Dateimp1` | var | Private |  | String | 33 |
| `Dateimp2` | var | Private |  | String | 34 |
| `son` | var | Private |  | Integer | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-44 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 46-50 | Public | 1 | 3 | 0 | handler GUI |
| `Aff_date` | 52-84 | Public | 4 | 30 | 0 | portée réductible ? |
| `Button3_Click` | 86-90 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 92-161 | Public | 17 | 64 | 0 | handler GUI |
| `Button2_Click` | 163-167 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. Observateurs de replay
  (`Utils.Observers`), chargement du son, centrage.
- **`Form_Open()`** [portée : nécessaire, handler] [nature : GUI]. Appelle `Aff_date`.
- **`Aff_date()`** [portée : réductible] [nature : mixte]. Lit `Fiches_Parametres` (nom en dur).
  Si la table est vide : son, `Message.Warning`, puis `Start.UnLock`, `Utils.fermeTunnel`,
  `Utils.db.Close` et **`Quit`** (fin de l'application). Sinon convertit `dtepc` (Date → chaîne
  `mm/dd/yyyy` → `Utils.Cdate_Aff` → `dd.mm.yyyy`), affiche le mois clôturé (`dateprc`) et calcule
  le mois suivant (`dtepc` = `mm`, passage à janvier N+1) affiché dans `datecl`. Les membres
  `Dateimp1`, `Dateimp2`, `Depc` sont calculés mais jamais lus ; `Dtpc` ne sert qu'à l'affichage.
- **`Button3_Click()`** [portée : nécessaire, handler] [nature : GUI]. Ferme.
- **`Button1_Click()`** (CC 17) [portée : nécessaire, handler] [nature : mixte]. Traitement de
  clôture décrit en vue d'ensemble. SQL émis :
  - `SELECT * FROM Fiches_Parametres` (deux fois : l. 107 et l. 152, la seconde est inutilisée) ;
  - `SELECT * FROM Fiches_Mvt WHERE Mid(dte,6,2) = &1 and left(dte,4) = &2 and provisoire = &3`
    (contrôle des provisoires, puis liste des validées triée par `numero`) ;
  - par ligne : `UPdate Fiches_Mvt SET cloturee = 1[, numerodef = n], dteval = <yyyymmdd>
    where numero = … and compte = … and lind = …` (le paramètre `&3` est passé inutilement dans
    la seconde variante) ;
  - `UPdate Fiches_Parametres SET dtepc = …, numecriture2 = …`.
  Effets de bord : `ProgBar` (interruption possible par l'utilisateur, voir FCLOTURE-A01) ;
  `FCloture.Close()` (auto-instance, équivalent à `Me.Close` puisque l'écran est ouvert par
  `FCloture.ShowModal()`) en cas de clé SHA-1 invalide. Les variables `dtex` (fin d'exercice),
  `$cle` sont inutilisées. Le dernier jour du mois est calculé à la main (l. 145-150) alors que
  `LDate.FinMois` existe.
- **`Button2_Click()`** [portée : nécessaire, handler] [nature : GUI]. `Doc.Open("ClotureAn")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.UnLock`.
- `Utils.db`, `Utils.Observers`, `Utils.fermeTunnel`, `Utils.Cdate_Aff`, `Utils.Cdate_Dbase`.
- `Sha1Calc.CalcSha1_Verify("Fiches_Mvt", …)` (nom de table en dur, voir notes transverses).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les membres et variables inutilisés (`Dateimp1`, `Dateimp2`, `Depc`, `dtex`, `$cle`)
  et le `SELECT` de la l. 152 (FCLOTURE-002).
- Dernier jour du mois via `LDate(...).FinMois` (FCLOTURE-003).
- Remplacer `FCloture.Close()` par `Me.Close()` (même instance, lisibilité).

### Commonalisation avec d'autres fichiers

- Dates de période : [`LDate`](../../../Utils/LDate.class/architecture.md) fournit `PDeb`/`PFin`
  (période = mois) et `FinMois` ; `Aff_date` et le calcul l. 143-150 les réimplémentent par
  découpage de chaîne. Même constat dans [`FClotureAn`](../FClotureAn.class/architecture.md)
  et [`Extrait.finmois`](../../Extrait.class/architecture.md).
- Noms de tables : `Cbase.Table("TabMvt")`, `Cbase.Table("TabParam")` (FCLOTURE-004), y compris
  pour l'argument de `Sha1Calc.CalcSha1_Verify` (même remarque pour `Tresor`, `Saisecrit`,
  `Moulinage`).
- Le contrôle « tunnel de réplication » avant ouverture est dupliqué dans `Fmenu.Menu46_Click` et
  `Fmenu.Menu60_Click` (clôture annuelle) : à factoriser côté `Fmenu`.

### Réduction de portée

- `Aff_date` → `Private` (aucun appelant externe ; couvert par les replays).

### Séparation traitement / GUI

- Extraire `ClotureMois(sMois, sAnnee, numecr, PB) As String` (SQL + vérification SHA-1, sans
  accès aux contrôles ; renvoie un message d'erreur ou `""`), appelé par `Button1_Click` qui garde
  les messages et la souris (FCLOTURE-005).
- Extraire le calcul « période clôturée → période suivante » en fonction pure (gb.test).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le filtre `Mid(dte,6,2) = mm and left(dte,4) = yyyy` empêche l'usage d'un index sur `dte` ;
  un filtre `dte BETWEEN premier AND dernier jour` (sans changement de schéma) puis un index sur
  `(dte, provisoire)` accéléreraient le traitement.
- Un historique des clôtures de période (table dédiée : période, date, utilisateur, compteur)
  remplacerait l'unique champ `dtepc` et faciliterait les contrôles.
