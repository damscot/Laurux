# Ligcli — Architecture

> Source : `.src/Compta/Relances/Ligcli.class`

## Vue d'ensemble

`Ligcli` est un **formulaire embarqué** représentant **un client à relancer** dans l'écran
[`FEditrel`](../FEditrel.class/architecture.md) (`ScrollView1`). `FEditrel.affiche` crée une
instance par compte présent dans la table de travail `Fiches_relances` :
`New Ligcli(compte, i, Devises, ScrollView2, ScrollView1) As "lig"` — les quatre premiers arguments
vont à `_new`, le cinquième (`ScrollView1`) au constructeur hérité du formulaire (parent).

Une ligne affiche le code, le nom, le code postal, la ville et le solde du compte ; elle propose
le choix « lettre de relance » (`Radiolet` + numéro de lettre `Combolettre`) ou « relevé de
compte » (`RadioRel`), l'impression (`Checkimp`) ou l'envoi par courriel (`Checkmail`), et un bouton
d'édition individuelle (`Buttonedit`).

Elle expose des propriétés lues par `FEditrel` (sélection, traitement, numéro, nom, type de lettre,
solde) et lève les événements `Up`, `Down`, `Gotf` pour la navigation (handlers `lig_*` de
`FEditrel`). Quand elle reçoit le focus, `FEditrel` appelle `visext`, qui affiche l'extrait de compte
du client dans `ScrollView2` (lignes [`Ligext`](../Ligext.class/architecture.md)).

Nature globale : **mixte** ; `Buttonedit_Click` contient toute la génération PDF d'une lettre
(copie quasi conforme de `FEditrel.Impressionr` pour un seul client).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `selection` | property | Public |  | Boolean | 3 |
| `traitement` | property | Public |  | Boolean | 4 |
| `numero` | property | Public |  | Integer | 5 |
| `lib` | property | Public |  | String | 6 |
| `rellet` | property | Public |  | Boolean | 7 |
| `imp` | property | Public |  | Boolean | 8 |
| `numlet` | property | Public |  | Integer | 9 |
| `sold` | property | Public |  | Float | 10 |
| `Up` | event | Public |  |  | 11 |
| `Down` | event | Public |  |  | 12 |
| `Gotf` | event | Public |  |  | 13 |
| `$oobser` | var | Private |  | Observer | 14 |
| `$btraitement` | var | Private |  | Boolean | 15 |
| `$inumcli` | var | Private |  | Integer | 16 |
| `$lsld` | var | Private |  | Float | 17 |
| `$rescli` | var | Private |  | Result | 18 |
| `$scr` | var | Private |  | ScrollView | 19 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 21-82 | Public | 7 | 51 | 0 | méthode spéciale |
| `obs_MouseDown` | 85-89 | Public | 2 | 3 | 0 | handler GUI |
| `obs_keypress` | 92-102 | Public | 3 | 8 | 0 | handler GUI |
| `Checkselec_Click` | 104-114 | Public | 2 | 9 | 0 | handler GUI |
| `couleur` | 116-131 | Public | 1 | 14 | 0 | portée réductible ? |
| `activation` | 133-140 | Private | 1 | 6 | 0 |  |
| `visext` | 143-179 | Public | 5 | 31 | 0 | portée réductible ? |
| `Buttonedit_Click` | 181-343 | Public | 25 | 151 | 0 | handler GUI |
| `EnvMail` | 346-355 | Public | 1 | 7 | 0 | portée réductible ? |
| `selection_Read` | 357-361 | Private | 1 | 3 | 0 |  |
| `selection_Write` | 363-367 | Private | 1 | 3 | 0 |  |
| `traitement_Read` | 369-373 | Private | 1 | 3 | 0 |  |
| `traitement_Write` | 375-379 | Private | 1 | 3 | 0 |  |
| `numero_Read` | 381-385 | Private | 1 | 3 | 0 |  |
| `rellet_Read` | 387-395 | Private | 2 | 7 | 0 |  |
| `imp_Read` | 397-401 | Private | 1 | 3 | 0 |  |
| `numlet_Read` | 403-407 | Private | 1 | 3 | 0 |  |
| `numlet_Write` | 409-411 | Private | 1 | 2 | 0 |  |
| `sold_Read` | 413-417 | Private | 1 | 3 | 0 |  |
| `lib_Read` | 419-423 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et navigation

