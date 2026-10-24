# Parametre — Architecture

> Source : `.src/Communs/Parametre.class`

## Vue d'ensemble

`Parametre` est la **fenêtre des paramètres comptables et de numérotation** de la société
courante (menu Fmenu `Menu25`, protégé par `MDP` si `Admin` est actif). Elle édite l'unique ligne
de `Fiches_Parametres` (une base par société) : dates de clôture des exercices N à N-5, comptes de
résultat et de régularisation, journaux (ventes, caisse, banque, ventes caisse, achat, OD,
report), derniers numéros (client, fournisseur, bon, facture, article, ticket), coefficient de
rétrocession, devise, périodes, version du schéma, frais.

Selon l'option métier (`Utils.Option()` : `N`, `B` boisson, `P` carburant, `T` les deux, déduite
des clés `/Soc<XX>/bois` et `/Soc<XX>/pp` de `Prefs`), deux cadres supplémentaires apparaissent :

- `Frame1` (B/T) : comptes de consignes client/fournisseur, vignette (`nvign`), compte et TVA de
  sécurité sociale (`css`, `tvass`), date d'arrêté ; `ident` et `caution` de `Fiches_Societes` ;
- `Frame3` (P/T) : région TIPP (`Fiches_Societes.tipp`) et grille `SaiTableau` des articles
  soumis à la TICPE (table `Art_Tipp`).

Ces colonnes et la table `Art_Tipp` **n'existent pas** dans le schéma de référence
(`db_control.csv`) : elles sont créées à la volée par `modfichier` quand l'option est cochée dans
`Prefs`.

La fenêtre prend un verrou applicatif `DocActif.Get_Lock("Parametres", "0")` à l'ouverture (sans
tester le résultat) et le libère à la fermeture. **Toute fermeture enregistre** : `Form_Close`
appelle `Button2_Click` et bloque la fermeture (`Stop Event`) tant que la saisie est invalide.

Nature globale : **GUI** avec SQL intégré aux handlers.

### Paramètres de base et paramètres de configuration

`Fiches_Parametres` contient aussi la colonne blob `conf` (configuration globale INI, voir
[Prefs](../Prefs.class/architecture.md), section « Mécanisme de surcharge locale / globale »).
`Parametre` lit la ligne avec `SELECT *` (blob compris) mais **n'écrit jamais** `conf` : ses
`UPDATE` ne listent que les colonnes métier. Les deux fenêtres modifient donc la même ligne sans
interférence de colonnes, mais sans verrou commun (`Prefs` ne prend pas de `DocActif`).
`Parametre` lit une seule clé de configuration : `/Soc<XX>/Caisse` (journal de ventes caisse
obligatoire si la caisse est active).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 27 |
| `B` | var | Private |  | Integer | 28 |
| `son` | var | Private |  | String | 29 |
| `$soption` | var | Private |  | String | 30 |
| `$tab` | var | Private |  | SaiTableau | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-84 | Public | 5 | 47 | 0 | méthode spéciale |
| `Form_Open` | 86-182 | Public | 62 | 92 | 0 | handler GUI |
| `Par_DblClick` | 184-197 | Public | 3 | 10 | 0 | handler GUI |
| `par_keypress` | 199-226 | Public | 8 | 22 | 0 | handler GUI |
| `Par_lostfocus` | 228-293 | Public | 15 | 56 | 0 | handler GUI |
| `Btn_Click` | 295-311 | Public | 5 | 11 | 0 | handler GUI |
| `Form_Close` | 313-323 | Public | 2 | 9 | 0 | handler GUI |
| `cpts_LostFocus` | 326-354 | Public | 7 | 26 | 0 | handler GUI |
| `Dnbon_LostFocus` | 358-369 | Public | 3 | 10 | 0 | portée réductible ? |
| `Dnfac_LostFocus` | 371-382 | Public | 3 | 10 | 0 | portée réductible ? |
| `coretro_LostFocus` | 384-390 | Public | 2 | 5 | 0 | handler GUI |
| `jrnal_LostFocus` | 392-441 | Public | 17 | 45 | 0 | handler GUI |
| `Dnclient_LostFocus` | 444-456 | Public | 3 | 11 | 0 | portée réductible ? |
| `Dnfournisseur_LostFocus` | 458-472 | Public | 3 | 13 | 0 | portée réductible ? |
| `mcdt` | 474-491 | Public | 2 | 15 | 0 | portée réductible ? |
| `Button2_Click` | 493-553 | Public | 50 | 58 | 0 | portée réductible ? |
| `meserrc` | 555-562 | Public | 2 | 6 | 0 | portée réductible ? |
| `meserrt` | 564-571 | Public | 2 | 6 | 0 | portée réductible ? |
| `Verif_Compte` | 573-584 | Public | 2 | 9 | 0 | portée réductible ? |
| `Veriftva` | 586-593 | Private | 1 | 5 | 0 |  |
| `Button3_Click` | 595-599 | Public | 1 | 3 | 0 | portée réductible ? |
| `Version_DblClick` | 601-605 | Public | 1 | 3 | 0 | handler GUI |
| `cretipp` | 607-641 | Private | 1 | 28 | 0 |  |
| `tab_ajou` | 643-650 | Public | 1 | 5 | 0 | handler GUI |
| `code_LostFocus` | 652-666 | Public | 3 | 12 | 0 | handler GUI |
| `Valtip_Click` | 668-688 | Public | 4 | 17 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et ouverture

