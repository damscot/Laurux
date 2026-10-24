# Fmontant — Architecture

> Source : `.src/Compta/Utils/Fmontant.class` · Formulaire : `.src/Compta/Utils/Fmontant.form`

## Vue d'ensemble

Écran **« Recherche d'une somme »** (menu Compta « Recherche d'un montant », `Fmenu.Menu40_Click`,
et bouton `somme` de `SaiReg`). Il cherche des écritures de l'exercice en cours (`Fiches_Mvt`
jointe à `Fiches_Comptes`) par **montant** (début du débit ou du crédit), par **libellé** ou par
**numéro de document** (début de chaîne), filtrées par type de compte. Les résultats s'affichent
dans la `ColumnView` `Somme` ; un clic contrôle que l'écriture n'est pas clôturée et le bouton
« Voir/modifier écriture » ouvre `Saisecrit` (ou `Tresor` pour une écriture de trésorerie), puis
recalcule **tous** les soldes (`Csolde.Recalc_solde`) et relance la recherche.

Nature : **mixte** ; la construction du filtre SQL et la requête sont dans `Button2_Click`
(CC 41), entremêlées avec les contrôles de saisie.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 28 |
| `rResult` | var | Private |  | Result | 29 |
| `Tcpt` | var | Private |  | Result | 30 |
| `Cloturee` | var | Private |  | Integer | 31 |
| `libeldoc` | var | Private |  | String | 32 |
| `tresr` | var | Private |  | Boolean | 33 |
<!-- /AUTO:declarations -->

Contrôles du `.form` : `Mnt` et `Libelle` (TextBox, groupe `Montant`), `Cb1` (CheckBox « D'un
montant »), `Cb2`/`Cb3` (RadioButton « D'un libellé » / « D'un document »), `Bclient`,
`Bfournisseur`, `Bgestion`, `Bbilan`, `Btous` (RadioButton du cadre « Type de comptes »),
`CompteCol` (RadioButton seul dans son conteneur : une fois coché, il ne peut plus être décoché),
`Somme` (ColumnView), `Necrit`, `Button2` Chercher, `Button3` Aide, `Button6` Quitter.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-64 | Public | 1 | 28 | 0 | méthode spéciale |
| `montant_GotFocus` | 69-75 | Public | 1 | 5 | 0 | handler GUI |
| `Button6_Click` | 77-81 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 83-148 | Public | 41 | 61 | 0 | handler GUI |
| `affichage` | 150-166 | Public | 1 | 14 | 0 | portée réductible ? |
| `Somme_Click` | 168-186 | Public | 4 | 16 | 0 | handler GUI |
| `Necrit_Click` | 191-217 | Public | 6 | 24 | 0 | handler GUI |
| `Button3_Click` | 219-223 | Public | 1 | 3 | 0 | handler GUI |
| `Cb2_Click` | 225-236 | Public | 1 | 4 | 0 | handler GUI |
| `Cb3_Click` | 238-249 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [constructeur] [GUI] : observateurs, son, centrage, 9 colonnes de `Somme` (la
  9ᵉ, `tresorerie`, sans titre ni largeur), focus sur `Mnt`.
- **`montant_GotFocus()`** [handler du groupe `Montant`] [GUI] : `Utils.SetEditColor(Me, Last)`.
- **`Button6_Click()`** [handler] : ferme.
- **`Button2_Click()`** (CC 41) [handler] [mixte ; partie extractible : construction du filtre et
  requête] :
  - Contrôles : au moins un critère ; montant saisi si `Cb1` ; libellé saisi si `Cb2`/`Cb3`.
  - Filtre `req` : `coll = True`/`False` selon `CompteCol`, **remplacé** (`=`) par
    `validee = 1 and type_cc = 'C'|'G'|'B'` pour Clients, Gestion, Bilan, mais **complété** (`&=`)
    pour Fournisseurs ; `Btous` garde le seul filtre `coll`. Le filtre « compte collectif » n'est
    donc appliqué qu'aux fournisseurs et à « Tous » (anomalie A02).
  - Requêtes (**valeurs concaténées**, sans `&N`) sur `Fiches_Mvt LEFT JOIN Fiches_Comptes` :
    `montantd like '<m>%' or montantc like '<m>%'` (`Utils.PointBase(Mnt.Text)`), `<libelle|numdoc>
    like '<texte>%'`, ou les deux. Une apostrophe dans le libellé provoque une erreur SQL ; injection
    possible (anomalie A01). Pas de tri pour la recherche par montant seul.
  - `rResult` est une **variable d'instance** : si la saisie est refusée, le résultat précédent
    (déjà parcouru) est réutilisé et « Traitement terminé ! » s'affiche après l'avertissement
    (anomalie A03).
  - Affichage par `affichage()` ligne à ligne ; `Necrit` masqué.
