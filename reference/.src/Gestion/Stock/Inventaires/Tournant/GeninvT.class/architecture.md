# GeninvT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class`

## Vue d'ensemble

Écran de **génération d'un inventaire tournant** (menu 95,
[`Fmenu.class:1091`](../../../../../Communs/Fmenu.class/architecture.md), `GeninvT.Showmodal()`).
Contrairement à [Geninv](../../Fin-annee/Geninv.class/architecture.md) qui prend tous les articles
stockés, il ne retient qu'une **plage** d'articles stockés, bornée au choix par famille
(`Fam`/`Fam2`, défaut `00000`–`ZZZZZ`), fournisseur (`Four`/`Four2`, défaut
`40100001`–`40199999`) ou casier (`Casier`/`Casier2`, défaut `00000`–`99999`). Quatre listes
déroulantes (`Colfam`, `Colfam2`, `Colfour`, `Colfour2`, ouvertes par `ToggleButton1..4`) aident
à choisir les bornes.

- **Traitement** (`button1_Click` → `gen_Inv`) : recrée `Fiches_InvT` (`DROP` + `CREATE`, clé
  auto-incrémentée `lind` via `Utils.db.AutoIncrement`) et y insère les articles de la plage, triés.
- **Imprimer** (`Button3_Click`) : **renumérote** `inv_nlig` selon le tri choisi (un `UPDATE` par
  ligne), puis imprime la feuille de comptage `~/tmp/Inventaire.pdf` (`Cstocks.Level1G/Level2G`).

