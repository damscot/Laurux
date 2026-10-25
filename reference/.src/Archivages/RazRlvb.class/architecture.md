# RazRlvb — Architecture

> Source : `.src/Archivages/RazRlvb.class`

## Vue d'ensemble

`RazRlvb` est l'écran **« Epuration des relevés bancaires »** (menu Comptabilité, `Fmenu.Menu262`,
fenêtre modale). Il supprime de `Fiches_Rappro` les relevés dont `date_releve` est **strictement
antérieure** à la date choisie dans `DateChooser1`. `Fiches_Rappro` (clé `cpt`, `nreleve`) mémorise,
par compte de banque, chaque relevé rapproché, sa date et son solde ; elle est alimentée et relue par
[`Pointage`](../../Compta/Pointage.class/architecture.md) (relevé précédent, solde de départ).

Opération **destructive**. Le traitement comporte une question de confirmation et une sauvegarde
`mysqldump` préalable, mais :

- ⚠️ **la purge s'exécute même si l'utilisateur répond « Non »** : le `Endif` de la ligne 29 ne
  ferme que le bloc de sauvegarde ; la lecture et les `DELETE` (l. 30-36) sont hors du `If`
  (RAZRLVB-A01). Répondre « Non » supprime donc les relevés **sans** sauvegarde ;
- aucune transaction, aucun garde-fou sur la date (date du jour par défaut, à confirmer) ;
- la sauvegarde n'est pas contrôlée (voir RAZRLVB-A02).

C'est l'un des six écrans `Raz*` du lot, bâtis sur le même squelette (voir « Commonalisation »).
L'écran n'appelle pas `Utils.Observers` : il n'est ni journalisé ni rejouable en l'état.

Nature : **mixte** (handler GUI qui porte directement le SQL).

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
| `Button1_Click` | 16-41 | Public | 6 | 23 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button1_Click()`** (CC 6) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son (`Start.son`), puis `Message.Question` (« Oui »/« Non »).
  2. Si « Oui » : curseur d'attente, création de `~/Sauve` si besoin, puis
     `Shell "mysqldump --lock-tables=0 -h <Host> -u <Login> -p<Password> <Base> --add-drop-table >
     ~/Sauve/<Base>EffaceR.sql" Wait` (l. 28). Le code retour n'est pas lu.
  3. **Dans tous les cas** (A01) : `SELECT * FROM Fiches_Rappro where date_releve < &1` avec
     `Format$(DateChooser1.Value, "yyyymmdd")`, puis pour chaque ligne
     `delete FROM Fiches_Rappro where cpt = &1 and nreleve = &2 and date_releve = &3`.
     La table est nommée en dur (`Tab = "Fiches_Rappro"`) au lieu de `Cbase.Table("TabRappro")`
     (même nom physique).
  4. `Syntheses.Message` (lecture vocale si `/son2`) et `Message.Info` avec le nombre de relevés.
  - Borne : `<` strict sur un `datetime` comparé à `'AAAAMMJJ'` → sous MySQL, les relevés **du
    jour choisi** sont conservés (cohérent avec « antérieurs à la date saisie »).
  - Pas de filtre société : chaque société a sa propre base (`Laurux<XX>`).
  - Variable locale `PB As ProgBar` déclarée mais jamais utilisée.
  - Sous SQLite, `date_releve` a l'affinité NUMERIC : `'20240101'` devient l'entier 20240101, et une
    date stockée en texte (`2023-05-01 00:00:00`, format écrit par `Subst`) n'est **jamais**
    inférieure à un entier (vérifié avec `sqlite3`) → purge sans effet (RAZRLVB-A03, à confirmer
    selon le format réellement stocké).

## État global utilisé

- `Start.son`, `Start.LocalSettings["/dbase/Host"]` ; `Utils.db` (`Login`, `Password`, `Name`,
  `Exec`) ; `Syntheses.Message` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la boucle `SELECT` + `DELETE` ligne à ligne par un seul
  `DELETE FROM <TabRappro> WHERE date_releve < &1` précédé d'un `SELECT COUNT(*)` pour le message
  (SQL modifié, dump identique).
- `Cbase.Table("TabRappro")` à la place du nom en dur.
- Supprimer la variable `PB` inutilisée.

### Commonalisation avec d'autres fichiers

Les six écrans de purge du lot partagent le même squelette (question, `mkdir ~/Sauve`, `mysqldump`
vers `~/Sauve/<Base>Efface<X>.sql`, boucle `SELECT` puis `DELETE`, `Syntheses.Message` +
`Message.Info`) : [`RazClientd`](../RazClientd.class/architecture.md),
[`RazDevis`](../RazDevis.class/architecture.md), [`RazHistoFac`](../RazHistoFac.class/architecture.md),
[`RazHistoFbl`](../RazHistoFbl.class/architecture.md), [`RazHistoTk`](../RazHistoTk.class/architecture.md).

- Sauvegarde : `Utils.DumpBase(sFichier, sOptions)` proposé par
  [`SauvesAuto`](../../Communs/SauvesAuto.module/architecture.md) (SAUVESAUTO-003, UTILS-014),
  commande identique (`--lock-tables=0 --add-drop-table`).
- Squelette : module d'aide `Epuration` (nouveau fichier `.src/Archivages/Epuration.module`) avec
  `Confirme(sTexte) As Boolean`, `Sauvegarde(sSuffixe)` et `Fin(iNb, sLibelle)` (messages
  identiques), appelé par les six écrans ; les handlers et les `.form` restent inchangés.

### Réduction de portée

- Aucune : `_new` et les deux handlers doivent rester `Public`.

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite As String) As Integer` (lecture + suppressions, sans accès aux
  contrôles), appelée par `Button1_Click` avec `Format$(DateChooser1.Value, "yyyymmdd")`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Mvt*.nrlv` référence `Fiches_Rappro.nreleve` sans contrainte : une clé étrangère (ou un
  indicateur « relevé archivé » au lieu d'une suppression) éviterait les références orphelines.
- Index sur `Fiches_Rappro(date_releve)` si la table devient volumineuse.