- **`_new(numcli, numtag, devises, Scr)`** [spéciale] [mixte]. Mémorise le client, le tag (rang) et le
  `ScrollView` des extraits ; coche `Checkimp` et `Radiolet`. Crée **13 observateurs** successifs
  `New Observer(contrôle) As "obs"` tous affectés à la même variable `$oobser` : seule la référence au
  dernier est conservée (que les 12 premiers restent actifs dépend de la gestion de vie des
  `Observer` en Gambas, à confirmer). Puis :
  `SELECT * FROM Fiches_Cli WHERE cli_code=&1` → libellés ;
  `SELECT solde FROM Fiches_Comptes WHERE compte_cc=&1` **sans test `Available`** (erreur si le client
  n'a pas de compte) → `solde`, `$lsld` ;
  `SELECT * FROM Fiches_Txt_Relances ORDER BY niveau` **sans test `Available`** → `Combolettre` ;
  `SELECT niveau FROM Fiches_relances WHERE compte=&1` → niveau maximal des écritures (un niveau
  `NULL` remet le maximum à 0 en cours de boucle) → `Combolettre.Text`. Le paramètre `devises`
  n'est pas utilisé.
- **`obs_MouseDown()`** [handler d'observateur] [GUI]. Clic gauche → `Raise Gotf(Me.Tag)`.
- **`obs_keypress()`** [handler d'observateur] [GUI]. Flèches haut/bas → `Raise Up/Down(Me.Tag)`.
- **`Checkselec_Click()`** [handler] [mixte]. Cochée → `activation(True)`. Décochée →
  `activation(False)`, `DELETE FROM Fiches_relances WHERE compte=&1` (toutes les écritures du client
  sortent des relances, sans confirmation ni retour possible avant une nouvelle génération), puis
  `visext`. Également déclenché par `FEditrel.Checktout_Click` via la propriété `selection`
  (si l'affectation lève `Click`, à confirmer) : décocher « Tout sélectionner » viderait alors la
  table de travail pour tous les clients.
- **`couleur(coul)`** [portée : nécessaire, appelée via `Variant` par `FEditrel`] [GUI]. Fond de 12
  contrôles.
- **`activation(value)`** [Private] [GUI]. Active/désactive panneaux, liste et bouton.
- **`visext()`** [portée : nécessaire, appelée via `Variant` par `FEditrel.lig_GotF`] [mixte].
  Supprime les lignes de `$scr` (boucle `Repeat` sur `Children`), construit
  `New Listextcpt(cli_code, -8 ans, +8 ans, "n", "dte asc")` (écritures non lettrées) et crée une
  `Ligext` par écriture. `Wait 0.01` final.

### Édition et envoi

- **`Buttonedit_Click()`** [handler] [mixte] (CC 25). Édition de la lettre du seul client courant :
  - en-tête société : `SELECT * FROM Fiches_Societes WHERE cd_sc = &1` (`Start.Societe`) **sans
    test `Available`**, 12 lignes de mentions (RCS, SIRET via `/Soc<XX>/Siret`, TVA, capital,
    NAF, téléphones, courriel, site, IBAN) ;
  - si `Checkselec` et `Checkimp` : `SELECT * FROM Fiches_relances WHERE compte = &1 order by dte` ;
    en-têtes `Creleve.Entete`/`Entete2`/`Level5` ; texte du niveau choisi (`Fiches_Txt_Relances`,
    `Val(Combolettre.Current.Text)`) ou « Relevé de compte » ; une ligne `Level7` par écriture avec
    **`UPdate Fiches_Mvt SET relance = &1 WHERE compte = &2 and numdoc = &3`** (niveau = celui de la
    première ligne, `Niv`, et non le numéro de lettre choisi) ; saut de page à `PosY >= 273` ;
  - solde de la sélection, puis `SELECT solde, cli_email FROM Fiches_Comptes left join Fiches_Cli
    on cli_code = &1 WHERE compte_cc=&1` ; un solde négatif est imprimé **sans changement de signe**
    dans la colonne débit (`FEditrel` imprime `-solde`) ;
  - `pdf.Output(~/tmp/Relances.pdf)` puis `Visualiseur.Prog` ou, si `Checkmail`,
    `EnvMail.Envoi2(MailC, "Votre compte", "", fichier)` ;
  - `$btraitement = True` (la lettre ne sera pas rééditée par l'édition groupée).
  Variables inutilisées : `Filetxt`, `Tab4` hormis l'UPDATE, `Mail` sert à l'en-tête ;
  `Shell "cd " & User.Home` est sans effet sur le processus.
- **`EnvMail()`** [portée : réductible, aucun appelant] [mixte] — **code mort**. Lit `cli_email`
  sans test `Available` et envoie `~/tmp/Relances.pdf`. Son nom masque la classe `EnvMail` dans le
  fichier ; un essai de compilation (`gbc3`) montre que `EnvMail.Envoi2` reste résolu vers le module
  `Gestion/Mails/EnvMail` (pas de récursion), mais l'homonymie est trompeuse.

### Propriétés

| Propriété | Accès | Effet |
|---|---|---|
| `selection` | R/W | `Checkselec.Value` (écriture : voir `Checkselec_Click`) |
| `traitement` | R/W | `$btraitement` (lettre déjà éditée individuellement) |
| `numero` | R | `$inumcli` (Integer : `cli_code` est `int(11)`) |
| `lib` | R | `nom.Text` (utilisé pour le tri par nom) |
| `rellet` | R | `Radiolet.Value` (lettre plutôt que relevé) |
| `imp` | R | `Checkimp.Value` |
| `numlet` | R/W | lecture `Val(Combolettre.Current.Text)` ; **écriture vide** (sans effet) |
| `sold` | R | `$lsld` (solde lu à la construction) |

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Aff` ; `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Siret"]`.
- `Creleve` (PDF), `Visualiseur.Prog`, `EnvMail.Envoi2`, `Listextcpt`, `LDate`.
- Fichier temporaire partagé `~/tmp/Relances.pdf` (même nom que `FEditrel.Impressionr`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Conserver les 13 observateurs dans un tableau privé `Observer[]` (comportement identique si les
  observateurs sont bien conservés aujourd'hui ; sinon c'est une correction : voir LIGCLI-A04).
- `Buttonedit_Click` (CC 25) : extraire `EnteteSociete()`, `ImprimeLettre(pdf, compte, txtniveau)`
  et `ImprimeSoldes(pdf, …)`.
- Supprimer `EnvMail()` (code mort), `Filetxt`, le `Shell "cd …"` et le paramètre `devises`
  (signature de `_new` : appelant `FEditrel.affiche` à mettre à jour dans le même commit).

### Commonalisation avec d'autres fichiers

- **Bloc en-tête société** (12 lignes `If rResult!xxx_sc Then …`) dupliqué dans
  [`FEditrel.Impressionr`](../FEditrel.class/architecture.md),
  [`FRelCompte.Releves`](../FRelCompte.class/architecture.md),
  [`FRelFacture.Releves`](../FRelFacture.class/architecture.md), `Gestion/Facturation/Facturergbl`
  et `Statistiques/RelvMo` : une méthode `Creleve.EnteteSociete()` (ou un helper de module)
  supprimerait 6 copies.
- **Corps de lettre** (`Level7` + UPDATE `relance` + saut de page + soldes) identique à
  `FEditrel.Impressionr` : fonction commune `ImprimeRelance(pdf, compte, rellet, numlet)` appelée
  par les deux fichiers.
- Lecture des textes `Fiches_Txt_Relances` : voir [`FRelance`](../FRelance.class/architecture.md).

### Réduction de portée

- `EnvMail` : à supprimer. `couleur` et `visext` restent `Public` (appelées via `Variant` par
  `FEditrel` : faux positif de `deps.py`).

### Séparation traitement / GUI

- `_new` : `ChargeClient(numcli)` (3 requêtes) séparée du remplissage des contrôles.
- `Checkselec_Click` : `RetireRelances(compte)` privé.
- `Buttonedit_Click` : construction du PDF et UPDATE `relance` séparés de la lecture des
  contrôles (`Radiolet`, `Combolettre`, `Checkmail`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Mise à jour du niveau de relance par `compte` + `numdoc` : plusieurs écritures d'un même
  document reçoivent le même niveau ; un lien direct par `lind` (déjà stocké dans `Fiches_relances`)
  serait plus précis, mais change le SQL et l'effet : à traiter avec un index sur `Fiches_Mvt.numdoc`.
- Table de travail `Fiches_relances` partagée entre utilisateurs (voir `Ligext`).
