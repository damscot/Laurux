# Majcasier — Architecture

> Source : `.src/Gestion/Lcr/Portables/Majcasier.class`

## Vue d'ensemble

Écran **« Mise à jour code casier »** (`Fmenu.Menu275_Click`). Il met à jour l'emplacement de
stockage (`Fiches_Art.art_casier`, code casier de 5 caractères maximum) de tous les articles scannés
avec le **terminal portable d'inventaire** (voir [`Portable`](../Portable.module/architecture.md)) :
l'utilisateur saisit le code casier, confirme que `inventaire.txt` est copié dans `~/Portable`, puis
« Importer ». Le 3ᵉ champ de chaque ligne du fichier est le code-barres ; les codes inconnus sont
listés dans `~/tmp/Casier.txt`, ouvert dans l'éditeur s'il y a des rejets.

Aucun lien avec les LCR malgré l'emplacement du fichier. L'écran appelle `Utils.Observers(Me)`.

Nature : écran **mixte** (lecture de fichier + SQL dans `Import_Portable`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoulZns` | var | Private |  | Integer | 3 |
| `CoulZnaf` | var | Private |  | Integer | 4 |
| `CoulFc` | var | Private |  | Integer | 5 |
| `hfil` | var | Private |  | File | 6 |
| `Lig` | var | Private |  | String | 7 |
| `iPos` | var | Private |  | Integer | 8 |
| `filename` | var | Private |  | String | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 11-28 | Public | 1 | 14 | 0 | handler GUI |
| `Button1_Click` | 30-41 | Public | 3 | 10 | 0 | handler GUI |
| `Import_Portable` | 46-102 | Public | 17 | 53 | 0 | portée réductible ? |
| `Button2_Click` | 104-109 | Public | 2 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`form_Open()`** [événement] [nature : GUI] : centrage (deux fois), musique, couleurs
  `CoulZnaf`, `Coulfc`, `CoulZns` calculées mais **jamais utilisées**, `Utils.Observers(Me)`, focus
  sur `Casier`.
- **`Button1_Click()`** [événement] [GUI] : casier vide → bulle d'avertissement ; sinon
  `message.Question(...)` (un seul bouton « OK », retour 1) puis `Import_Portable()`. Le texte de la
  question n'est pas sous la forme `("…")` (non extrait pour l'i18n).
- **`Import_Portable()`** [portée : réductible] [nature : mixte] (CC 17) :
  - supprime puis crée `~/tmp/Casier.txt` (rapport) ;
  - appelle `Portable.Import("Casier")`, qui ne fait que vider `~/tmp/ImpT.txt` (aucun traitement
    pour cette valeur) : appel inutile ;
  - ouvre `~/Portable/inventaire.txt` (membre `HFil`, lecture-écriture) ; absent → `Message.Error` ;
  - pour chaque ligne : 3 champs découpés par `;` (une ligne à moins de 3 champs reprend le dernier
    champ) ; champ 3 non vide → `Code = Utils.Find_cbarre(cle)` ; vide → message de rejet et
    `cpt2 + 1`, mais `Code` garde la valeur de la ligne précédente ;
  - `SELECT * FROM Cbase.Table("TabArt") where art_code = &1` ; trouvé →
    `Try UPDATE <TabArt> SET art_casier = &1 where art_code = &2` (erreurs ignorées) ; sinon
    rapport `code & " " & Codeb` (`Codeb` jamais affecté : le code-barres lu n'apparaît pas dans le
    rapport, seulement le code résolu, vide pour un inconnu) ;
  - curseur d'attente, fermeture des fichiers, `Editeur.Prog_Editeur(~/tmp/Casier.txt)` si rejets.
    Aucun message de fin indiquant le nombre d'articles mis à jour.
- **`Button2_Click()`** [événement] : `Try Kill filename` (rapport) puis fermeture.

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`), `Start.Musique`, `User.Home`.
- `Utils.FColr`, `Utils.Observers`, `Utils.Find_cbarre`, `Utils.db`, `Cbase.Table("TabArt")`,
  `Portable.Import`, `Editeur.Prog_Editeur`.
- Fichiers : `~/Portable/inventaire.txt`, `~/tmp/Casier.txt`, `~/tmp/ImpT.txt` (vidé par `Portable`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Membres `hfil`, `Lig`, `iPos`, `filename` → variables locales (seul `filename` est partagé avec
  `Button2_Click`).
- Supprimer les couleurs inutilisées et le second `Me.Center`.

### Commonalisation avec d'autres fichiers

- Lecture et découpage de `inventaire.txt`, résolution du code-barres : à remplacer par
  `Portable.LireInventaire()`/`Portable.ResoudreCode()` (voir PORTABLE-004), communs avec les écrans
  d'étiquettes, `Achat`, `SaisieInv`, `SaisieInvT`, `Facture`.

### Réduction de portée

- `Import_Portable` → `Private` (aucun appel externe, `grep -rn "Majcasier\." .src` : seul
  `Majcasier.Show()`).

### Séparation traitement / GUI

- Extraire `MajCasiers(casier, lignes) As String[]` (renvoie les rejets) sans accès aux contrôles ;
  `Import_Portable` garde le curseur, les messages et l'ouverture de l'éditeur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table des casiers (emplacements) référencée par `Fiches_Art.art_casier` permettrait de
  valider le code saisi.
