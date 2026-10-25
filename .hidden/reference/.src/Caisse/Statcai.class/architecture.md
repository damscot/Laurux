# Statcai — Architecture

> Source : `.src/Caisse/Statcai.class`

## Vue d'ensemble

`Statcai` affiche le **chiffre d'affaires horaire HT des caisses** pour une journée choisie
(`DateBox1`) : une ligne par caisse, une colonne par heure de 8 h à 19 h (les ventes avant 8 h
sont cumulées sur 8 h, après 19 h sur 19 h) et un total général. Il est ouvert depuis le menu
Gestion (`Fmenu.Menu204_Click`, auto-instance, `ShowModal`).

Le calcul passe par une **table de travail `Total`** recréée à chaque clic sur « Rafraîchir »
(`DROP TABLE IF EXISTS` + `CREATE TABLE`), alimentée caisse par caisse et heure par heure à
partir des tickets en cours (`Fiches_EntTicketz`) et archivés (`Fiches_HisEntTickets`), puis
relue pour remplir la grille `Liste`. La table `Total` porte le même nom que les tables de travail
d'autres statistiques (`StatTypCli`, `StatClimo`, `VisStatTypCli`…) avec une **autre structure** :
deux utilisateurs simultanés, ou deux écrans, s'écrasent mutuellement.

Nature globale : **mixte** ; écran de lecture seule (aucune donnée métier modifiée, seule la
table de travail est écrite).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tot` | var | Private |  | Integer | 27 |
| `son` | var | Private |  | Integer | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-67 | Public | 1 | 34 | 0 | méthode spéciale |
| `Btn_Click` | 69-81 | Public | 3 | 9 | 0 | handler GUI |
| `Recup_ca` | 83-138 | Public | 10 | 51 | 0 | portée réductible ? |
| `Traitement` | 140-193 | Public | 17 | 50 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI] : `Utils.Observers(Me)`,
  `Tot = 20` (jamais relu), 13 colonnes alignées sur la largeur des zones d'en-tête `TextBox1` à
  `TextBox13` (zones placées dans le `.form`, pas dans l'ordre des heures), date du jour.
- **`Btn_Click()`** [handler du groupe `Btn`/`btn`, insensible à la casse] : tag 1
  (« Rafraîchir ») → `Recup_ca` puis `Traitement` ; tag 2 → fermeture.
- **`Recup_ca()`** [portée : réductible] [nature : calcul (SQL)] (CC 10) :
  - `drop Table IF exists Total`, `CREATE TABLE Total (heure int NOT NULL, ca decimal(12,2),
    ncai Char(2), PRIMARY KEY (heure, ncai))` + `Utils.db.Engine()`.
  - Pour chaque caisse (`SELECT * FROM <TabCaisses> order by code`) :
    `SELECT sum(cast(REPLACE(mht, ',', '.') as decimal(11,2))) as ca, HOUR(date) as heure FROM
    Fiches_EntTicketz WHERE caisse = &1 and statut IN(&2) and date BETWEEN &3 AND &4 and suppr != 1
    group by HOUR(date) union SELECT … FROM Fiches_HisEntTickets … group by HOUR(date)`.
    - `&2` reçoit la **chaîne** `"V","0"` : `Subst` la cite comme une seule valeur littérale, la
      condition devient `statut IN ('"V","0"')` et ne retient **aucun** ticket en cours ; seuls
      les tickets archivés comptent (STATCAI-A01).
    - `HOUR()` n'est pas traduit par `DB_Connection` pour SQLite : la requête échoue et le
      `Catch` affiche « problème sur une ligne de CA » (STATCAI-A02).
    - `union` (et non `union all`) fusionne deux lignes identiques (même heure, même CA) issues
      des deux tables (STATCAI-A03).
    - Tables en dur (`Fiches_EntTicketz`, `Fiches_HisEntTickets`, clés `TabEntTck`/`TabHisEntTck`).
  - Heure ramenée dans [8, 19] ; `SELECT` dans `Total` puis `UPDATE … SET ca` (cumul) ou `INSERT`.
  - Aucune caisse → « Aucune donnée à traiter ! ». `Catch` : son + `Message.Info` (et non
    `Message.Error`).
- **`Traitement()`** [portée : réductible] [nature : mixte] (CC 17) : `SELECT * FROM Total order
  by ncai, heure` ; nouvelle ligne de grille à chaque changement de caisse (clé `ncai & heure`),
  `Select Case` heure → colonne 1 à 12, cumul du total général dans `Totc`. `If IsNull(vah)` est
  mort (`Format$` ne renvoie jamais de chaîne nulle). Partie extractible : lecture de `Total` en
  tableau caisse × heure.

## État global utilisé

- `Start.Son` (copié dans le membre `son` à la création).
- `Utils.db` (`Exec`, `Engine`), `Utils.cpoint`, `Utils.Observers`, `LDate` (`DT`, `FinJour`).
- Tables : `Fiches_Caisses` (`TabCaisses`), `Fiches_EntTicketz`, `Fiches_HisEntTickets` (en dur),
  table de travail `Total` (créée, écrite, lue).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Traitement` : indice de colonne = `heure - 7` au lieu du `Select Case` de 12 cas (CC 17 → ≤ 5).
- `Recup_ca` : cumuler en mémoire (tableau caisse × heure) plutôt que `SELECT`/`UPDATE`/`INSERT`
  ligne à ligne dans `Total` ; la table `Total` doit toutefois rester écrite à l'identique tant
  qu'un replay compare le dump (SQL modifié, dump identique si la table finale est la même).
- Supprimer `Tot`, `Tab2`/`Tab3` en dur, `If IsNull(vah)`.

### Commonalisation avec d'autres fichiers

- Table de travail `Total` partagée par nom avec les statistiques de
  `.src/Statistiques` (`StatTypCli`, `StatClimo`, `StatComm`, `StatFour`, `TBord`, `HitCarte`,
  `StatComArt`) : un helper `Utils.TableTravail(nom, définition)` (création, nommage unique par
  session) servirait à tous — le changement de nom modifie le dump (anomalie STATCAI-A04).
- Somme du CA HT des tickets d'une période : à rapprocher des statistiques de caisse
  (`Caisse/Affichages`) et du ticket Z de [`Moulinage`](../Moulinage.class/architecture.md).

### Réduction de portée

`Recup_ca`, `Traitement` → `Private` (aucun appelant externe ; les chaînes `"Traitement"`
trouvées par `grep` sont des libellés de boutons d'autres écrans).

### Séparation traitement / GUI

`CaHoraire(dJour) As Collection` (calcul pur, sans `DateBox1`) et un remplissage de grille
séparé ; `Recup_ca` ne lit que `DateBox1.Value`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mht` est un `char(12)` converti par `REPLACE` + `cast` : une colonne `decimal` et un index sur
  `(caisse, date)` de `Fiches_EntTicketz`/`Fiches_HisEntTickets` accéléreraient la requête.
- Remplacer la table de travail par une table temporaire (`CREATE TEMPORARY TABLE`) ou un calcul
  en mémoire.
