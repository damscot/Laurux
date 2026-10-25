# RazHistoTk — Architecture

> Source : `.src/Archivages/RazHistoTk.class`

## Vue d'ensemble

`RazHistoTk` est l'écran **« Epuration des tickets de caisse »** (sous-menu Epurations,
`Fmenu.Menu260`, modal ; aussi `Prgm` avec le nom `eft`, non modal). Il supprime les **tickets
archivés** (tickets déjà moulinés, voir [`Moulinage`](../../Caisse/Moulinage.class/architecture.md))
dont la date est strictement antérieure à la date choisie : en-têtes `Fiches_HisEntTickets`
(clé `TabHEntTck`) et lignes `Fiches_HisLigTickets` (clé `TabHLigTck`). Les tickets en cours de la
caisse (`Fiches_EntTicketz`/`Fiches_LigTicketz`) ne sont pas concernés.

Opération destructive : question de confirmation, sauvegarde `mysqldump` dans
`~/Sauve/<Base>EffaceT.sql`, barre de progression interruptible ; ni transaction ni garde-fou sur la
date (date du jour par défaut, à confirmer).

⚠️ Les suppressions se font **par numéro de ticket seul** (`numero`, non unique : la clé est `lInd`) :
un autre ticket de même numéro, postérieur à la date, et ses lignes sont supprimés aussi (même
famille que MOULINAGE-A10 ; doublons possibles, cf. MOULINAGE-T08).

Les tickets archivés servent ensuite à : la consultation [`ArchivesTck`](../ArchivesTck.class/architecture.md),
les statistiques caisse (`Statcai`, `HitCarte`, `EdRup`), l'historique des cartes de fidélité
(`FClientcarte`), la réédition du livre de caisse (`Moulinage`). Ils portent aussi le chaînage
d'intégrité des tickets (`control`, `prev_numero`, écrits par `Caisse`/`Moulinage`) : la purge
supprime le début de la chaîne et réduit la durée de conservation des justificatifs de caisse
(obligation de conservation à vérifier, RAZHISTOTK-A02).

Écran non instrumenté (`Utils.Observers` absent). Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button2_Click` | 9-13 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 16-45 | Public | 7 | 27 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button1_Click()`** (CC 5) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son, `Message.Question` ; rien si « Non ».
  2. `~/Sauve`, puis `Shell "mysqldump … > ~/Sauve/<Base>EffaceT.sql" Wait` (code retour ignoré).
  3. `SELECT * FROM <TabHEntTck> where date < &1` (`Format$(DateChooser1.Value, "yyyymmdd")`).
  4. `ProgBar` (« Suppression historique tickets », rafraîchie tous les 100 tickets ; le bouton
     d'arrêt interrompt la boucle par `Break` : purge partielle mais cohérente ticket par ticket).
  5. Pour chaque ticket : `delete FROM <TabHLigTck> where numero = &1` puis
     `delete FROM <TabHEntTck> where numero = &1` (numéro seul, A01).
  6. `Syntheses.Message` + `Message.Info` (« N tickets ont été effacés »).
  - Borne `<` stricte sur `date` (`datetime`) : sous MySQL, les tickets du jour choisi sont
    conservés. Sous SQLite, comparaison texte/entier : purge sans effet (A04, à confirmer).
  - Références laissées orphelines : `Fiches_Bl.numtick`/`Fiches_BlM.numtick` (BL réglés en caisse),
    `Fiches_Acomptes.ntk` ; sans conséquence fonctionnelle connue (à confirmer).
  - Les clés `TabHEntTck`/`TabHLigTck` doublonnent `TabHisEntTck`/`TabHisLigTck` (même table physique,
    `Cbase.module:245-276`), utilisées par `Moulinage`, `ArchivesTck` et `EdRup`.

## État global utilisé

- `Start.son`, `Start.LocalSettings["/dbase/Host"]` ; `Utils.db` ; `Cbase.Table` ;
  `Syntheses.Message` ; `ProgBar` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Unifier les clés `Cbase` : `TabHisEntTck`/`TabHisLigTck` (nom physique identique).
- Deux `DELETE` ensemblistes (lignes par sous-requête sur les en-têtes, puis en-têtes) au lieu de
  la boucle : SQL modifié ; le dump n'est identique que si aucun numéro n'est en doublon (sinon la
  correction de A01 est incluse) → à réserver à l'après-A01.

### Commonalisation avec d'autres fichiers

- Même squelette que [`RazHistoFac`](../RazHistoFac.class/architecture.md),
  [`RazHistoFbl`](../RazHistoFbl.class/architecture.md), [`RazDevis`](../RazDevis.class/architecture.md)
  (en-tête + lignes + `ProgBar`), [`RazRlvb`](../RazRlvb.class/architecture.md) et
  [`RazClientd`](../RazClientd.class/architecture.md) : module `Epuration` (RAZRLVB-006) avec en plus
  `PurgeEnteteLignes(sTabEnt, sTabLig, sColDate, sColCle, sColLien, sDate, sLibelle) As Integer`
  (boucle + `ProgBar`, SQL identique), et `Utils.DumpBase` (SAUVESAUTO-003).

### Réduction de portée

- Aucune (handlers et `_new`).

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite) As Integer` (la `ProgBar` reste dans la fonction de
  traitement, ou est passée en paramètre optionnel).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé d'unicité `(caisse, numero)` ou `(numero, date)` sur `Fiches_HisEntTickets` et clé de jointure
  `lInd` d'en-tête dans `Fiches_HisLigTickets` : la suppression se ferait sur l'identifiant.
- Archivage froid (table ou base d'archives) plutôt que suppression, pour préserver la chaîne
  d'intégrité et la durée de conservation.
