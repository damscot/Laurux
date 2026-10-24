# Trecarts — Architecture

> Source : `.src/Compta/Trecarts.class`

## Vue d'ensemble

`Trecarts` est le **traitement automatique des écarts de règlement** : pour tous les comptes
clients (`type_cc = 'C'`) ou fournisseurs (`'F'`), il recherche les lots d'écritures non lettrés
(`Fiches_Mvt.lettree = 0`, regroupés par `numlot`) dont le solde est non nul mais inférieur ou égal
à un seuil saisi (`montant`, initialisé avec `Fiches_Parametres.ecart`). Pour chacun, il génère une
écriture d'OD qui solde le lot :

1. une ligne sur le compte tiers (débit ou crédit de l'écart) ;
2. une contrepartie sur le compte de régularisation `cptrplus` (produit, 758) ou `cptrmoins`
   (charge, 658) lus dans `Fiches_Parametres` ;
3. une ligne sur le **collectif** du tiers (`coll_cc`, ligne marquée `collectif = 1`) ;
4. le **lettrage** de toutes les lignes du lot sous un nouveau numéro `"E" & Right$(numlot, 9)` ;
5. la mise à jour des soldes (`Fiches_Comptes.solde`) des comptes touchés, du numéro d'écriture
   (`Fiches_Parametres.numecriture`) et du chaînage d'inaltérabilité (`Sha1Calc.CalcSha1`).

Les écritures sont créées validées (`validee = 1`), au journal d'OD `jrnod`, datées du jour
(`New LDate`), sans numéro de document. Chaque lot est traité sous `LOCK TABLES` (MySQL ; neutralisé
sous SQLite par `DB_Connection.Exec`).

Ouverture : `Fmenu.class:1302` (`Trecarts.Show`, auto-instance). Contrôles : `Bclient`,
`Bfournisseur` (radio), `Montant` (seuil), `Button2` (Btn tag 2, lancer), `Button1` (Btn tag 1,
aide), `Button3` (Btn tag 3, quitter).

Nature globale : **traitement de masse (calcul + SQL)** entièrement logé dans le handler
`Button2_Click` (CC 24, 150 lignes).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TT` | var | Private |  | Float | 28 |
| `TD` | var | Private |  | String | 29 |
| `TC` | var | Private |  | String | 30 |
| `type` | var | Private |  | String | 31 |
| `Tab2` | var | Private |  | String | 32 |
| `Compt` | var | Private |  | String | 33 |
| `b` | var | Private |  | Integer | 34 |
| `son` | var | Private |  | Integer | 35 |
<!-- /AUTO:declarations -->

- `TT`, `TD`, `TC` : seulement remis à zéro par `clear()`, jamais lus → inutiles. `TD`/`TC` sont
  des `String` affectés à `0`.
- `type`, `Tab2`, `Compt`, `b` : état de travail de `Button2_Click` stocké en membres ; ils peuvent
  devenir des variables locales.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-48 | Public | 1 | 8 | 0 | méthode spéciale |
| `Ecarts_keypress` | 50-74 | Public | 7 | 22 | 0 | portée réductible ? |
| `Btn_Click` | 76-90 | Public | 4 | 10 | 0 | handler GUI |
| `clear` | 92-98 | Public | 1 | 5 | 0 | portée réductible ? |
| `Montant_GotFocus` | 100-104 | Public | 1 | 3 | 0 | handler GUI |
| `Montant_LostFocus` | 106-115 | Public | 4 | 8 | 0 | handler GUI |
| `Montant_KeyPress` | 117-125 | Public | 7 | 7 | 0 | handler GUI |
| `Button2_Click` | 127-292 | Public | 24 | 150 | 0 | portée réductible ? |
| `Button1_Click` | 294-298 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. Observateurs de replay, son, centrage ;
  `SELECT ecart FROM Fiches_Parametres` (nom en dur, **sans test `Available`**) et affiche le seuil au
  format `0.00`.
- **`Ecarts_keypress()`** [portée : code mort] [nature : GUI]. Contrôle de la saisie du seuil sur
  Entrée/Retour/Tab et F1 (aide). **Aucun contrôle ni groupe `Ecarts`** n'existe dans
  `Trecarts.form` : ce handler n'est jamais déclenché (vérifié dans le `.form`).
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 aide, 2 traitement, 3 fermeture.
- **`clear()`** [portée : code mort] : remise à zéro de `TT`/`TD`/`TC`, jamais appelée.
- **`Montant_GotFocus()` / `Montant_LostFocus()` / `Montant_KeyPress()`** [handlers] [nature : GUI].
  Sélection du texte ; reformatage `0.00` avec avertissement en cas d'erreur ; filtrage des touches
  (chiffres, `,`, `.`, touches d'édition).
- **`Button2_Click()`** [handler] (CC 24) [nature : mixte, traitement extractible].
  - GUI : lecture de `Bclient`, contrôle du seuil (`Val(...) = Null`), curseur d'attente, message
    final « Traitement terminé ! n écriture(s) générée(s) ».
  - SQL émis (tables en dur : `Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Mvt`, `Fiches_MvtM` dans
    le `LOCK`) :
    - `SELECT * FROM Fiches_Parametres` (journal `jrnod`, `cptrplus`, `cptrmoins`) ;
    - `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 order by cast(compte_cc AS char)` ;
    - par compte : `SELECT * FROM Fiches_Mvt WHERE compte = &1 and lettree = 0 order by numlot` ;
    - par ligne : `SELECT … WHERE numlot = &1 and lettree = 0 and compte = &3` (somme du lot) ;
    - si `0 < |écart| ≤ seuil` : `LOCK TABLES …`, `SELECT numecriture`, 3 `INSERT INTO Fiches_Mvt`
      (tiers, régularisation, collectif), 3 couples `SELECT`/`UPDATE Fiches_Comptes SET solde`,
      un `SELECT` de relecture du compte pour son collectif, une boucle d'`UPdate … SET numlot,
      lettree = 1` **identique à chaque itération** (un seul `UPDATE` suffirait),
      `Sha1Calc.CalcSha1("Fiches_Mvt", numecr)`, `UPDATE Fiches_Parametres SET numecriture`,
      `UNLOCK TABLES`.
  - Défauts relevés :
    - **solde des comptes de régularisation mis à jour avec le mauvais signe** : la ligne
      insérée porte `montantd = Cred`, `montantc = Deb`, mais le solde reçoit `+ Deb - Cred`
      (l. 241 et 251) ;
    - le compteur `B` n'est pas incrémenté pour la ligne `cptrmoins` (message final faux) ;
    - `numdoc` n'est jamais affecté (chaîne vide) ; la date est celle du jour sans contrôle
      d'exercice ni de clôture ;
    - si le compte n'a pas de collectif, une ligne `collectif = 1` est insérée sur le compte `""`
      (à confirmer) ;
    - pas de `Catch` : une erreur au milieu d'un lot laisse les tables verrouillées (MySQL) et le lot
      à moitié écrit ;
    - un même `numlot` est recalculé pour chacune de ses lignes (requête redondante, sans effet
      après le premier lettrage).
- **`Button1_Click()`** [handler] : aide `Doc.Open("Genecart")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.Observers`, `Utils.db`, `Utils.cpoint`.
- `LDate` (date du jour, `.G`), `Sha1Calc.CalcSha1`.
- Tables : `Fiches_Parametres` (`ecart`, `jrnod`, `cptrplus`, `cptrmoins`, `numecriture`),
  `Fiches_Comptes` (`type_cc`, `compte_cc`, `intitule_cc`, `coll_cc`, `solde`), `Fiches_Mvt`
  (lecture, insertion, lettrage), `Fiches_MvtM` (verrou seulement, utilisé par `Sha1Calc`).
  Seul `Fiches_Mvt` (exercice courant) est traité : pas de `Mvt1-5`, ce qui est cohérent avec un
  traitement sur l'exercice ouvert.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire le traitement dans `Private Function Genere_Ecarts(type As String, seuil As Float) As
  Integer` (renvoie le nombre de lignes), sans accès aux contrôles.
- Factoriser les 3 `INSERT` quasi identiques (`Private Sub Insere_Ligne(...)`) et les 4 séquences
  « lire le solde / ajouter / réécrire » (`Private Sub Maj_Solde(cpt, delta)`), en conservant
  exactement les mêmes requêtes (y compris le signe actuel, voir anomalie A01).
- Remplacer la boucle de lettrage par un seul `UPdate` (SQL modifié, dump identique) et réutiliser
  `coll_cc` déjà lu dans `cptResult` au lieu de relire le compte (SQL modifié, dump identique).
- Supprimer `Ecarts_keypress`, `clear()`, `TT`/`TD`/`TC` et les lignes commentées.

### Commonalisation avec d'autres fichiers

- `Maj_Solde(cpt, delta)` : même séquence `SELECT solde` puis `UPDATE … SET solde` dans
  [`Tresor`](../Tresor.class/architecture.md) (`Enrg_Ecr`, `Ecrit3`) et [`Saisecrit`](../Saisecrit.class/architecture.md) :
  candidat à un helper commun (module comptable) en phase 3, à rapprocher de
  [`Calcsolde`](../../Utils/Calcsolde.class/architecture.md).
- Réservation du numéro d'écriture sous verrou (`LOCK`, `SELECT numecriture`, `UPDATE`) : même besoin
  dans `Tresor.QuitteDate` (sans verrou) → helper `ProchainNumeroEcriture()` commun, à rapprocher de
  `DB_Connection.LockIncrement` ([DB_Connection](../../Utils/DB_Connection.class/architecture.md)).
- Noms de tables via `Cbase.Table` (`TabComptes`, `TabParam`, `TabMvt`, `TabMvtM`), y compris dans la
  chaîne `LOCK TABLES`.

### Réduction de portée

- `Ecarts_keypress` et `clear` sont signalés « réductibles » par `deps.py` : ce sont en fait du code
  mort (suppression). Les autres méthodes sont des handlers liés au `.form` et restent `Public`.

### Séparation traitement / GUI

- `Button2_Click` garde : lecture de `Bclient`/`Montant`, contrôle du seuil, curseur, message final.
  Tout le reste passe dans `Genere_Ecarts` (même ordre des requêtes, pour un diff `Exec_SQL` vide).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un index `(compte, lettree, numlot)` sur `Fiches_Mvt` accélérerait les deux requêtes par compte
  (à vérifier dans `db_control.csv`).
- Le solde dénormalisé `Fiches_Comptes.solde` impose des mises à jour incrémentales fragiles (cf.
  anomalie de signe) ; un solde calculé (vue) supprimerait cette classe de défauts.
