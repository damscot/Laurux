# Ecritures — Architecture

> Source : `.src/Compta/Utils/Ecritures.class`

## Vue d'ensemble

`Ecritures` est l'écran de **consultation descendante des écritures** (menu Comptabilité,
`Fmenu.Menu10_Click`, `Ecritures.Show`) en trois niveaux dans la même fenêtre :

1. **Écran 1 — soldes des comptes** (`Ecrit`) : comptes d'un type (`Bclient` C, `Bfournisseur` F,
   `Bgestion` G, `Bbilan` B) avec leur solde ;
2. **Écran 2 — extrait de compte** (`EcritGL`) : écritures validées du compte choisi, solde
   progressif, marque de lettrage ; navigation compte précédent/suivant (`Button2`/`Button4`) ;
3. **Écran 3 — détail d'une écriture** (`EcritJL`) : lignes non collectives de l'écriture, avec la
   clé d'intégrité mémorisée (`control`) et la clé recalculée (`Sha1Calc.CalcSha1`), et le bouton
   `Necrit` qui ouvre la modification dans [`Saisecrit`](../../Saisecrit.class/architecture.md) ou
   [`Tresor`](../../Tresor.class/architecture.md) (écriture de trésorerie), sauf si elle est clôturée.

`Button1` remonte d'un niveau ; `Button6` ferme ; `Button3` ouvre l'aide.

