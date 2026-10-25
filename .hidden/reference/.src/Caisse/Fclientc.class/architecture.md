# Fclientc — Architecture

> Source : `.src/Caisse/Fclientc.class` (+ `Fclientc.form`)

## Vue d'ensemble

`Fclientc` paramètre le **compte client caisse** : le client (`Fiches_Cli.cli_code`) auquel sont
rattachées les ventes de caisse lors du moulinage. La donnée tient dans une table d'une seule ligne
`Fiches_ClientCaisse (lInd, code, nom)` (clé `Cbase` `TabCliCaisse`, non utilisée ici). Elle est lue
par `Moulinage` (`Moulinage.class:1528`, client des écritures générées), `BordereauxC`
(`BordereauxC.class:242`, compte et libellé du bordereau), `Cmenu.Button1_Click`
(`Cmenu.class:128`, contrôle de présence avant l'ouverture de la caisse) et `LauruxMaj`.

Ouverture : Fmenu › Constantes › « Compte client caisse » (`Fmenu.Menu209_Click`,
`Fclientc.ShowModal()`, auto-instance).

L'écran comporte deux zones (`code`, `intitule`), un bouton de recherche (`Button4`) qui affiche la
liste de **tous** les clients (`Client`, ColumnView), et les boutons Enregistrer, Supprimer, Quitter,
Aide. L'en-tête de fichier est recopié de `FClient` (« Fclient.class »).

Nature : **mixte**, SQL dans les handlers, noms de tables en dur.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `son` | var | Private |  | Integer | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-43 | Public | 1 | 11 | 0 | méthode spéciale |
| `Form_Open` | 45-56 | Public | 2 | 9 | 0 | handler GUI |
| `Refresh` | 58-64 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 66-73 | Public | 1 | 4 | 0 | portée réductible ? |
| `Cleanchamps` | 75-80 | Public | 1 | 4 | 0 | portée réductible ? |
| `Button1_Click` | 82-97 | Public | 2 | 13 | 0 | handler GUI |
| `Button3_Click` | 99-113 | Public | 4 | 13 | 0 | handler GUI |
| `Button4_Click` | 115-143 | Public | 5 | 26 | 0 | handler GUI |
| `Client_Click` | 145-153 | Public | 1 | 7 | 0 | handler GUI |
| `Client_KeyPress` | 158-172 | Public | 5 | 12 | 0 | handler GUI |
| `Compteman` | 174-187 | Public | 3 | 11 | 0 | portée réductible ? |
| `Button2_Click` | 189-193 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 198-202 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [spéciale] [GUI] : `Music.Load(Start.Musique)`, centrage, 2 colonnes de `Client`.
  **Pas d'appel à `Utils.Observers(Me)`** : l'écran n'est pas journalisé, donc pas rejouable
  (FCLIENTC-A03).
- **`Form_Open()`** [handler] [mixte] : `SELECT * FROM Fiches_ClientCaisse` ; si une ligne existe,
  recopie `code`/`nom` dans les zones. Ne vide pas les zones sinon.
- **`Refresh()`** [portée : à conserver `Public`] [GUI] : vide `Client` et rappelle `Form_Open()`.
  Masque la méthode `Refresh` héritée de `Control` : ne pas la passer en `Private`.
- **`Maj_Zones()`** : **code mort** (jamais appelée ; corps entièrement commenté dans un `With`).
- **`Cleanchamps()`** : **code mort** (jamais appelée).
- **`Compteman()`** : **code mort** (jamais appelée) ; contrôlait le code dans `Fiches_Comptes`
  (`compte_cc`), ce qui ne correspond plus à la donnée saisie (code client).
- **`Button1_Click()`** — Enregistrer [handler] [mixte] : `SELECT * FROM Fiches_ClientCaisse` ; si
  une ligne existe, `UPDATE Fiches_ClientCaisse SET code = &1, nom = &2` **sans `WHERE`** (toutes les
  lignes : cohérent avec une table d'une ligne), sinon `INSERT`. Joue le son **sans tester**
  `Start.Son` (FCLIENTC-A02), message, fermeture. Aucun contrôle d'existence du client.
- **`Button3_Click()`** — Supprimer [handler] [mixte] : confirmation (son si `son`), `DELETE FROM
  Fiches_ClientCaisse WHERE code = &1`, `Refresh()`. Comme `Form_Open` ne vide pas les zones quand
  la table est vide, l'écran **continue d'afficher le compte supprimé** (FCLIENTC-A01). Branche `Else`
  vide.
- **`Button4_Click()`** — recherche [handler] [mixte] : bascule la liste `Client` ; à l'affichage,
  `SELECT * FROM Fiches_Cli` **sans tri ni filtre** (ordre non garanti, tous les clients chargés),
  `Try Client.Add` (doublons ignorés). Partie extractible : `ListeClients() As Result`.
- **`Client_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] : recopie code
  et nom du client choisi, masque la liste, focus sur Enregistrer.
- **`Client_KeyPress()`** [handler] [GUI] : Entrée = sélection ; Échap/F2 = fermeture de la liste.
- **`Button2_Click()`** [handler] : ferme. **`Button5_Click()`** [handler] : aide
  `Doc.Open("Client_Caisse")` (`xdg-open`).
- `tvalist2` (ColumnView invisible, sans handler) : vestige ; `replay_missing` sans conséquence
  (contrôle jamais affiché).

## État global utilisé

- `Start.Son` (initialiseur `son`), `Start.Musique` (`Music.Load`, chargement global du son).
- Aucune variable de `Utils`/`Variables`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Noms de tables par `Cbase.Table("TabCliCaisse")`, `Cbase.Table("TabCli")` (texte SQL identique).
- `Tab` (variable d'instance réaffectée dans chaque handler) → plus nécessaire après l'usage de
  `Cbase`.

### Commonalisation avec d'autres fichiers

- **Lecture du compte client caisse** : `Moulinage`, `BordereauxC`, `Cmenu` et ce fichier font chacun
  `SELECT * FROM Fiches_ClientCaisse` → une fonction `CompteClientCaisse() As Result` (ou
  `As String` pour le code) dans ce fichier ou un module caisse (ex. `Dcaisses`), appelée par les quatre.
- **Paramètres de caisse à une ligne** : même schéma « une ligne lue / UPDATE ou INSERT » que
  `LibelTicket`/`LibelAvoirs` (lot Caisse) → helper commun « table de paramètre unique ».
- **Liste de clients** : la recherche `Button4_Click` duplique en plus pauvre la sélection de
  comptes clients de `TriCpt` (lot Affichages, à confirmer) ; à remplacer par l'écran de sélection standard après
  validation (changement visible, hors rework autonome).

### Réduction de portée

- Aucune réduction utile : `Maj_Zones`, `Cleanchamps`, `Compteman` sont supprimées (code mort),
  `Refresh` reste `Public`.

### Séparation traitement / GUI

- `EnregistreCompteCaisse(code, nom)` (SELECT + UPDATE/INSERT), `SupprimeCompteCaisse(code)`,
  `CompteClientCaisse()` : SQL sans contrôle, testables en gbtest sur base Docker.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table d'une ligne `Fiches_ClientCaisse` (avec `lInd tinyint` auto-incrément) : à remplacer par une
  colonne de `Fiches_Parametres` ou une clé de paramétrage par société ; si elle est conservée, une
  contrainte d'unicité éviterait plusieurs lignes (l'`UPDATE` sans `WHERE` les écraserait toutes).
- Clé étrangère `code` → `Fiches_Cli.cli_code`.
