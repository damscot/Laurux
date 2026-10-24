# impfec — Architecture

> Source : `.src/Compta/Utils/impfec.class` · Form : `impfec.form`

## Vue d'ensemble

Fenêtre « Intégration d'un fichier FEC » (Fichier des Écritures Comptables, format légal à 18
colonnes, 19 tolérées). Ouverte en non modal par `Fmenu.Menuimpfec_Click` (`impfec.Show`).

Déroulement (`Buttontra_Click`) :
1. **contrôle** complet du fichier (`ctrl`) : nombre de colonnes, existence des journaux et des
   comptes (directement ou via les tables de correspondance Ciel), unicité et caractère numérique
   des numéros d'écriture (si l'option « Renuméroter » n'est pas cochée) ;
2. si le contrôle est sans erreur, **import** (`trat`) : une ligne `Fiches_Mvt` par ligne FEC, plus
   une ligne « collectif » si le compte a un `coll_cc`, calcul de la clé SHA1 par écriture
   (`Sha1Calc.CalcSha1`), le tout dans une transaction ;
3. ouverture de `Calcsolde` (recalcul des soldes) en modal.

Colonnes FEC utilisées (index 0) : 0 `JournalCode`, 2 `EcritureNum`, 3 `EcritureDate` (AAAAMMJJ),
4 `CompteNum`, 5 `CompteLib`, 6 `CompAuxNum`, 8 `PieceRef`, 10 `EcritureLib`, 11 `Debit`,
12 `Credit`, 13 `EcritureLet`. La première ligne (en-tête) est ignorée. Fin de ligne attendue :
CRLF (`gb.Windows`).

Compte retenu : si `CompAuxNum` est renseigné, numérique et de longueur ≤ `Textcrt` (1 à 5), il est
complété à gauche par des zéros jusqu'à `Textcrt` caractères puis préfixé par les 3 premiers
caractères de `CompteNum` (ex. `111` sur 4 → `4110111`) ; sinon `CompAuxNum` brut ; sinon
`CompteNum`. Ce compte (et le journal) passe ensuite par les tables de correspondance `Ciel_Lrx`
(`Cciel` → `Clrx`) et `Ciel_Lrx_Jo`, éditées par `Cielcorsp` / `Cielcorspj` et créées si besoin
par `Utils.Ciel()` à l'ouverture.

Nature globale : **mixte**, logique d'import entièrement mêlée aux contrôles (`TextArea1`,
`Checkrnum`, `Textcrt`, boutons radio, barre de progression).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$hfile` | var | Private |  | File | 3 |
| `$fname` | var | Private |  | String | 4 |
| `$stp` | var | Private |  | Boolean | 5 |
| `$pgb` | var | Private |  | ProgBar | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-18 | Public | 1 | 8 | 0 | méthode spéciale |
| `Form_Close` | 20-26 | Public | 2 | 5 | 0 | handler GUI |
| `Buttontra_Click` | 28-64 | Public | 3 | 34 | 0 | handler GUI |
| `Buttonstop_Click` | 66-71 | Public | 1 | 4 | 0 | handler GUI |
| `Buttoncpt_Click` | 73-77 | Public | 1 | 3 | 0 | handler GUI |
| `Buttonjo_Click` | 79-83 | Public | 1 | 3 | 0 | handler GUI |
| `Buttonquit_Click` | 85-89 | Public | 1 | 3 | 0 | handler GUI |
| `ctrl` | 91-204 | Private | 25 | 99 | 0 |  |
| `trat` | 206-338 | Private | 21 | 125 | 0 |  |
| `carsep` | 340-347 | Private | 5 | 6 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Cycle de vie et boutons

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte]. `Utils.Observers(Me)`,
  `Utils.Ciel()` (création `Try` des tables `Ciel_Lrx`, `Ciel_Lrx_Jo` et de la colonne
  `Fiches_Parametres.imp_ciel` : DDL hors `LauruxMaj`), configuration de `Textcrt` (`TextReg`,
  un chiffre de 1 à 5). Variable locale `s` inutilisée.
- **`Form_Close()`** [portée : nécessaire (handler)] [nature : GUI]. Empêche la fermeture tant que
  `Buttonquit` est désactivé (traitement en cours). ⚠️ Si `trat` lève une erreur, les boutons ne
  sont jamais réactivés : la fenêtre ne peut plus être fermée (voir IMPFEC-A02).
- **`Buttontra_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Estime le nombre de
  lignes (`taille / 131`) pour deux barres de progression (`ProgBar`), appelle `ctrl()` puis
  `trat()`, affiche le succès et ouvre `Calcsolde.ShowModal`. Aucune gestion d'erreur.
