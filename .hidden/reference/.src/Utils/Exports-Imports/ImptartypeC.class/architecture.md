# ImptartypeC — Architecture

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Form : `ImptartypeC.form`

## Vue d'ensemble

Fenêtre d'**import des coefficients de tarif par type de client** (`Fiches_TarTypcli`). L'utilisateur
choisit un type client (`Coltype`, rempli depuis `Fiches_Typec`) et un fichier `;` ; pour chaque
ligne, la colonne 0 donne le code article et la colonne **12** le coefficient. Le couple
(type, article) est inséré ou mis à jour (upsert manuel).

Le format source (13 colonnes minimum, coefficient en 13ᵉ position) ne correspond pas à
l'export [`Expart`](../Expart.class/architecture.md) (où la colonne 12 est « Tx conv ») ; origine du
fichier à confirmer.

Ouverte uniquement par `Prgm` (programme `ImptartypeC`, `ShowModal`). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 5-18 | Public | 5 | 11 | 0 | handler GUI |
| `Svs_Click` | 20-28 | Public | 2 | 7 | 0 | handler GUI |
| `Button1_Click` | 30-34 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 36-69 | Public | 6 | 31 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`form_Open()`** [handler] [mixte]. `Try SELECT * FROM Fiches_Typec` (en dur) ; ajoute
  `code & " -  " & libelle` à `Coltype`.
- **`Svs_Click()`** [handler] [GUI]. `Dialog.OpenFile` → `Sauves.Text` (identique à
  `Impclient.Svs_Click`).
- **`Button1_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte]. `Typec = Left$(Coltype.Text, 2)` (suppose un code type de
  2 caractères). Pour chaque ligne : `SELECT * FROM Fiches_TarTypcli WHERE type = &1 AND cart = &2` ;
  absent → `INSERT (type, cart, coef)` ; présent → `UPdate … SET coef = &3`. Le coefficient est
  converti par `Val(Utils.cpoint(Tcoeff))` (`Null` si non numérique). Musique (sans `Music.Load` ni
  `Start.Son`), `Message.Warning`. Fichier jamais fermé. `Tlig` est alloué (`New String[15]`) puis
  immédiatement remplacé par `Split`.
  Partie extractible : `ImporterCoefficients(sChemin, sTypec) As Integer`.

## État global utilisé

- `Utils.db`, `Utils.cpoint`.

## Anomalies relevées

- Ligne de moins de 13 colonnes : `Tlig[12]` hors bornes → erreur d'exécution, import partiel.
- Aucun type sélectionné : `Typec = ""`, les coefficients sont importés pour un type vide.
- Coefficient non numérique → `coef` = `NULL`.
- Fichier jamais fermé.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Dim Tlig As String[]` sans allocation ; tables via `Cbase.Table("TabTypec")` et la clé
  correspondant à `Fiches_TarTypcli` (à vérifier dans `Cbase.module`).

### Commonalisation avec d'autres fichiers

- Upsert « SELECT puis INSERT ou UPDATE » identique à celui de
  [`Gestion/Tables/TarTypeCli`](../../../Gestion/Tables/TarTypeCli.class/architecture.md) (même table,
  à confirmer lors de la documentation de ce fichier) : un helper `MajCoefTypeClient(type, cart,
  coef)` partagé.
- Remplissage d'une ComboBox « code - libellé » depuis `Fiches_Typec` : motif répété dans plusieurs
  écrans clients ; candidat à un helper `RemplirTypesClient(hCombo)`.
- Socle commun d'import/export : voir [`Impclient`](../Impclient.class/architecture.md).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ImporterCoefficients(sChemin As String, sTypec As String) As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une clé primaire `(type, cart)` permettrait `INSERT … ON DUPLICATE KEY UPDATE` / `INSERT OR
  REPLACE` (différents selon le SGBD) au lieu de deux requêtes par ligne.
