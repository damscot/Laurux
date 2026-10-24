# Agenda — Architecture

> Source : `.src/Utils/Agenda.class` · Formulaire : `.src/Utils/Agenda.form`

## Vue d'ensemble

`Agenda` est l'**écran d'agenda journalier** ouvert depuis le menu principal
(`Fmenu.Menu202_Click` → `Agenda.show`). Il affiche une grille `Coldetail` de 60 lignes (créneaux
de 15 minutes de 06h00 à 20h45) ; un clic sur un créneau ouvre une zone de saisie (`TextArea1`),
le bouton `Button1` enregistre l'action dans `Fiches_Agenda` (`daction` date `yyyy-mm-dd`,
`haction` libellé du créneau `"08h15"`, `iaction` texte, `nuser` utilisateur système). Une horloge
(`Timer2` → `V1`), le quantième et le numéro de semaine sont affichés, et quatre boutons ouvrent des
sites externes (`xdg-open`).

Nature globale : **GUI**, avec trois requêtes SQL dans `Ecr_action` et `Maj_Zones`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Nligne` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 8-16 | Public | 1 | 7 | 0 | méthode spéciale |
| `Timer2_Timer` | 18-23 | Public | 1 | 4 | 0 | handler GUI |
| `Init` | 25-52 | Public | 2 | 25 | 0 | portée réductible ? |
| `DateChooser1_Change` | 54-61 | Public | 1 | 6 | 0 | handler GUI |
| `Coldetail_Click` | 63-78 | Public | 2 | 14 | 0 | handler GUI |
| `Button1_Click` | 80-89 | Public | 1 | 8 | 0 | handler GUI |
| `Ecr_action` | 102-113 | Public | 2 | 9 | 0 | portée réductible ? |
| `Maj_Zones` | 116-138 | Public | 5 | 20 | 0 | portée réductible ? |
| `Button2_Click` | 140-146 | Public | 1 | 4 | 0 | handler GUI |
| `TextArea1_KeyPress` | 148-152 | Public | 2 | 3 | 0 | handler GUI |
| `TextArea1_DblClick` | 154-158 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 160-164 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 166-170 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 172-176 | Public | 1 | 3 | 0 | handler GUI |
| `Button6_Click` | 178-182 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. Centre la fenêtre, `Init()`, `Maj_Zones()`
  (qui rappelle `Init()` : la grille est initialisée deux fois), démarre l'horloge.
- **`Timer2_Timer()`** [nature : GUI]. Affiche `hh : nn : ss` (format construit à la main ; une
  première affectation `V1.Text = ""` est inutile).
- **`Init()`** [portée : réductible] [nature : GUI]. 2 colonnes, 60 lignes, libellés `hhh00`,
  `hh15`, `hh30`, `hh45` avec un fond gris dégradé ; quantième (`CInt(Now) − CInt(1er janvier) + 1`)
  et semaine (`Week(Now)`) **de la date du jour**, pas de la date sélectionnée.
- **`DateChooser1_Change()`** [nature : GUI] : masque l'éditeur, vide la grille, `Maj_Zones()`.
- **`Coldetail_Click()`** [nature : GUI] : bascule l'éditeur sur le créneau courant (`Nligne` =
  libellé du créneau, texte existant recopié).
- **`Button1_Click()`** [nature : mixte] : recopie le texte dans la grille, masque l'éditeur,
  `Ecr_action()`.
- **`Ecr_action()`** [portée : réductible] [nature : mixte, SQL].
  `SELECT * FROM Fiches_Agenda WHERE daction = &1 AND haction = &2 AND nuser = &3` ; absent →
  `INSERT (daction, haction, iaction, nuser)` ; présent → `UPdate … SET iaction = &3 WHERE
  daction = &1 AND haction = &2`. ⚠️ L'`UPDATE` **ne filtre pas sur `nuser`** : il modifie les
  actions de tous les utilisateurs pour ce créneau (anomalie AGENDA-A01). Les valeurs sont lues dans
  les contrôles (`DateChooser1.Value`, `TextArea1.Text`) et `User.Name`.
  Une ancienne version commentée (l. 92-100) est conservée.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte, SQL]. `Init()`, puis
  `SELECT * FROM Fiches_Agenda WHERE daction = &1` (⚠️ **sans filtre `nuser`** : affiche les actions
  de tous les utilisateurs, anomalie AGENDA-A02) ; pour chaque action, recherche linéaire du créneau
  dans les 60 lignes. Variable `Date_action` calculée mais inutilisée. `Action.Count > 0` au lieu de
  `Action.Available`.
- **`Button2_Click()`** [nature : GUI] : arrête l'horloge et ferme.
- **`TextArea1_KeyPress()`** (Échap) / **`TextArea1_DblClick()`** [nature : GUI] : referment
  l'éditeur via `Coldetail_Click()`.
- **`Button3_Click` … `Button6_Click`** [nature : GUI] : `Exec ["xdg-open", url]` vers
  calendrier-365.fr, almanach.free.fr, timeanddate.com (phases de lune) et meteolafleche.com.
  URL en dur ; le site météo est local à un utilisateur historique.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabAgenda")` → `Fiches_Agenda`.
- `User.Name` (utilisateur système, pas l'utilisateur Laurux).
- `Now` (horloge, quantième, semaine).

## Propositions d'amélioration

### Réécriture / refactorisation

- `_New` : supprimer l'appel direct à `Init()` (déjà fait par `Maj_Zones`) — effet visible nul.
- `Timer2_Timer` et `_New` : une fonction privée `Heure() As String` (`Format$(Now, "hh : nn : ss")`).
- `Maj_Zones` : indexer les créneaux par libellé (`Collection` libellé → ligne) plutôt que la
  recherche linéaire ; supprimer `Date_action`.
- Supprimer l'ancienne version commentée d'`Ecr_action`.

### Commonalisation avec d'autres fichiers

- `Format$(DateChooser1.Value, "yyyy-mm-dd")` (4 occurrences) → `LDate(DateChooser1.Value).D`
  ([`LDate`](../LDate.class/architecture.md), candidat recensé dans la commonalisation des dates).
- Le quantième et la semaine se calculent à la main : `LDate` expose `Week` ; un `DayOfYear` n'existe
  pas encore (ajout possible dans `LDate` si d'autres écrans en ont besoin).
- Les ouvertures `Exec ["xdg-open", …]` existent ailleurs (`Visualiseur.Prog`) : réutiliser
  `Visualiseur` pour les URL (à confirmer qu'il gère les URL http).

### Réduction de portée

- `Init`, `Ecr_action`, `Maj_Zones` : aucun appel externe (vérifié par `grep`) → `Private`
  (couverts par le replay).

### Séparation traitement / GUI

- Extraire `EnregistrerAction(jour As Date, creneau As String, texte As String, user As String)` et
  `LireActions(jour As Date) As Result` (SQL pur, sans contrôle) appelées par `Ecr_action` et
  `Maj_Zones`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `daction` et `haction` sont en `varchar(20)` : un `DATE` et un `TIME` (ou un `DATETIME` unique)
  permettraient tri et filtrage natifs.
- Index unique `(daction, haction, nuser)` pour garantir une action par créneau et par utilisateur
  et permettre un `INSERT … ON DUPLICATE KEY UPDATE`.