Nature globale : **mixte** (SQL dans les handlers, état de navigation dans des variables privées).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rResult` | var | Private |  | Result | 27 |
| `Tab` | var | Private |  | String | 28 |
| `Tab2` | var | Private |  | String | 29 |
| `type` | var | Private |  | String | 30 |
| `Modif` | var | Private |  | Integer | 31 |
| `Cloturee` | var | Private |  | Integer | 32 |
| `code` | var | Private |  | String | 33 |
| `Docu` | var | Private |  | String | 34 |
| `Tot` | var | Private |  | String | 35 |
| `son` | var | Private |  | Integer | 36 |
| `Cle` | var | Private |  | String | 37 |
| `Indx` | var | Private |  | String | 38 |
| `Collectif` | var | Private |  | String | 39 |
| `EcrGL` | var | Private |  | Integer | 40 |
| `EcrJL` | var | Private |  | Integer | 41 |
| `num` | var | Private |  | Integer | 42 |
| `tresr` | var | Private |  | Integer | 43 |
| `compte` | var | Private |  | String | 44 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 46-65 | Public | 1 | 17 | 0 | méthode spéciale |
| `type_Click` | 67-82 | Public | 3 | 14 | 0 | portée réductible ? |
| `Bclient_Click` | 84-92 | Public | 1 | 7 | 0 | handler GUI |
| `Bfournisseur_Click` | 94-102 | Public | 1 | 7 | 0 | handler GUI |
| `Bgestion_Click` | 104-112 | Public | 1 | 7 | 0 | handler GUI |
| `Bbilan_Click` | 114-122 | Public | 1 | 7 | 0 | handler GUI |
| `type_compte` | 124-131 | Public | 5 | 6 | 0 | portée réductible ? |
| `Button6_Click` | 133-137 | Public | 1 | 3 | 0 | handler GUI |
| `Ecrit_Click` | 139-219 | Public | 4 | 77 | 0 | handler GUI |
| `Label1_click` | 221-223 | Public | 1 | 2 | 0 | handler GUI |
| `EcritGL_Click` | 225-322 | Public | 8 | 92 | 0 | handler GUI |
| `EcritJL_click` | 324-336 | Public | 4 | 11 | 0 | handler GUI |
| `Button1_Click` | 338-363 | Public | 3 | 24 | 0 | handler GUI |
| `QuitteEcritjl` | 365-385 | Public | 7 | 19 | 0 | portée réductible ? |
| `Necrit_Click` | 390-436 | Public | 18 | 44 | 0 | handler GUI |
| `Button3_Click` | 438-442 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 444-453 | Public | 3 | 8 | 0 | handler GUI |
| `Button4_Click` | 455-464 | Public | 3 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Écran 1

- **`_New()`** [spéciale] [GUI]. Son, centrage, observateurs ; colonnes d'`Ecrit` ; `Bclient_Click()`.
- **`Bclient_Click()` / `Bfournisseur_Click()` / `Bgestion_Click()` / `Bbilan_Click()`** [handlers]
  [mixte]. Quatre copies : `type` = C/F/G/B puis
  `SELECT compte_cc, intitule_cc, solde FROM Fiches_Comptes where type_cc= '<type>' order by
  cast(compte_cc AS char)` — valeur **concaténée** (constante, pas d'injection possible) —, puis
  `type_Click()`.
- **`type_Click()`** [Public, appelée seulement en interne] [GUI]. Remplit `Ecrit` depuis `rResult`
  (membre). **Remet `type = "C"`** à chaque appel : après `Bfournisseur_Click` (etc.), `type` vaut
  `"C"`, ce qui fausse le rechargement de `QuitteEcritjl` (mort). Le nom ressemble à un handler mais
  aucun contrôle `type` n'existe.
- **`type_compte()`** [Public, **aucun appelant**] [GUI] — code mort (les `Type_compte()` trouvés par
  grep sont ceux de `Saisecrit` et `Tresor`).

### Écran 2

- **`Ecrit_Click()`** [handler] [mixte]. Colonnes d'`EcritGL` ; `code` = compte courant ;
  `SELECT * FROM Fiches_Mvt where compte= &1 and validee = &2 order by dte` (`validee = 1`) ;
  solde progressif tenu dans la chaîne membre `Tot` (`Val(.cpoint(tot))`) ; `*` si lettrée. `Compte`
  mémorise le compte pour le retour après modification. Appelle `Label1_click()` (vide) « pour
  éviter une attente ».
- **`Label1_click()`** [handler] [GUI]. Vide (contournement historique d'un rafraîchissement).
- **`Button2_Click()` / `Button4_Click()`** [handlers] [GUI]. Compte précédent / suivant par
  `Ecrit.MoveTo(Ecrit.Key ∓ 1)` (les clés sont les `rResult.Index` du chargement), puis
  `Ecrit_Click`.

### Écran 3

- **`EcritGL_Click()`** [handler] [mixte]. Colonnes d'`EcritJL` ; `Docu` = numéro d'écriture,
  `Cle` = clé de la ligne ; `SELECT * FROM Fiches_Mvt where numero = &1 and collectif is null order
  by compte` ; pour chaque ligne : `Try Bcol = rResult!collectif` lit **le mauvais `Result`**
  (`rResult` = liste des comptes, sans colonne `collectif`) → erreur systématique → `Bcol = False` :
  la branche `Else` (mémorisation `Indx`/`Collectif`) est morte, sans effet puisque la requête exclut
  déjà les collectifs. Colonnes 10/11 : `control` et `Sha1Calc.CalcSha1("Fiches_Mvt", numero, lind,
  False)` (recalcul sans mise à jour). Mémorise `cloturee` et `Tresr` de la **dernière** ligne ;
  total de l'écriture.
- **`EcritJL_click()`** [handler] [GUI]. `num` = numéro ; affiche `Necrit` ou message « écriture
  clôturée ».
- **`Necrit_Click()`** [handler] [mixte] (CC 18). Si non clôturée : `New Saisecrit(num, Me.Parent,
  True)` ou `New Tresor(num)` en modal (`Try`) ; puis `Ecritures.Show` (auto-instance), recharge les
  trois niveaux et repositionne sur le compte (`Compte`) et la ligne (`Cle`) ; `Modif = 1`. Sinon
  `Message.Delete(…)` (boîte de dialogue « suppression » utilisée pour un simple avertissement).
- **`Button1_Click()`** [handler] [GUI]. Retour au niveau précédent (masquage des grilles et
  boutons).
- **`QuitteEcritjl()`** [Public, **aucun appelant**] [GUI] — code mort.
- **`Button3_Click()`** [handler] [GUI]. `Doc.Open("Ecritures")`. **`Button6_Click()`** : ferme.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Aff`, `Utils.Observers`, `Start.Son`, `Start.Musique`.
- `Sha1Calc.CalcSha1`, `Saisecrit`, `Tresor`, `Doc`.
- Nombreuses variables d'état privées (`rResult`, `Tab`, `Tab2`, `type`, `Modif`, `Cloturee`, `code`,
  `Docu`, `Tot`, `Cle`, `Indx`, `Collectif`, `EcrGL`, `EcrJL`, `num`, `tresr`, `compte`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Bclient/Bfournisseur/Bgestion/Bbilan_Click` → helper privé `ChargeComptes(sType)` avec paramètre
  `&1` (SQL équivalent ; le texte de la requête change, résultat identique).
- Supprimer `type_compte`, `QuitteEcritjl` (morts), la branche `Bcol` et les variables `Indx`,
  `Collectif` (morts), `Tab`/`Tab2` (constantes).
- Configuration des colonnes (`EcritGL`, `EcritJL`) dans deux fonctions privées appelées une fois.
- `Tot` en `Float` formaté à l'affichage.

### Commonalisation avec d'autres fichiers

- Affichage d'un extrait de compte : [`Listextcpt`](../Listextcpt.class/architecture.md) fournit déjà
  la requête d'extrait multi-exercices ; l'écran 2 ne lit que `Fiches_Mvt` (exercice courant).
- `Sha1Calc.CalcSha1("Fiches_Mvt", …)` avec nom de table en dur : même constat que `EcrAuto`,
  `Tresor`, `Saisecrit`, `Moulinage` → `Cbase.Table("TabMvt")`.

### Réduction de portée

- `type_Click` → `Private` (appelée seulement par les quatre handlers ; aucun contrôle `type` : ce
  n'est pas un handler). `type_compte`, `QuitteEcritjl` → suppression.

### Séparation traitement / GUI

- `ComptesDuType(sType) As Result`, `ExtraitCompte(code) As Result`, `LignesEcriture(num) As Result`
  privés ; les handlers ne gardent que le remplissage des grilles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le recalcul de la clé `Sha1Calc` ligne par ligne à l'affichage relit les lignes précédentes de la
  chaîne : coûteux sur les longues écritures ; stocker la clé précédente (`prev_control`, voir
  Sha1Calc) simplifierait la vérification.
- Index `Fiches_Mvt(compte, validee, dte)` et `Fiches_Mvt(numero)` pour les écrans 2 et 3.
