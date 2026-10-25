# ACom — Architecture

> Source : `.src/Affichages/ACom.class`

## Vue d'ensemble

D'après le code, `ACom` est une **fenêtre modale de consultation du détail d'une commande
fournisseur** : en-tête (code et nom du fournisseur, numéro de commande, date, montant passés par
l'appelant) et lignes de la commande (`Fiches_Ligcom`) dans la `ColumnView` `Colrcp3` (ligne, code,
désignation, quantité, prix brut HT, remise, prix net HT). Elle est ouverte depuis la fiche article
(`Articles.Colcom_Activate`, liste des commandes fournisseurs contenant l'article, `Typed =
"CommandeF"`) avec `New Acom(numcom, fournisseur, date, montant)`.

Lecture seule ; aucun retour vers l'appelant. Les noms des contrôles (`Codecli`, `Nomcli`,
`Numfac`, `Totalfac`) sont hérités de [`AFacture`](../AFacture.class/architecture.md) dont le
`.form` a été copié (ratio de similarité 0,67, 49 lignes communes). Pas de `Utils.Observers(Me)`.

Nature : **mixte** (deux requêtes et affichage dans la même fonction).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `numbl` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `numbl` | numéro de la commande (nom hérité d'`AFacture`) |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-16 | Public | 1 | 9 | 0 | méthode spéciale |
| `DocCom` | 18-68 | Public | 6 | 48 | 0 | portée réductible ? |
| `Codecli_KeyPress` | 70-74 | Public | 6 | 3 | 0 | handler GUI |
| `Button3_Click` | 76-81 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new($num, $code, $date, $montant)`** [portée : nécessaire (constructeur)] [nature : GUI] :
  centre, remplit l'en-tête (le paramètre « nom » est commenté : le nom est relu en base) et appelle
  `DocCom`.
- **`DocCom()`** [portée : réductible] [nature : mixte] : 7 colonnes et leurs titres ; lit le
  fournisseur (`SELECT * FROM TabFour WHERE fo_code = &1`) et affiche `fo_nom` **sans test
  `Available`** ; lit les lignes (`SELECT * FROM TabLigcom WHERE numcom = &1 and four = &2`) et les
  parcourt par `Repeat … Until MoveNext` après un `If Not Error` qui ne teste rien (aucun `Try`
  avant) : sur un résultat vide, la lecture de `Rcli!lind` lève une erreur. Pour chaque ligne :
  clé `lind`, code si l'article existe (`Fiches_Art`), quantité formatée `Utils.CDec` **écrite en
  colonne 2 puis écrasée** par la désignation (la colonne 3 reçoit la quantité brute), prix et remise
  bruts tels que stockés (`decimal`, sans formatage). `Nlgf` (nombre de lignes) est recalculé à chaque
  tour puis une dernière fois. Affiche `Panel4`.
- **`Codecli_KeyPress()`** [handler] [nature : GUI] : Échap (testé deux fois sous deux noms,
  `Key.Esc` et `Key.Escape`) ou F2 → `Button3_Click`.
- **`Button3_Click()`** [handler] : vide la vue et ferme.

## État global utilisé

- `Utils.db.Exec`, `Utils.CDec` ; `Cbase.Table("TabFour")`, `("TabLigcom")`, `("TabArt")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer l'affectation morte de la colonne 2 (`Utils.CDec` écrasé), le premier
  `Nlgf.Text = …` dans la boucle, le `If Not Error` sans `Try`, le double test d'Échap et le
  `With Utils` inutile.

### Commonalisation avec d'autres fichiers

- [`AFacture.DocVentes`](../AFacture.class/architecture.md) et
  [`TriHistos.DocVentes`](../TriHistos.class/architecture.md) : même mise en page de `Colrcp3` (7
  colonnes, mêmes largeurs et titres) et même boucle de remplissage → module commun `DetailDocument`
  (`Colonnes(hVue)`, `LignesVente(…)`, `LignesCommande(…)`), voir TRIHISTOS-006.

### Réduction de portée

- `DocCom` → `Private` (vérifié : aucun appel externe).

### Séparation traitement / GUI

- `LignesCommande(sNum, sFour) As Result` et `NomFournisseur(sFour) As String` (requêtes) ;
  `DocCom` ne garde que l'affichage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à cet écran (lecture de `Fiches_Ligcom` par `numcom`/`four` ; vérifier l'existence
  d'un index composite dans `db_control.csv`).
