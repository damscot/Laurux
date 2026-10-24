# Echeances — Architecture

> Source : `.src/Compta/Echeances.class`

## Vue d'ensemble

`Echeances` est l'écran de **paramétrage des conditions d'échéance** (table `Fiches_Echeances` :
`num`, `libell`, `duree`, `jours`, `finmois`). Il affiche la liste des échéances dans le
`ColumnView` `Colech`, permet de créer, modifier ou supprimer une échéance, et propose un
**simulateur** (« tester la formule ») qui calcule une date d'échéance à partir d'une date de
facture via `Utils.Calcech`.

Ouverture : `Fmenu.class:1326` (`Echeances.ShowModal()`, auto-instance du formulaire).
Les codes d'échéance sont ensuite référencés par les fiches clients et fournisseurs (`FClient`,
`FFournisseur`) et lus par la facturation (`Facture`, `ObjFac`, `ValidBR`, `Moulinage`…).

Nature globale : **écran GUI de saisie CRUD**, avec trois requêtes SQL simples ; aucune logique de
calcul propre (le calcul d'échéance est délégué à `Utils.Calcech`).

Contrôles du formulaire (groupe entre parenthèses) : `Cdech` (ech, tag 1), `Libellech` (ech, tag 2),
`Dureech` (ech, tag 3), `Joursech` (ech, tag 4), `Datej` (Ech, tag 5), `Dateech`, `Finm`
(CheckBox), boutons `Button4` (Btn, tag 1, aide), `Button1` (Btn, tag 2, supprimer), `Button2`
(Btn, tag 3, enregistrer), `Button3` (Btn, tag 4, quitter), `Button5` (Btn, tag 5, tester),
`Colech` et `colech2` (ColumnView ; `colech2` n'est pas utilisé par la classe).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `ye` | var | Private |  | String | 24 |
| `mo` | var | Private |  | String | 25 |
| `da` | var | Private |  | String | 26 |
| `son` | var | Private |  | Integer | 27 |
<!-- /AUTO:declarations -->

- `ye`, `mo`, `da` : chaînes utilisées seulement par la fin de `Button5_Click`, qui est sans effet
  (voir plus bas) : variables de fait inutiles.
- `son` : copie de `Start.Son` à l'instanciation (son activé ou non).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-47 | Public | 1 | 14 | 0 | méthode spéciale |
| `Form_Open` | 52-69 | Public | 3 | 15 | 0 | handler GUI |
| `Maj_Zones` | 74-86 | Public | 2 | 11 | 0 | portée réductible ? |
| `CleanChamps` | 91-99 | Public | 1 | 7 | 0 | portée réductible ? |
| `Refresh` | 104-109 | Public | 1 | 4 | 0 | portée réductible ? |
| `ech_GotFocus` | 114-120 | Public | 1 | 5 | 0 | handler GUI |
| `ech_KeyPress` | 125-179 | Public | 18 | 52 | 0 | handler GUI |
| `Btn_Keypress` | 184-193 | Public | 4 | 8 | 0 | handler GUI |
| `Btn_Click` | 198-213 | Public | 6 | 14 | 0 | handler GUI |
| `Colech_Click` | 215-219 | Public | 1 | 3 | 0 | handler GUI |
| `echman` | 224-239 | Public | 2 | 13 | 0 | portée réductible ? |
| `Button1_Click` | 244-267 | Public | 5 | 21 | 0 | portée réductible ? |
| `Button2_Click` | 272-295 | Public | 4 | 21 | 0 | portée réductible ? |
| `Quittedate` | 300-311 | Public | 2 | 10 | 0 | portée réductible ? |
| `Button5_Click` | 316-333 | Public | 5 | 16 | 0 | portée réductible ? |
| `Button4_Click` | 338-341 | Public | 1 | 2 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et liste

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Charge le son (`Music.Load`), centre
  la fenêtre, enregistre les observateurs de replay (`Utils.Observers(Me)`) et prépare 5 colonnes de
  `Colech` (seules 4 reçoivent largeur et titre ; la 5e porte `finmois`).
- **`Form_Open()`** [handler] [nature : mixte]. `SELECT * FROM Fiches_Echeances order by num`
  (nom de table en dur, pas de `Cbase.Table("TabEch")`), puis remplit `Colech` (clé = `num`).
  Partie extractible : la requête.
- **`Refresh()`** [portée : réductible] [nature : GUI]. Vide `Colech` puis rappelle `Form_Open()`.
- **`Colech_Click()`** [handler] → `Maj_Zones()`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI]. Recopie la ligne courante de `Colech` dans
  les champs ; complète `joursech` à 2 caractères ; `Finm.Value = Utils.convBool(...)`. Le bloc
  `With Utils` ne sert qu'à un appel.
- **`CleanChamps()`** [portée : réductible] [nature : GUI]. Vide les 4 champs et décoche `Finm`.
- **`echman()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Echeances where num = &1`
  sur `Cdech.Text` ; si trouvé, remplit les champs. `Finm.Value` reçoit directement
  `rResult!finmois` (alors que `Maj_Zones` passe par `Utils.convBool`).

### Saisie clavier et boutons

- **`ech_GotFocus()`** [handler du groupe `ech`] : couleur d'édition (`Utils.SetEditColor`).
- **`ech_KeyPress()`** [handler du groupe `ech`] (CC 18, max du fichier) [nature : GUI]. Sur
  Entrée/Retour/Tab, enchaîne les champs selon `Last.Tag` : 1 → contrôle non vide, focus libellé et
  `echman()` ; 2 → libellé obligatoire ; 3 → durée obligatoire, `"0"` devient `"00"`, refus d'une
  durée sur 1 caractère ; 4 → jours obligatoires sauf si `Finm` coché (message « Veuillez saisir
  une date », libellé erroné), focus sur `Button2` ; 5 (`Datej`) → `Quittedate()` ; **6 → branche
  morte** (aucun contrôle ne porte le tag 6). F1 → `Button4_Click()` (aide, vide).
- **`Btn_Keypress()`** [handler du groupe `Btn`] : Entrée sur le tag 3 → `Button2_Click()`.
- **`Btn_Click()`** [handler du groupe `Btn`] : aiguillage par tag (1 aide, 2 supprimer,
  3 enregistrer, 4 fermer, 5 tester).
- **`Button1_Click()`** [handler] [nature : mixte]. Après confirmation (« Oui »), `SELECT` puis
  `DELETE FROM Fiches_Echeances WHERE num = &1`, rafraîchit la liste, vide les champs et affiche
  « echéance supprimée ». Aucun contrôle d'usage : une échéance référencée par des fiches clients ou
  fournisseurs peut être supprimée (à confirmer côté métier). Branche `Else` vide.
- **`Button2_Click()`** [handler] [nature : mixte]. Code obligatoire ; `SELECT` sur `num` puis
  `INSERT` (création) ou `UPdate … SET num = &1 … WHERE num = &1` (modification). Les champs ne sont
  vidés qu'après une modification, pas après une création (incohérence visible). `Finm.Value`
  (Boolean) est transmis tel quel au SQL : conversion par `DB_Connection.Subst` (valeur stockée à
  confirmer, `0/1` attendu). `Catch` : `Music.Play` + `Message.Error` (sans test de `son`).
- **`Quittedate()`** [portée : réductible] [nature : GUI]. Normalise `Datej` via
  `Utils.Cdate_calc` puis `Utils.Cdate_aff` ; si le résultat vaut la sentinelle `"00.00.0:00"`,
  remet la date du jour. Même idiome que `Tresor.QuitteDate`.
- **`Button5_Click()`** [handler] [nature : mixte]. Simulateur : date du jour par défaut,
  `Quittedate()`, puis `dateech.Text = Utils.Calcech(durée, jours, Finm, Datej)`. Les lignes 324-327
  calculent `ye`/`mo`/`da` puis `Try dateech = Date(dateech, mo, da)` : `dateech` est un
  `TextBox`, l'appel échoue toujours et l'erreur est absorbée par `Try` → **code mort**.
- **`Button4_Click()`** [handler] : aide, corps vide (`Doc.Open("Echeances")` commenté).

## État global utilisé

- `Start.Son`, `Start.Musique` (son) ; `Utils.Observers` (replay).
- `Utils.db` (3 formes de requêtes), `Utils.convBool`, `Utils.SetEditColor`, `Utils.Cdate_calc`,
  `Utils.Cdate_aff`, `Utils.Calcech`.
- Table : `Fiches_Echeances` (en dur, clé `Cbase` disponible : `TabEch`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la fin morte de `Button5_Click`, la branche `Case 6` d'`ech_KeyPress`, la branche
  `Else` vide de `Button1_Click` et les variables `ye`/`mo`/`da`.
- Remplacer les 4 occurrences de `"Fiches_Echeances"` par `Cbase.Table("TabEch")` (même SQL émis).

### Commonalisation avec d'autres fichiers

- La normalisation de date avec sentinelle `"00.00.0:00"` est dupliquée dans
  [`Tresor.QuitteDate`](../Tresor.class/architecture.md) : un helper commun
  (`Utils.Cdate_saisie(texte) As String`, ou une méthode de [`LDate`](../../Utils/LDate.class/architecture.md))
  servirait aux deux écrans.
- Le motif « écran de table simple » (liste `ColumnView` + champs + Enregistrer/Supprimer) se
  retrouve dans d'autres écrans de paramétrage : candidat à un socle commun en phase 3 (hors
  périmètre immédiat).

### Réduction de portée

- `Maj_Zones`, `CleanChamps`, `Refresh`, `echman`, `Quittedate` : aucun appelant externe (vérifié par
  `grep -rn`), passage en `Private` possible, couverture par replay.

### Séparation traitement / GUI

- Extraire `Private Function Lit_Echeances() As Result`, `Private Function Lit_Echeance(code) As
  Result`, `Private Sub Enregistre(code, libelle, duree, jours, finmois)` et `Private Sub
  Supprime(code)` ; les handlers gardent les messages et le remplissage des contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `duree` et `jours` sont stockés en texte sur 2 caractères (`"00"`, `"30"`) : un type entier
  simplifierait `Utils.Calcech` et les contrôles de saisie.
- Contrainte d'intégrité référentielle entre `Fiches_Cli`/`Fiches_Four` et `Fiches_Echeances.num`
  pour empêcher la suppression d'une échéance utilisée.
