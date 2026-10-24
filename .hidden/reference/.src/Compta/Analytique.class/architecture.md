# Analytique — Architecture

> Source : `.src/Compta/Analytique.class`

## Vue d'ensemble

Fenêtre modale de **répartition analytique** d'une ligne d'écriture, ouverte par
[`Saisecrit.Button4_Click`](../Saisecrit.class/architecture.md) (`Saisecrit.class:1950`) quand
l'option `/Soc<XX>/Analytique` est active et que le compte saisi a une ventilation par défaut dans
`Fiches_Analytiques` (`Cbase.Table("TabAna")`).

La grille `Tbrem` (3 colonnes : poste, %, montant) est préremplie :

- avec la ventilation déjà enregistrée de l'écriture (`Fiches_MvtA` joint à `Fiches_Postes`,
  filtre `compte` + `numero`) ;
- sinon avec la ventilation par défaut du compte (`Fiches_Analytiques` joint à `Fiches_Postes`).

L'utilisateur modifie un poste (liste déroulante), un pourcentage ou un montant ; les totaux
(`Label3` % réparti, `Label4` % restant, `Label5` montant réparti, `Label6` reste) sont recalculés.
« Valider » remplace la ventilation de l'écriture dans `Fiches_MvtA` si `Label4` vaut
`"0,00 %"`.

Nature globale : **mixte** ; calculs, SQL et contrôles sont entremêlés dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Compte` | var | Private |  | String | 3 |
| `Montant` | var | Private |  | String | 4 |
| `Pourcent` | var | Private |  | String | 5 |
| `$Necrit` | var | Private |  | String | 6 |
| `Total` | var | Private |  | String | 7 |
| `Journal` | var | Private |  | String | 8 |
| `Libelle` | var | Private |  | String | 9 |
| `intitule` | var | Private |  | String | 10 |
| `$sens` | var | Private |  | String | 11 |
| `$date` | var | Private |  | LDate | 12 |
| `Numdoc` | var | Private |  | String | 13 |
| `Enrgt` | var | Private |  | Boolean | 14 |
| `Poste` | var | Private |  | New String[20] | 15 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 17-52 | Public | 3 | 31 | 0 | méthode spéciale |
| `Form_Open` | 54-60 | Public | 1 | 5 | 0 | handler GUI |
| `Button3_Click` | 62-72 | Public | 3 | 9 | 0 | handler GUI |
| `Tbrem_Click` | 74-82 | Public | 2 | 7 | 0 | handler GUI |
| `Tbrem_Save` | 84-128 | Public | 8 | 42 | 0 | handler GUI |
| `Deb1` | 130-170 | Public | 4 | 35 | 0 | portée réductible ? |
| `Button2_KeyPress` | 172-176 | Public | 3 | 3 | 0 | handler GUI |
| `Button2_Click` | 178-208 | Public | 5 | 28 | 0 | handler GUI |
| `Form_KeyPress` | 210-214 | Public | 2 | 3 | 0 | handler GUI |
| `Button1_Click` | 219-223 | Public | 1 | 3 | 0 | portée réductible ? |
| `Btn_Click` | 225-227 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Code, Mtd, Necrit, sens, Jour, dte, $intitule, Nmdoc, $libel)`** [portée : nécessaire]
  [nature : mixte]. Mémorise compte, montant (chaîne), numéro d'écriture, sens (`"T"` si débit :
  `Saisecrit` passe un booléen converti en chaîne), journal, date (`LDate`), intitulé, pièce,
  libellé. Configure `Tbrem` (7 lignes, 3 colonnes) et charge la liste des postes
  (`select * from Fiches_Postes order by code`) dans `Poste`, tableau **fixe de 20 cases**
  (dépassement d'indice au-delà de 20 postes).
- **`Form_Open()`** [portée : nécessaire, handler] [nature : GUI]. Centre, `Deb1`, focus Valider.
- **`Button3_Click()`** [portée : nécessaire, handler] [nature : GUI]. Fermer, avec confirmation
  si rien n'a été enregistré (`Enrgt`).
- **`Tbrem_Click()`** [portée : nécessaire, handler] [nature : GUI]. Édition de cellule ; liste
  des postes en colonne 0.
- **`Tbrem_Save(Ligne, Colonne, Valeur)`** [portée : nécessaire, **handler** de l'événement
  `Save` de la `TableView` — signalé à tort comme réductible par `deps.py`] [nature : mixte].
  Colonne 0 : lit le % par défaut du poste pour ce compte (`select pourcent from
  Fiches_Analytiques where compte = &1 and code = &2`) et calcule le montant ; colonne 1 :
  montant = `Montant × % / 100` ; colonne 2 : % = `montant / Montant × 100`. Recalcule ensuite
  tous les totaux par une boucle `While` sur les lignes (`Label3`…`Label6`), en manipulant les
  chaînes (`Left$(…, Len - 2)` pour retirer `" %"`).
- **`Deb1()`** [portée : réductible] [nature : mixte]. Chargement initial (deux branches
  `Repeat` identiques ligne à ligne). La seconde requête concatène le compte
  (`where a.compte = <Tri>`) et ne teste pas `Available` avant `Repeat`. `Label4` (% restant)
  n'est **pas** mis à jour : il garde la valeur du formulaire, `"0,00 %"`.
- **`Button2_KeyPress()`** [portée : nécessaire, handler] [nature : GUI]. Entrée → `Button2_Click`.
- **`Button2_Click()`** [portée : nécessaire, handler] [nature : mixte]. Lit le nombre de lignes
  existantes de `Fiches_MvtA` pour le **numéro d'écriture** (`nResult`), les **supprime toutes**
  (`delete … where numero = &1`, tous comptes confondus), puis, si `Label4.Text = "0,00 %"`,
  insère une ligne par poste non vide (`poste, jour, numero, compte, intitule, dte, numdoc,
  libelle, pourcent, montantd|montantc, validee = 0`) et ferme. La boucle s'arrête quand
  `ligne >= nResult.count` : le nombre de postes enregistrés est borné par le nombre de lignes
  qui existaient avant (voir ANALYTIQUE-A02). Sinon : message « pas équilibrée » (mais la
  suppression a déjà eu lieu).
- **`Form_KeyPress()`** [portée : nécessaire, handler] [nature : GUI]. F1 → `Button1_Click`.
- **`Button1_Click()`** [portée : nécessaire] [nature : GUI]. `Doc.Open("Analytique")`. Le
  bouton `Button1` appartient au groupe `Btn` dans le `.form` : un clic lève `Btn_Click`, pas
  `Button1_Click`. Cette méthode n'est donc atteinte que par F1.
- **`Btn_Click()`** [portée : nécessaire, handler du groupe `Btn`] [nature : GUI]. **Vide** :
  le clic sur le bouton d'aide ne fait rien (ANALYTIQUE-A01).

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table` (`TabPostes`, `TabAna`, `TabMvtA`).
- `LDate` (`.DT` pour la date insérée).
- Aucun état `Start`/`Variables`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb1` : une seule boucle de remplissage `AjouteLigne(r, ligne)` pour les deux requêtes ;
  paramétrer la seconde requête (`&1`) et tester `Available` (ANALYTIQUE-002, 003).
- Totaux : calcul sur des `Float` puis formatage final, au lieu de relire `Label3.Text` et d'en
  retirer `" %"` à chaque ligne (ANALYTIQUE-004). Attention à conserver le formatage
  intermédiaire `Format$(…, "0.00")` qui produit les arrondis affichés.
- `Poste` : `String[]` dynamique (`Add`) au lieu d'un tableau fixe (changement visible seulement
  au-delà de 20 postes : anomalie A03).