Suite de la chaîne : [SaisieInvT](../SaisieInvT.class/architecture.md),
[EcartsT](../EcartsT.class/architecture.md), [EdnsaisisT](../EdnsaisisT.class/architecture.md),
[Edinv](../../Fin-annee/Edinv.class/architecture.md) (`"T"`), [ValidinvT](../ValidinvT.class/architecture.md).
Le tableau de la chaîne complète et la mesure de duplication sont dans
[Geninv](../../Fin-annee/Geninv.class/architecture.md) (156 lignes communes avec `Geninv`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `CoulZns` | var | Private |  | Integer | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `Coulfond` | var | Private |  | New String[] | 31 |
| `pdf` | var | Private |  | Cstocks | 32 |
| `tri` | var | Private |  | String | 33 |
<!-- /AUTO:declarations -->

- `CoulZns` (couleur des zones de saisie) et `Coulfond` : affectés dans `_New`, **jamais lus**.
- `tri` : colonne de tri, recalculée par `gen_Inv` et `Button3_Click` (pourrait être locale).
- `Filename` : `~/tmp/EdinvT.ps` (vestige) puis `~/tmp/Inventaire.pdf`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-52 | Public | 1 | 15 | 0 | méthode spéciale |
| `Cmpt_GotFocus` | 57-63 | Public | 1 | 5 | 0 | handler GUI |
| `button1_Click` | 65-103 | Public | 20 | 36 | 0 | handler GUI |
| `Fm_Click` | 105-125 | Public | 1 | 19 | 0 | handler GUI |
| `Fr_Click` | 127-147 | Public | 1 | 19 | 0 | handler GUI |
| `Cs_Click` | 149-169 | Public | 1 | 19 | 0 | handler GUI |
| `ToggleButton1_Click` | 174-209 | Public | 6 | 33 | 0 | handler GUI |
| `Colfam_KeyPress` | 214-235 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 240-275 | Public | 6 | 33 | 0 | handler GUI |
| `Colfam2_KeyPress` | 280-301 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton3_Click` | 306-341 | Public | 6 | 33 | 0 | handler GUI |
| `Colfour_KeyPress` | 346-367 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton4_Click` | 372-407 | Public | 6 | 33 | 0 | handler GUI |
| `Colfour2_KeyPress` | 412-433 | Public | 6 | 18 | 0 | handler GUI |
| `Colfam_Click` | 438-446 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 451-459 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 464-472 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 477-484 | Public | 1 | 6 | 0 | handler GUI |
| `gen_Inv` | 486-573 | Public | 16 | 85 | 0 | portée réductible ? |
| `Button3_Click` | 575-666 | Public | 13 | 88 | 0 | handler GUI |
| `button2_Click` | 668-673 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 675-679 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et choix du critère

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Couleurs (inutilisées),
  `Utils.Observers(Me)`, date du jour en texte `dd.mm.yyyy` dans `Dte` (lecture seule), bornes
  famille par défaut.
- **`Cmpt_GotFocus()`** [portée : nécessaire (handler du groupe `Cmpt` : `Fam`, `Fam2`, `Four`,
  `Four2`, `Casier`, `Casier2`)] [nature : GUI]. `Utils.SetEditColor(Me, Last)`.
- **`Fm_Click()` / `Fr_Click()` / `Cs_Click()`** [portée : nécessaire (handlers)] [nature : GUI].
  Rendent éditables les bornes du critère choisi, grisent (`&HD4D0C8&`) et vident les autres, posent
  les bornes par défaut. Les trois **rappellent `Utils.Observers(Me)`** à chaque clic : cumul
  probable d'observateurs de log/replay (GENINVT-A04). Trois blocs de 19 lignes quasi identiques.

### Listes de choix des bornes

- **`ToggleButton1_Click` … `ToggleButton4_Click()`** [portée : nécessaire (handlers)] [nature :
  mixte]. Si le critère correspondant est actif, affiche/masque la `ColumnView` et la remplit par
  `SELECT * FROM Fiches_Fam ORDER BY code_fam` (1, 2) ou `SELECT * FROM Fiches_Four ORDER BY
  fo_code` (3, 4) (noms en dur). Quatre blocs de 33 lignes identiques au contrôle et à la requête
  près. L'état `Value` des `ToggleButton` n'est pas synchronisé avec la visibilité des listes.
- **`Colfam_KeyPress`, `Colfam2_KeyPress`, `Colfour_KeyPress`, `Colfour2_KeyPress()`** [portée :
  nécessaire (handlers)] [nature : GUI]. Entrée → `<Col>_Click` ; F1 → aide ; Échap/F2 → masque la
  liste et rend le focus. `Colfam2_KeyPress` donne le focus à `fam` mais sélectionne `fam2`
  (l. 296-297).
- **`Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click()`** [portée : nécessaire —
  handlers **et** `replay_dynamic` : appelés par `ReplayObserver.Replay_Click` via `Object.Call`,
  ils doivent rester `Public` (REPLAYOBSERVER-A06)] [nature : GUI]. Recopient le code choisi dans
  la borne et passent le focus au champ suivant ; `Colfam2_Click` donne le focus à `four` (en
  lecture seule en mode famille) et `Colfour2_Click` au bouton **Quitter** (`Button2`) : une
  frappe sur Entrée ferme alors l'écran (GENINVT-A05).

### Génération et impression

- **`button1_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Exige les deux bornes du
  critère actif (`Fm And Fam And Fam2 Or If Fr … Or If Cs …`, chaînes non vides = vrai), sinon
  « Veuillez saisir les bornes ». Lit `SELECT * FROM Fiches_InvT` (nom en dur) : inventaire
  existant non validé → question ; validé (`inv_valid = 1`, seulement après une validation
  interrompue puisque `ValidinvT` supprime la table) → autre question ; absent → `gen_Inv`. Comme
  `Geninv`, la table absente passe par le **`Catch` → `gen_Inv`** (GENINVT-A02).
- **`gen_Inv()`** [portée : réductible] [nature : mixte]. Calcule `tri` (`art_code`/`art_design`/
  `art_casier`) ; `DROP` + `CREATE TABLE Fiches_InvT (…, lind AUTO_INCREMENT PK)` ; six `SELECT *
  FROM Cbase.Table("TabArt") WHERE art_stocke = 1 AND <critère> >= &2 AND <critère> <= &3 ORDER BY
  …` : si « Code article » est coché, `ORDER BY <tri>, art_code` ; sinon l'ordre est
  `<critère>, art_design` et `tri` est ignoré. Un `INSERT` par article (comme `Geninv`). CC 16.
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Recalcule `tri`
  (`inv_code`/`inv_design`/`inv_casier`), **renumérote `inv_nlig`** (`UPDATE … SET inv_nlig = &1
  WHERE lind = &2` pour chaque ligne, dans l'ordre `ORDER BY tri`), relit la table dans cet ordre,
  formate la date (`Mid/Left/Right` sur la conversion texte `mm/dd/yyyy` de `inv_date`) et imprime.
  Un article supprimé (`rarts` sans `Available`) aboutit au message « Veuillez générer votre
  inventaire ». La renumérotation **modifie les données à chaque impression** (GENINVT-A01).
- **`button2_Click()`** [handler] [GUI]. Supprime `Filename`, ferme.
- **`Button4_Click()`** [handler] [GUI]. `Doc.Open("Geninvt")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Coul/Znss"]` (lu, inutilisé) ;
  `Utils.db` (`Exec`, `Engine`, `AutoIncrement`), `Utils.Cdate_Dbase`, `Utils.FColr`,
  `Utils.Coulfd`, `Utils.SetEditColor`, `Utils.Observers`.
- Tables : `Fiches_InvT` (créée, renumérotée ; nom en dur), `Fiches_Art` (`Cbase.Table`),
  `Fiches_Fam`, `Fiches_Four` (noms en dur).

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les quatre `ToggleButtonN_Click` en un helper privé `Liste_Affiche(hCol As ColumnView,
  sTable, sCode, sLibelle)` et les quatre `<Col>_KeyPress` en `Liste_Touche(hCol, hBorne, …)` ; les
  handlers restent, réduits à un appel. Idem `Fm/Fr/Cs_Click` → `Critere_Active(sCritere)`.
- `gen_Inv` : construire la clause de critère et l'`ORDER BY` par listes blanches, un seul `SELECT`
  (texte SQL identique pour chaque cas).
- `Button3_Click` : séparer renumérotation, lecture et mise en page.

### Commonalisation avec d'autres fichiers

- Socle commun `Inventaire` (voir [Geninv](../../Fin-annee/Geninv.class/architecture.md)) :
  `Supprimer`, `Creer("T")`, `Generer`, `Libelle`, partagés avec `Geninv`.
- La boucle d'impression de la feuille est identique à `Geninv.Button3_Click` (hors renumérotation
  et date).
- Les listes de choix famille/fournisseur rejoignent le socle transverse « grille filtrable / liste
  de choix » relevé dans les notes transverses (≈ 30 écrans, voir aussi les écrans `Tri*` de `Affichages`).

### Réduction de portée

- `gen_Inv` → `Private` (aucun appelant externe, vérifié par grep).
- Les handlers `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` restent `Public`
  (appel dynamique du rejeu).

### Séparation traitement / GUI

- `gen_Inv` → `Generer(sCritere, sBorneInf, sBorneSup, sOrdre, sDate) As Integer` ;
  `Renumeroter(sTri)` extrait de `Button3_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Même table permanente que pour la fin d'exercice (`inv_type = 'T'`), `inv_nlig` numérique.
- Stocker le tri d'impression plutôt que renuméroter physiquement `inv_nlig`.