- **`Buttonstop_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Lève `$stp`, testé
  seulement dans `ctrl` (le bouton est masqué avant `trat`).
- **`Buttoncpt_Click()` / `Buttonjo_Click()`** [portée : nécessaire (handlers)] [nature : GUI].
  Ouvrent `Cielcorsp` / `Cielcorspj` (correspondances comptes / journaux).
- **`Buttonquit_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Me.Close`.

### Contrôle (`ctrl`, privé, CC 25)

[nature : mixte ; partie extractible : contrôle d'une ligne, sans `TextArea1`]

- Vérifie le choix du fichier, son existence et la valeur « Autre » du séparateur.
- Ouvre le fichier dans `$hfile` (**jamais fermé**), saute l'en-tête, puis pour chaque ligne :
  - colonnes ∉ [18, 19] → `Message.Info` et sortie `False` (fichier laissé ouvert) ;
  - journal : `SELECT * FROM Ciel_Lrx_Jo WHERE Cciel=&1` puis
    `SELECT * FROM Fiches_Journaux WHERE code_jo=&1` ;
  - si pas de renumérotation : `SELECT * FROM Fiches_Mvt WHERE numero=&1` (doit être absent) et
    `IsNumber` du numéro ;
  - compte : calcul décrit plus haut (messages « non bloquant » si trop long ou non numérique),
    puis `SELECT * FROM Ciel_Lrx WHERE Cciel=&1` puis
    `SELECT * FROM Fiches_Comptes WHERE compte_cc=&1`.
- Toutes les erreurs bloquantes sont cumulées dans `TextArea1` ; résultat `err` (ou `False` si
  arrêt demandé). Tables en dur (pas de `Cbase.Table`).

### Import (`trat`, privé, CC 21)

[nature : mixte ; partie extractible : tout sauf `TextArea1`, `$pgb` et la lecture des contrôles]

- `LOCK TABLES Fiches_Mvt WRITE, Fiches_Comptes WRITE[, Fiches_Parametres WRITE]` (neutralisé sous
  SQLite par `DB_Connection.Exec`), puis `Utils.db.Begin`. ⚠️ Sous MySQL, démarrer une transaction
  libère implicitement les verrous de table ; aucun `UNLOCK TABLES` n'est émis (à confirmer, voir
  IMPFEC-A01).
- Pour chaque ligne : `Utils.db.Create9("Fiches_Mvt")` (création d'enregistrement gb.db), puis :
  - **numéro** : sans renumérotation, `Val(EcritureNum)` ; avec, à chaque changement d'écriture :
    `SELECT numecriture FROM Fiches_Parametres` + `UPDATE Fiches_Parametres SET numecriture=&1`
    (numéro + 1) ; au changement d'écriture, `Sha1Calc.CalcSha1("Fiches_Mvt", <numéro précédent>)` ;
  - `intitule` = `CompteLib` tronqué à 40, `dte` depuis `AAAAMMJJ`, `numdoc` = `PieceRef` (10),
    `numlot` = `EcritureLet` (10) et `lettree` = vrai si lettrage, `libelle` (50), `montantd` /
    `montantc` = `Val(Debit/Credit)` (séparateur décimal selon la locale, à confirmer),
    `validee` = vrai, autres drapeaux faux, `relance` = 0 ;
  - journal : `Ciel_Lrx_Jo.Clrx` sinon code FEC ; compte : `Ciel_Lrx.Clrx` sinon compte calculé ;
  - si `Fiches_Comptes.coll_cc` est renseigné : seconde ligne `Fiches_Mvt` sur le collectif
    (`collectif = 1`, même montants ; ⚠️ `intitule` **non tronqué**) ;
  - `res.Update`.
- Fin : SHA1 de la dernière écriture, `Utils.db.Commit`. Aucun `Rollback` ni `Catch`.

### Utilitaire

- **`carsep()`** [privé] [nature : GUI]. Séparateur selon le bouton radio (Autre → `TextBox1`,
  `;`, tabulation, `,`) ; renvoie `""` si aucun n'est coché (impossible avec des boutons radio).

## État global utilisé

- `Utils.db` (Exec, Create9, Begin, Commit), `Utils.Ciel`, `Utils.Observers`.
- `Sha1Calc.CalcSha1` avec le nom de table `"Fiches_Mvt"` en dur (déjà relevé pour Tresor,
  Saisecrit et Moulinage dans les notes transverses).
- Formulaires `Calcsolde`, `Cielcorsp`, `Cielcorspj` (auto-instances).
- Tables : `Fiches_Mvt` (INSERT), `Fiches_Parametres` (`numecriture`), `Fiches_Comptes`,
  `Fiches_Journaux`, `Ciel_Lrx`, `Ciel_Lrx_Jo` (lecture).

## Propositions d'amélioration

### Réécriture / refactorisation

- Le calcul du compte (CompteNum / CompAuxNum / `Textcrt`) est écrit deux fois avec la même
  sémantique (`ctrl` l.163-185, `trat` l.285-301) : fonction pure privée
  `CompteFec(sCompte, sAux, iNbCar) As String`, testable.
- La lecture « ouvrir, `EndOfLine = gb.Windows`, sauter l'en-tête, `Split` » est dupliquée :
  `LireFec(sChemin, sSep) As String[][]` qui ferme le fichier.
- Les lookups de correspondance (`Ciel_Lrx`, `Ciel_Lrx_Jo` puis table Laurux) deviennent
  `Correspondance(sTable, sCode) As String`.
- `ctrl` : extraire `ControleLigne(aCol, bRenum, iNbCar) As String` (messages de la ligne, `""` si
  rien) pour descendre sous CC 10.
- Tables via `Cbase.Table("TabMvt")`, `"TabJour"`, `"TabComptes"`, `"TabParam"` (SQL identique).

### Commonalisation avec d'autres fichiers

- Correspondances Ciel : [`Cielimp`](../../Cielimp.class/architecture.md) lit les mêmes tables
  `Ciel_Lrx` / `Ciel_Lrx_Jo` ; un helper commun de correspondance (module `Utils` ou socle
  d'import) servirait aux deux (à confirmer lors de la documentation de Cielimp).
- Création d'une ligne d'écriture + ligne collectif : même schéma que
  [`ImpJdv.Compta`](../ImpJdv.class/architecture.md) et [`ImpSage.ComptaS`](../ImpSage.class/architecture.md)
  (INSERT `Fiches_Mvt` + ligne collectif). Un helper `AjouteLigneMvt(...)` commun est envisageable,
  mais `impfec` passe par `Create9`/`Update` et calcule la clé SHA1, contrairement aux deux autres :
  la commonalisation doit garder ces différences (paramètre).
- Choix de fichier et lecture CSV : socle d'import/export `ImpExp` proposé dans
  [`Impclient`](../../../Utils/Exports-Imports/Impclient.class/architecture.md) (`LireCsv`).

### Réduction de portée

- Aucune : seules les fonctions de travail sont déjà `Private` ; les autres sont des handlers
  (nom et portée intouchables).

### Séparation traitement / GUI

- `ControleFec(sChemin, sSep, bRenum, iNbCar) As String[]` (liste des erreurs) et
  `ImporteFec(sChemin, sSep, bRenum, iNbCar) As Integer` (nombre de lignes) sans accès aux
  contrôles ; la progression passe par un paramètre optionnel `ProgBar` (ou un événement), l'arrêt
  par un membre testé par la boucle. Les handlers gardent `TextArea1`, boutons et `Calcsolde`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de correspondance `Ciel_Lrx` / `Ciel_Lrx_Jo` sont créées hors `LauruxMaj`
  (`Utils.Ciel`, à chaque ouverture) : les intégrer au schéma de référence (`db_control.csv`) et à
  `Cbase`.
- `Fiches_Parametres.numecriture` est incrémenté par lecture/écriture sans verrou ; une séquence
  (ou `LockIncrement`) éviterait les collisions multi-postes.
- Stocker la référence FEC d'origine (`EcritureNum`, `PieceDate`, `ValidDate`) permettrait un
  ré-import idempotent.