### Commonalisation avec d'autres fichiers

- Calcul « montant × % / 100 arrondi à 0,01 » : candidat à un helper `LPrix` ou `Utils`
  (voir [`LPrix`](../../Utils/LPrix.class/architecture.md)) ; l'arrondi par `Format$(…,"0.00")`
  puis `Val(cpoint(…))` est l'idiome répété dans tout le projet.
- La ventilation automatique (`Saisecrit.VentilAuto`) et la validation de `Fiches_MvtA`
  (`Saisecrit.class:2057`, suppression `Saisecrit.class:2693`) manipulent la même table : une
  classe `LVentilation` (lecture, écriture, contrôle d'équilibre) servirait aux deux écrans.

### Réduction de portée

- `Deb1` → `Private`.
- `Tbrem_Save`, `Btn_Click`, `Button1_Click` : **à conserver `Public`** (handlers ou cible de
  replay).

### Séparation traitement / GUI

- `RepartitionMontant(Montant, Pourcent) As String` et `TotauxVentilation(lignes) As Float[]`
  purs, testables en gb.test.
- `EnregistreVentilation(numero, compte, lignes)` : SQL de `Button2_Click` sans accès aux
  contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_MvtA` n'est reliée à l'écriture que par `numero` (+ `compte`) : une clé vers la ligne
  (`lind` de `Fiches_Mvt`) éviterait les suppressions par numéro qui touchent les autres comptes.
- `pourcent` et montants stockés en `DECIMAL` homogène.
