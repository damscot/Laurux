# ChxImp — Architecture

> Source : `.src/Reports/ChxImp.class` (+ `ChxImp.form`)

## Vue d'ensemble

`ChxImp` est une petite **fenêtre de choix d'imprimante** (formulaire « Choix imprimante » :
`TextLabel1`, liste déroulante `ComboBox1`, bouton `Button1` « Valider »). À l'ouverture, elle
liste les imprimantes CUPS par `lpstat -p` ; « Valider » écrit le nom choisi dans
`Variables.impr` et ferme la fenêtre.

**La fenêtre n'est jamais ouverte** : aucune référence à la classe dans le projet (ni `New
ChxImp`, ni `ChxImp.Show*`, ni chaîne pour un chargement dynamique ; vérifié par `grep` sur
`.src`, `.project`, et dans l'historique git avec `git log -G`, qui ne trouve aucune ouverture
depuis son ajout en `e1b2d2b8`, novembre 2016). Les mentions de « ChxImp » ailleurs désignent
une ancienne case à cocher des écrans de facturation, supprimée en février 2017 (`01577a3e`,
`92dba8ef`, commentaire résiduel `Facturergbl:455`). `Variables.impr` n'est lue nulle part
(VARIABLES-002). Signal `jamais_reference` de l'heuristique confirmé.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-21 | Public | 5 | 16 | 0 | méthode spéciale |
| `Button1_Click` | 23-28 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : mixte, partie extractible : lecture et
  découpage de la sortie de `lpstat`] : `Shell "lpstat -p > ~/tmp/resultat 2>&1" Wait`, puis lit le
  fichier ligne à ligne et ajoute le 2e mot de chaque ligne (`Split(lg, " ")[1]`) à `ComboBox1`.
  Défauts latents (fenêtre jamais ouverte) :
  - le filtre `If Not InStr(lg, "Rendering")` est **toujours vrai** (`Not` d'un entier non nul
    vaut un autre entier non nul, `Not 0` vaut -1 : acquis vérifiés du lot) : les lignes
    « Rendering… » ne sont pas filtrées ;
  - une ligne vide ou d'un seul mot lève « Out of bounds » (`Lig[1]`) ;
  - les lignes de continuation de `lpstat` et le message « aucune destination » ajoutent des
    mots parasites ;
  - `~/tmp/resultat` n'est jamais supprimé ; chemin construit par concaténation non protégée.
- **`Button1_Click()`** [portée : nécessaire (handler `Public` obligatoire)] [nature : GUI] :
  `Variables.impr = ComboBox1.Text` puis `Me.Close`.

## État global utilisé

- Écrit `Variables.impr` (jamais lu ailleurs).
- `User.Home`, commande système `lpstat` (CUPS).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune tant que le sort du couple n'est pas décidé : la suppression du couple `.class` + `.form`
  est une anomalie (CHXIMP-A01). Si l'écran est conservé, isoler la lecture de `lpstat` dans une
  fonction pure `ListeImprimantes(sortie As String) As String[]` (CHXIMP-A02).

### Commonalisation avec d'autres fichiers

- Le choix d'imprimante n'existe plus ailleurs dans le projet ; l'impression passe par
  `Visualiseur.Prog` (PDF ouvert dans le visualiseur configuré).

### Réduction de portée

- Aucune (handler `Public` obligatoire, `_new` spéciale).

### Séparation traitement / GUI

- Voir CHXIMP-A02 (seulement si l'écran est conservé).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