- **`_New()`** [portée : nécessaire] [nature : GUI]. Crée 4 chaînages de saisie (`Chainage` : ordre
  de tabulation), `Utils.Observers(Me)`, centre la fenêtre, lit l'option métier (`$soption`) et
  affiche `Frame1`/`Frame3`. Configure les `TextReg` : 9 dates (`EstDate`), comptes (`[0-9]{1,8}`),
  journaux (`[0-9]{1,2}`), `Ecart`/`frais`/`coretro` numériques à 2 décimales, `version`
  (`[0-9]{0,2}[.]?[0-9]{0,2}`).
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte] (CC 62, maximum du fichier). SQL :
  `SELECT * FROM Fiches_Parametres` (nom **en dur**), `DocActif.Get_Lock("Parametres", "0")`
  (résultat ignoré), `Music.Load`. Remplit les contrôles sous `Try` ; valeurs de repli :
  `dnclient` « 411000 », `dnfournisseur` « 401000 », `dnbon`/`dnfac` « 0 », `coretro` « 1 ».
  Option B/T : colonnes de consigne, puis `SELECT * FROM Fiches_Societes` (sans `WHERE`, première
  ligne) pour `ident`/`caution` ; `Jod.Text = rResult!jrnod` relu **sans** `Try` (doublon de la l.129).
  Option P/T : `tipp` de `Fiches_Societes`, `cretipp`, puis
  `SELECT * FROM Art_Tipp LEFT JOIN Fiches_Art ON art_code = code` chargé ligne à ligne dans la
  grille (`ComboBox` → `Index`, sinon `Text`). Le bloc `With Utils` ne sert à rien.

### Enregistrement

- **`Button2_Click()`** [portée : nécessaire, appelé par `Btn_Click` et `Form_Close`]
  [nature : mixte] (CC 50). Ce n'est **pas** un handler actif : `Button2` appartient au groupe
  `Btn`. Contrôle les champs obligatoires (`b = 1` si vide) : 9 dates (⚠️ `datefedec` testé par
  `IsNan` au lieu de `IsNull`, l.505), comptes de résultat/régul, journaux, derniers numéros,
  `coretro` ; vérifie l'existence de `cptfrais`/`tvafrais` et, en option B/T, de
  `conscli`/`consfou`/`css`/`tvass` (proposition de création via `meserrc`/`meserrt`) ; valide les
  périodes `mc`/`mc2` (`mcdt`) ; `jrnal4` obligatoire si `/Soc<XX>/Caisse`. Si tout est valide :
  - `UPdate Fiches_Parametres SET dteclec … dnart` (30 colonnes, `dnart` tronqué à 15) ;
  - `UPdate Fiches_Parametres SET frais, cptfrais, tvafrais, cutk, dntk, jrnod, ecart` ;
  - option B/T : `UPdate Fiches_Parametres SET conscli … arrete` et
    `UPdate Fiches_Societes SET ident, caution` ;
  - option P/T : `UPdate Fiches_Societes SET tipp`.
  Aucun `UPDATE` n'a de `WHERE` (table mono-ligne ; pour `Fiches_Societes`, voir A05). Sinon
  `Message.Error("Veuillez compléter correctement l'ensemble des zones SVP !")`.
  ⚠️ `version` (version du schéma, pilote `LauruxMaj.Verif_Version`) est réécrite depuis un champ
  déverrouillable par double-clic (`Version_DblClick`).
