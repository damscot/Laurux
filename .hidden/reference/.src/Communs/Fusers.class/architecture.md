# Fusers — Architecture

> Source : `.src/Communs/Fusers.class`

## Vue d'ensemble

`Fusers` est la petite fenêtre de **gestion des utilisateurs de la gestion des tâches** (Fmenu
`Menu50`, `Fusers.Show`). Elle liste, crée, modifie et supprime les lignes de `Fiches_Users`
(`lind` auto-incrément, `nom` varchar(20), `poste` varchar(35)). Ces couples « nom@poste »
alimentent la liste des destinataires de tâches dans `Facture` (l.355, si
`/Soc<XX>/Taches` est actif). La table est créée par `LauruxMaj` (l.4398).

Nature globale : **GUI** avec SQL dans les handlers ; aucune logique métier.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoulZns` | var | Private |  | Integer | 3 |
| `CoulFoc` | var | Private |  | Integer | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 6-30 | Public | 1 | 19 | 0 | méthode spéciale |
| `Form_Open` | 32-46 | Public | 3 | 12 | 0 | handler GUI |
| `MajZones` | 48-54 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button4_Click` | 56-60 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 62-79 | Public | 3 | 15 | 0 | handler GUI |
| `Refresh` | 81-87 | Public | 1 | 5 | 0 | portée réductible ? |
| `Coluser_Click` | 89-93 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 95-107 | Public | 4 | 11 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. Lit les couleurs `/Coul/Focus` et `/Coul/Znss`
  (`Utils.FColr`) dans `CoulFoc`/`CoulZns`, qui ne sont **jamais utilisées** ; appelle
  `Utils.Observers(Me)` **deux fois** (l.14 et l.19 : observateurs de focus et `ReplayObserver`
  doublés) ; `Music.Load(Start.Musique)` ; prépare les deux colonnes de `Coluser`.
- **`Form_Open()`** [handler, appelé aussi par `Refresh`] [nature : mixte]. SQL
  `SELECT * FROM Fiches_Users` (nom en dur, sans `ORDER BY`) ; une ligne par utilisateur, clé de
  ligne = `nom` (deux utilisateurs de même nom provoquent une erreur de clé dupliquée du
  `ColumnView`, à confirmer).
- **`MajZones()`** [portée : réductible] [GUI] : copie la ligne courante dans `Utilisateur`/`Poste`.
- **`Coluser_Click()`** [handler] : `MajZones`.
- **`Button3_Click()`** (Enregistrer) [handler] [mixte] : si `Utilisateur` est renseigné,
  `SELECT * FROM Fiches_Users WHERE nom = '<texte>'` (⚠️ **concaténation**, une apostrophe casse la
  requête), puis `UPdate Fiches_Users SET nom = &1, poste = &2 WHERE nom = &1` (seul le poste peut
  changer : un renommage est impossible et crée une nouvelle ligne) ou
  `INSERT INTO Fiches_Users (nom, poste)`. `Refresh`.
- **`Button2_Click()`** (Supprimer) [handler] [mixte] : si `Utilisateur` est renseigné, son si
  `Start.son`, confirmation, puis `DELETE FROM Fiches_Users WHERE nom = &1` avec
  **`Coluser.Current[0]`** (ligne sélectionnée, pas le nom saisi ; erreur si aucune ligne n'est
  sélectionnée, à confirmer). Supprime toutes les lignes de ce nom.
- **`Refresh()`** [portée : réductible] [GUI] : vide les champs et rappelle `form_Open()`.
- **`Button4_Click()`** (Quitter) : `Me.Close`.
- Le bouton `Button1` (« Doc HTML ») n'a **aucun handler** : il ne fait rien.

## État global utilisé

- `Start.LocalSettings["/Coul/Focus"]`, `["/Coul/Znss"]` (lus pour rien), `Start.Musique`,
  `Start.son`.
- `Utils.db`, `Utils.FColr`, `Utils.Observers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Paramétrer la requête de `Button3_Click` (`WHERE nom = &1`) : SQL identique pour tout nom sans
  apostrophe ; corrige l'erreur sinon (changement de comportement, voir A01).
- Extraire le chargement de la liste dans `Charger()` au lieu d'appeler le handler `form_Open`.

### Commonalisation avec d'autres fichiers

- Même structure « liste + deux champs + Enregistrer/Supprimer » que les petites tables de
  paramétrage (`Typec`, `Statut`, `Centrales`…) : un futur composant commun de saisie de table
  simple est envisageable hors de ce plan.
- Lecture de couleurs `Utils.FColr(Start.LocalSettings["/Coul/…"])` recopiée dans de nombreux
  écrans (voir [Utils](../../Utils/Utils.module/architecture.md), `Observers`).

### Réduction de portée

`MajZones`, `Refresh` : aucun appelant externe (grep `Fusers\.`).

### Séparation traitement / GUI

`ListeUtilisateurs() As Result`, `EnregistrerUtilisateur(nom, poste)`,
`SupprimerUtilisateur(nom)` : SQL sans contrôle ; les handlers gardent messages et
rafraîchissement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `nom` (ou sur `(nom, poste)`) : les mises à jour et suppressions par nom
  deviendraient sans ambiguïté, et la clé de ligne du `ColumnView` serait garantie unique.
- Lien explicite entre `Fiches_Users` et `Fiches_Taches` (aujourd'hui « nom@poste » en texte et
  filtre `LIKE User.Name%` dans Fmenu).
