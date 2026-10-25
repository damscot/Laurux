# Fondcaisse — Architecture

> Source : `.src/Caisse/Fondcaisse.class`

## Vue d'ensemble

`Fondcaisse` est l'écran de **saisie et de contrôle du fond de caisse** (espèces dans le tiroir)
de la caisse connectée (`/Soc<XX>/caisse/Ncai`). Il est ouvert par `New Fondcaisse` depuis
`Cmenu.Button10_Click` et `Caisse.button21_Click`. Il fonctionne selon deux modes, choisis par
`Fiches_Caisses.tkz` (bande Z tirée) :

| Mode | Condition | Affichage | Écriture |
|---|---|---|---|
| **Modification du fond initial** | `tkz = 1` (journée clôturée par le ticket Z) | `Box1` = `fndc` actuel | « OK » : `UPdate Fiches_Caisses SET fndc` (fond de la journée suivante) |
| **Contrôle du fond actuel** | sinon | fond initial (`fndc`), date d'ouverture (`dteov`), fond théorique | aucune, sauf correction du fond initial par double-clic sur `FDC_Ini` (`UPDATE fndc`) |

Le **fond théorique** = fond initial + règlements en espèces (`type = 'N'`) − rendus de monnaie
(`type = 'Q'`) des lignes de tickets non validés (`Fiches_LigTicketz`/`Fiches_EntTicketz`,
`statut = '0'`, `suppr <> 1`). Le fond réel peut être saisi directement ou par **détail des
coupures** (15 champs `Qte<valeur en centimes>`, montant calculé dans `Mon<…>`), avec un pavé
numérique et des boutons « Préc. »/« Suiv. ».

L'écran **n'écrit aucun mouvement ni ticket et ne clôture pas la journée** ; il modifie
seulement `Fiches_Caisses.fndc`, valeur reprise par le ticket Z de
[`Moulinage`](../Moulinage.class/architecture.md) (« Fond de caisse initial ») et réécrite par
lui en fin de journée. Il fait partie du cycle de caisse : **module complexe** (liste de
scénarios à valider).