- **`affichage()`** [portée : réductible — aucun appelant externe (grep)] [GUI] : ajoute une ligne
  à `Somme` (clé `Index & compte`), date par `Utils.Cdate_Aff`, montants `0.00`.
- **`Somme_Click()`** [handler] [mixte] : `SELECT * FROM Fiches_Mvt WHERE numero = Somme.Item[4]`
  (sans test `Available`) ; si `cloturee`, son + `Message.Error`, sinon affiche `Necrit`. ⚠️ Lit
  `Somme.Item` (curseur interne, positionné sur la dernière ligne ajoutée) et non `Somme.Current`
  (ligne cliquée) : le contrôle de clôture pourrait porter sur une autre écriture (à confirmer à
  l'exécution, anomalie A04).
- **`Necrit_Click()`** [handler] [mixte] : selon `Somme.Current[8]` (trésorerie), ouvre
  `New Saisecrit(numero, Me.Parent, True)` ou `New Tresor(numero)` en modal ; puis
  `Csolde.Recalc_solde()` (recalcul de **tous** les comptes) et relance `Button2_Click`.
- **`Button3_Click()`** [handler] : `Doc.Open("Montant")`.
- **`Cb2_Click()` / `Cb3_Click()`** [handlers] [GUI] : libellé du champ et colonne recherchée
  (`libelle` ou `numdoc`) ; anciens tests commentés.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.Observers`, `Utils.SetEditColor`, `Utils.PointBase`,
  `Utils.Cdate_Aff`, `Utils.db` ; `Csolde.Recalc_solde` ; formulaires `Saisecrit`, `Tresor`.
- Tables en dur : `Fiches_Mvt`, `Fiches_Comptes` (sans `Cbase.Table`).
- Variables d'instance : `rResult` (résultat partagé entre `Button2_Click` et `affichage`),
  `Tcpt` (inutilisée), `Cloturee`, `libeldoc`, `tresr`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Isoler la construction du filtre de type de compte (`FiltreType() As String`) et de la requête
  (`Recherche(sMontant, sTexte, sColonne, sFiltre) As Result`) ; reproduire exactement le
  comportement `=`/`&=` actuel tant que A02 n'est pas validée.
- Remplacer l'enchaînement de `If` imbriqués de contrôle de saisie par une fonction
  `ControleSaisie() As Boolean` qui renvoie `False` après le message.
- `rResult` en variable locale passée à `affichage(r)` (le comportement de A03 doit alors être
  reproduit tant qu'elle n'est pas corrigée : à traiter avec A03).
- Supprimer `Tcpt` (inutilisée) et le code commenté de `Cb2_Click`/`Cb3_Click`.

### Commonalisation avec d'autres fichiers

- `Necrit_Click` (ouverture `Saisecrit`/`Tresor` selon `tresorerie`, puis recalcul des soldes)
  existe sous des formes proches dans les écrans de consultation d'écritures (`Extrait`,
  `TriEcritures`) : helper commun `Ecriture.Ouvrir(numero, tresorerie)` à étudier au lot Compta.
- `Csolde.Recalc_solde()` après modification d'**une** écriture : `Csolde.Solde_caisse(compte)`
  sur les comptes touchés suffirait (voir [Csolde](../../../Utils/Csolde.module/architecture.md)) ;
  changement de SQL, dump identique attendu.
- Tables par `Cbase.Table("TabMvt")` / `Cbase.Table("TabComptes")`.

### Réduction de portée

- `affichage` → `Private` (aucun appelant externe, grep). Les handlers restent `Public`.

### Séparation traitement / GUI

- `Button2_Click` : la requête devient une fonction sans accès aux contrôles, recevant montant,
  texte, colonne et filtre ; le handler garde messages et focus.
- `Somme_Click` : `EstCloturee(numero) As Boolean` séparée du son et du message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La recherche « commence par » sur `montantd`/`montantc` (`DECIMAL`) force une conversion en
  chaîne et un parcours complet ; une colonne calculée indexée (montant en texte) ou une recherche
  par intervalle numérique serait plus efficace.