- **`Btn_Click()`** [handler du groupe `Btn`] [GUI] : `Tag` 1 → aide, 2 → enregistrer, 3 →
  enregistrer puis `Me.Close` (qui rappelle `Form_Close` → `Button2_Click` : **double
  enregistrement**, deux séries d'`UPDATE` identiques).
- **`Form_Close()`** [handler] [mixte] : `Button2_Click` ; si valide, `DocActif.Free_Lock` puis
  `Me.Close` (dans l'événement de fermeture) ; sinon `Stop Event`.
- **`Button3_Click()`** [appelé par `Btn_Click` et `par_keypress` (F1)] : `Doc.Open("Parametres")`.

### Contrôles de saisie

- **`Par_DblClick`**, **`par_keypress`** [handlers du groupe `Par`] : déverrouillent `dnclient`
  (Tag 15) et `dnfournisseur` (Tag 16) par double-clic ou Ctrl+M ; F1 ouvre l'aide.
- **`Par_lostfocus`** [handler du groupe `Par`] (CC 15) : `Frais` (31) normalisé en « 0,00 » ;
  `tvafrais` (33) et `tvass` (38) : proposition de création de compte de TVA (`FTvav`) ; `nvign`
  (36) : complété à 25 chiffres avec des zéros à gauche.
- **`cpts_LostFocus`** [handler du groupe `cpts`] : `Verif_Compte(Last.Text)` ; si absent, propose
  `FComptes.ShowModal`. Gère le drapeau `b` pour ne pas boucler sur la perte de focus.
- **`jrnal_LostFocus`** [handler du groupe `jrnal`] : SQL `SELECT * FROM Fiches_Journaux WHERE
  code_jo = &1` (nom en dur) ; propose la création (`FJournaux`) ou vérifie le type (VE pour
  `jrnal`/`jrnal4`, TR pour `jrnal2`/`jrnal3`, AC pour `jrnal5`, OD pour `Jod`/`Jreport`, qui
  doivent différer).
- **`coretro_LostFocus`** : 0 → 1.
- **`Dnbon_LostFocus`**, **`Dnfac_LostFocus`**, **`Dnclient_LostFocus`** (préfixe 411),
  **`Dnfournisseur_LostFocus`** (préfixe 401) : ⚠️ **jamais déclenchés** — ces contrôles
  appartiennent au groupe `Par`, Gambas lève donc `Par_LostFocus` et non `<Nom>_LostFocus`
  (à confirmer par replay). Les contrôles de préfixe 411/401 ne sont donc pas actifs.
- **`Version_DblClick`** : déverrouille `Version`.
- **`mcdt(mc)`** [portée : réductible] [calcul + GUI] : convertit « mm.aaaa » via
  `Utils.Cdate_calc`/`Cdate_Aff` ; `b = 1` et focus si la date est invalide (« 00.0:00 »).
- **`meserrc(txtbox)`**, **`meserrt(txtbox)`** [portée : réductible] [GUI] : `b = 1`, question
  puis `FComptes`/`FTvav`.
- **`Verif_Compte(Compte)`** [portée : réductible (aucun appelant externe)] [calcul] :
  `SELECT * FROM TabComptes WHERE compte_cc = &1`.
- **`Veriftva(tva)`** [Private] [calcul] : `SELECT * FROM Fiches_Tvaav WHERE code_tva = &1` (en dur).

### Grille TICPE (option P/T)

- **`cretipp()`** [Private] [mixte] : `SELECT * FROM Art_Tipp LEFT JOIN Fiches_Art … LIMIT 1` pour
  les métadonnées de colonnes, puis `SaiTableau` à 3 colonnes (Code, Désignation, Catégories).
- **`tab_ajou(s)`** [handler `tab`] : observateur `code` sur la nouvelle ligne ; liste de catégories
  codée en dur (« GNR détaxé », « Carburant »).
- **`code_LostFocus`** [handler `code`] : `SELECT * FROM Fiches_Art WHERE art_code = &1` ;
  désignation ou `Message.Error("Article innexistant")`.
- **`Valtip_Click`** [handler] [mixte] : `Netoyage("Code")` puis, pour chaque ligne,
  `Utils.db.Edit("Art_Tipp", "code=&1")` ou `Create("Art_Tipp")`, `ticpe = Index`, `Update`.
  ⚠️ `Utils.db.Begin` **sans `Commit`** : les écritures restent dans une transaction ouverte jusqu'au
  prochain `Commit` d'un autre écran (ou sont perdues à la déconnexion).

## État global utilisé

- `Start.Musique` (`Music.Load`), `Start.LocalSettings["/Soc<XX>/Caisse"]`, `Start.Societe`.
- `Utils.db`, `Utils.Option()` (clés `/Soc<XX>/bois` et `/pp`), `Utils.Observers`,
  `Utils.Cdate_calc`, `Utils.Cdate_Aff`.
- `DocActif` (auto-instance de la fenêtre, utilisée comme service de verrou).
- Variable membre `son` (String) : **jamais affectée**, donc les 6 blocs `If son Then Music.Play`
  ne s'exécutent jamais.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : liste des contrôles obligatoires parcourue en boucle (`IsNull(ctl.Text)`), les
  cas particuliers (`IsNan` de `datefedec`, `Caisse`, vérifications de comptes) restant explicites.
- Construire les valeurs à enregistrer dans une fonction `ValeursSaisies() As Variant[]`, puis
  `EnregistrerParametres(aValeurs)` sans accès aux contrôles.
- `Btn_Click` case 3 : appeler seulement `Me.Close` (le `Form_Close` enregistre déjà) ; une seule
  série d'`UPDATE` (dump identique).
- Regrouper `meserrc`/`meserrt` et les deux blocs identiques de `Par_lostfocus` (Tag 33 et 38) en
  `ProposerCreation(txtbox, bTva)`.

### Commonalisation avec d'autres fichiers

- `Verif_Compte` (existence d'un compte) : la même requête `compte_cc = &1` est répétée dans
  `Moulinage`, `Calcsolde`, `Csolde`, `ClotureF`, `Facturergbl`, `ValidBR`, `ValidBR1`,
  `Fclientc`. Un `Utils.CompteExiste(sCompte)` commun (voir
  [Calcsolde](../../Utils/Calcsolde.class/architecture.md), [Csolde](../../Utils/Csolde.module/architecture.md)).
- `Veriftva` : même requête dans [CPrix](../../Utils/CPrix.module/architecture.md) (l.18),
  `Caisse` (l.1926), `Moulinage` (l.2084, 2810) : `Utils.TvaExiste(sCode)`.
- Le verrou `DocActif.Get_Lock`/`Free_Lock` autour d'une fenêtre modale est le même schéma que dans
  `Facture`, `commande1`, `Tresor` (voir [DocActif](../DocActif.class/architecture.md)).

### Réduction de portée

`mcdt`, `meserrc`, `meserrt`, `Verif_Compte` : aucun appelant externe (grep `Parametre\.`).
`Button2_Click`/`Button3_Click` sont des handlers nominaux (contrôles `Button2`/`Button3`) mais
inactifs (groupe `Btn`) : leur nom et leur portée sont conservés.

### Séparation traitement / GUI

- `LireParametres() As Result`, `EnregistrerParametres(…)`, `EnregistrerConsignes(…)`,
  `EnregistrerTipp(sReg)`, `EnregistrerArtTipp(aLignes)` : SQL sans contrôle.
- `JournalTypeAttendu(hCtl) As String` (table contrôle → type VE/TR/AC/OD) pour `jrnal_LostFocus`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer au schéma de référence les colonnes optionnelles (`conscli`, `consfou`, `nvign`, `css`,
  `tvass`, `arrete`, `Fiches_Societes.ident/caution/tipp`) et la table `Art_Tipp`, avec une
  migration `LauruxMaj`, au lieu des `ALTER TABLE` de `modfichier`.
- Sortir `conf` (configuration globale) de `Fiches_Parametres` vers une table dédiée : la ligne
  métier ne transporterait plus un blob lu à chaque `SELECT *`.
- Ajouter une clé `WHERE` explicite (`ind`) aux `UPDATE` de `Fiches_Parametres` et `cd_sc` à ceux de
  `Fiches_Societes`.