**Position par rapport à `Csolde.Solde_caisse`** : aucune parenté. `Csolde.Solde_caisse` (et ses
copies `ClotureF.Calc_solde`, `Visreglements`, `TresorFac.Calc_solde`) recalcule le **solde
comptable** d'un compte à partir de `Fiches_Mvt` ; `Fondcaisse.Calc_FdcTheo` calcule le contenu
**physique** du tiroir à partir des tickets non validés. Sa vraie jumelle est la requête de
[`Moulinage`](../Moulinage.class/architecture.md) (ticket Z, [Moulinage.class:239](../../../../.src/Caisse/Moulinage.class#L239)),
identique au filtre `e.date = l.date` près ; le fond final du ticket Z est en revanche calculé à
partir des en-têtes (`mespeces` si `sespeces = 'N'`), pas des lignes `N`/`Q` (voir FONDCAISSE-A02).

Nature globale : **GUI** avec un calcul SQL (`Calc_FdcTheo`) et deux `UPDATE`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Qte` | var | Private |  | Textbox | 3 |
| `Prec` | var | Private |  | Textbox | 4 |
| `Suiv` | var | Private |  | Textbox | 5 |
| `Mon` | var | Private |  | TextBox | 6 |
| `Ncaisse` | var | Private |  | String | 7 |
| `$cai` | var | Private |  | String | 8 |
| `$vdr` | var | Private |  | String | 9 |
| `ModifFDC` | var | Private |  | Boolean | 10 |
| `Devises` | var | Private |  | String | 11 |
| `ch` | var | Private |  | Chainage | 12 |
| `ListQteBox` | var | Private |  | TextBox[] | 13 |
| `ListMonBox` | var | Private |  | TextBox[] | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-69 | Public | 6 | 50 | 0 | méthode spéciale |
| `Calc_FdcTheo` | 71-86 | Public | 5 | 13 | 0 | portée réductible ? |
| `Form_Open` | 88-106 | Public | 1 | 17 | 0 | handler GUI |
| `Form_Close` | 108-111 | Public | 1 | 2 | 0 | handler GUI |
| `SetObservers` | 114-126 | Public | 4 | 10 | 0 | portée réductible ? |
| `Obs_Enter` | 128-134 | Public | 1 | 4 | 0 | handler GUI |
| `Obs_Leave` | 136-142 | Public | 1 | 4 | 0 | handler GUI |
| `numpad_Click` | 144-154 | Public | 4 | 9 | 0 | handler GUI |
| `Raz_Click` | 156-166 | Public | 2 | 8 | 0 | handler GUI |
| `Button3_Click` | 168-193 | Public | 2 | 24 | 0 | handler GUI |
| `Box1_KeyPress` | 195-204 | Public | 5 | 8 | 0 | handler GUI |
| `ChkFDC` | 206-214 | Public | 10 | 7 | 0 | portée réductible ? |
| `TotalFDC` | 216-244 | Public | 4 | 25 | 0 | portée réductible ? |
| `Qte_KeyPress` | 246-277 | Public | 12 | 28 | 0 | handler GUI |
| `Qte_GotFocus` | 281-305 | Public | 5 | 21 | 0 | handler GUI |
| `Qte_LostFocus` | 307-311 | Public | 1 | 3 | 0 | handler GUI |
| `Box1_LostFocus` | 314-318 | Public | 2 | 3 | 0 | handler GUI |
| `Button1_Click` | 320-325 | Public | 2 | 4 | 0 | handler GUI |
| `Button2_Click` | 327-345 | Public | 4 | 16 | 0 | handler GUI |
| `PictureBox6_MouseDown` | 347-349 | Public | 1 | 2 | 0 | portée réductible ? |
| `btn_Enter` | 351-369 | Public | 8 | 17 | 0 | handler GUI |
| `P13_Leave` | 371-375 | Public | 1 | 3 | 0 | handler GUI |
| `Precedent_Click` | 377-381 | Public | 2 | 3 | 0 | handler GUI |
| `Suivant_Click` | 383-387 | Public | 2 | 3 | 0 | handler GUI |
| `FDC_Ini_DblClick` | 389-402 | Public | 3 | 12 | 0 | handler GUI |
| `FDC_Ini_Update` | 404-421 | Public | 2 | 16 | 0 | portée réductible ? |
| `FDC_Ini_KeyPress` | 424-430 | Public | 5 | 5 | 0 | handler GUI |
| `FDC_Ini_LostFocus` | 432-439 | Public | 2 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] :
  - `Utils.Observers(Me)`, `SetObservers`, listes `ListQteBox`/`ListMonBox` (15 coupures, de
    500 € à 0,01 €), `ch = New Chainage(ListQteBox)` (navigation par Entrée ; le membre `ch` garde
    l'objet en vie).
  - `$cai = Ncai`, **`Ncaisse = Left$($cai, 1)`** (code sur un caractère, voir OUVERTURE-A01),
    `$vdr = Ouverture.Rvdr(Ncaisse)` sur l'**auto-instance** d'`Ouverture` (fenêtre cachée créée).
  - `select * from <TabCaisses> WHERE code = &1` ; `fdcbase = Format$(fndc, "0.00")`
    (`"0,00"` en cas d'erreur). **Pas de test `Available`** : `rResult!tkz` lève une erreur non
    interceptée si la caisse n'existe pas (FONDCAISSE-A01).
  - `rResult!tkz = 1` : comparaison d'une colonne `tinyint(1)` à l'entier 1 ; si le pilote
    renvoie un `Boolean` (`True = 1` est faux, vérifié avec `gbs3`), le mode « modification » ne
    serait jamais atteint (à confirmer à l'exécution).
  - Mode modification : libellés, masquage des zones de contrôle. Mode contrôle : `Button1`
    masqué, « Sortir », `FDC_Ini`, `Date_Ini` (`LDate(dteov).LT`), `Date_Now`, puis
    `Calc_FdcTheo()` et `Box1 = FDC_The`.
  - `SELECT * FROM Fiches_Parametres` (**nom en dur**, clé `TabParam`) : `devises` (défaut
    `"Euros"`) pour le libellé et le dossier des images.
  - Variables locales `Tab`… inutiles (`fdctheo` déclarée, jamais utilisée).
- **`Form_Open()`** [handler] [nature : GUI] : charge 15 images de pièces et billets depuis
  `Application.Path/Icones/<devises>/` (15 lignes identiques au nom près). Seul le dossier
  `Icones/Euros` est livré : une autre devise ferait échouer le chargement (à confirmer).
- **`Form_Close()`** [handler] : vide — **code mort**.

### Calcul du fond théorique

- **`Calc_FdcTheo()`** [portée : réductible] [nature : mixte] : `fdctheo = Val(cpoint(FDC_Ini))`,
  puis `select count(*) as cnt, l.type, sum(cast(REPLACE(l.montant, ',', '.') as decimal(7,2)))
  as totmontant, DATE(e.date) as ddate from <TabLigTck> l left join <TabEntTck> e on l.numero =
  e.numero where l.type is not Null and e.statut = '0' and e.caisse = &2 and e.suppr != 1 group by
  l.type, DATE(e.date)` ; ajoute `N`, retranche `Q` ; écrit `FDC_The`. Partie extractible :
  `FdcTheorique(sCaisse, fInitial) As Float` (SQL + somme). Toutes les journées non validées sont
  cumulées (le regroupement par date n'a pas d'effet sur le total). `Val("")` lève une erreur
  (vérifié avec `gbs3`) : non atteint ici car `FDC_Ini` vaut au moins `"0,00"`.

### Saisie du fond réel

- **`Box1_KeyPress()`** [handler] : Entrée/Retour/Tab → `Stop Event` + `Button2_Click` ; sinon
  `ChkFDC`.
- **`ChkFDC()`** [portée : réductible] [nature : GUI] : filtre de touches (chiffres, `,`, `.`,
  touches d'édition et quelques codes) par `Stop Event`. Proche de `Fcaisses.Chkcaisse`.
- **`Box1_LostFocus()`** [handler] : reformate `Box1` en `0.00`.
- **`numpad_Click()`** [handler du groupe `numpad`] : insère `Last.Tag` dans `Box1` (saisie
  directe) ou dans la coupure courante `Qte` (détail, la virgule est ignorée) puis `TotalFDC`.
- **`Raz_Click()`** (« Correction ») [handler] : vide `Box1` ou la coupure courante, `TotalFDC`.
- **`Button3_Click()`** (« Détail caisse » / « Fond de caisse ») [handler] [nature : GUI] :
  bascule entre saisie directe et détail par coupures (`Panel2`), positionne `Qte`/`Mon` sur la
  première coupure ; au retour, `Box1 = FDC_The`. Le membre `Mon` n'est jamais relu (code mort).
- **`TotalFDC()`** [portée : réductible] [nature : mixte] : pour chaque coupure, montant =
  quantité × (valeur extraite du **nom du contrôle** `Qte50000` → 500,00) ; écrit `Mon<…>` et le
  total dans `Box1`. Une quantité non numérique (`Val` nul) → message, effacement, `Stop Event`
  (sans effet hors handler) et arrêt. Partie extractible : `TotalCoupures(quantités) As Float`.
- **`Qte_KeyPress()`** [handler du groupe `Qte`] [nature : GUI] (CC 12) : saisie manuelle des
  chiffres (insertion puis `Stop Event`), gestion de `Suppr` et `Retour arrière` par
  `Mid$`/`Pos`, puis `TotalFDC`. ⚠️ `Suppr` recule le curseur d'une position ; `Retour arrière`
  en début de champ appelle `Mid$(…, 1, -1)` qui renvoie le texte **sans son dernier caractère**
  (vérifié avec `gbs3`) puis `Pos = -1` (FONDCAISSE-A03). Variables locales inutilisées.
- **`Qte_GotFocus()`** [handler] : retrouve l'indice de la coupure (`Tag`) par une boucle,
  positionne `Qte`, `Prec`, `Suiv` (circulaire), `TotalFDC`.
- **`Qte_LostFocus()`** [handler] : `TotalFDC`.
- **`Precedent_Click()` / `Suivant_Click()`** [handlers] : focus sur `Prec`/`Suiv`.
- **`btn_Enter()`** [handler du groupe `btn`, images] [nature : GUI] : affiche l'image survolée
  agrandie dans `P13`, taille et position selon la longueur du nom du contrôle.
- **`P13_Leave()`** [handler] : masque `P13`.
- **`PictureBox6_MouseDown()`** [handler inactif] : vide ; `PictureBox6` appartient au groupe
  `btn`, l'événement nominal n'est jamais levé (`handlers_inactifs`, `unused`) — **code mort**.

### Validation et correction

- **`Button2_Click()`** (« OK ») [handler] [nature : mixte] : mode modification →
  `UPdate <TabCaisses> SET fndc = &2 WHERE code = &1` (`Utils.PointBase(Box1.Text)`) et fermeture ;
  mode contrôle → si réel ≠ théorique, avertissement « Sortir »/« Annuler » ; aucune écriture.
- **`Button1_Click()`** (« annuler », mode modification) [handler] : `Try Kill ~/Caisse.lock`
  (fichier **jamais créé** : les verrous sont `Caisse<n>.lock`) puis fermeture (FONDCAISSE-A06).
- **`FDC_Ini_DblClick()`** [handler] : avertissement puis déverrouillage de `FDC_Ini` pour
  corriger le fond initial en cours de journée.
- **`FDC_Ini_KeyPress()`** [handler] : Entrée/Retour/Tab → focus sur `Box1`.
- **`FDC_Ini_LostFocus()`** [handler] : si `FDC_Ini` est modifiable → `FDC_Ini_Update()`
  (`Stop Event` sans effet sur une perte de focus).
- **`FDC_Ini_Update() As Boolean`** [portée : réductible] [nature : mixte] : si
  `IsNumber(FDC_Ini.Text)` (format localisé : `"12,50"` accepté, `"12.50"` refusé, vérifié avec
  `gbs3`) → `UPDATE fndc`, verrouillage, `Calc_FdcTheo`, `Box1 = FDC_The` ; sinon message et
  retour du focus — chaque sortie du champ réaffiche le message (FONDCAISSE-A04). La valeur de
  retour n'est jamais lue.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/caisse/Ncai"]`, `Start.Societe`.
- `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Observers`, `Chainage`.
- Auto-instance d'`Ouverture` (`Rvdr`).
- Tables : `Fiches_Caisses` (`TabCaisses` : lecture, `UPDATE fndc`), `Fiches_LigTicketz`
  (`TabLigTck`), `Fiches_EntTicketz` (`TabEntTck`), `Fiches_Parametres` (en dur).
- Fichiers : `Application.Path/Icones/<devise>/*.png`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Form_Open` : boucle sur un tableau de noms d'images (15 lignes → 3).
- `Qte_KeyPress`/`Qte_GotFocus` : `ListQteBox.Find(Last)` au lieu des boucles de recherche par
  `Tag`.
- Supprimer `Form_Close`, `PictureBox6_MouseDown`, le membre `Mon` et les variables locales
  inutilisées.

### Commonalisation avec d'autres fichiers

- **Fond théorique** : une fonction partagée `EspecesTheoriques(sCaisse, sFiltreDate)` servirait
  à `Calc_FdcTheo` et à la requête « Mouvements » de [`Moulinage`](../Moulinage.class/architecture.md),
  avec un paramètre pour le filtre `e.date = l.date` afin de garder un SQL identique pour chaque
  appelant. L'alignement des deux calculs (lignes `N`/`Q` contre en-têtes `mespeces`) est une
  anomalie à trancher (FONDCAISSE-A02).
- **Vendeur connecté** : `Ouverture.Rvdr` à déplacer dans un module (OUVERTURE-003, module
  `CaisseEtat`).
- **Filtre de touches numériques** : `ChkFDC` et [`Fcaisses.Chkcaisse`](../Fcaisses.class/architecture.md)
  → helper paramétré par la liste de caractères admis.
- **Survol des boutons** : `SurvolBoutons` (voir CMENU-008).
- **Pas de lien** avec `Csolde.Solde_caisse` / `ClotureF.Calc_solde` / `Visreglements` /
  `TresorFac.Calc_solde` (solde comptable, voir la vue d'ensemble).

### Réduction de portée

`Calc_FdcTheo`, `SetObservers`, `ChkFDC`, `TotalFDC`, `FDC_Ini_Update` → `Private` (aucun appelant
externe, vérifié par `grep`). `PictureBox6_MouseDown` est supprimé (code mort) plutôt que réduit.

### Séparation traitement / GUI

- `FdcTheorique(sCaisse, fInitial) As Float` (SQL + somme) appelé par `Calc_FdcTheo`.
- `TotalCoupures(aQte As String[]) As Float[]` (montants par coupure et total) appelé par
  `TotalFDC`.
- `EnregistreFdc(sCaisse, sMontant)` pour les deux `UPDATE fndc`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_LigTicketz.montant` et `Fiches_EntTicketz.m*` sont des `char(12)` convertis par
  `REPLACE(…, ',', '.')` + `cast` dans chaque requête : des colonnes `decimal(12,2)`
  supprimeraient la conversion (et la limite `decimal(7,2)` du `cast`).
- Un historique des fonds de caisse (comptages par coupure, date, vendeur) remplacerait la seule
  colonne `fndc` écrasée à chaque modification.
