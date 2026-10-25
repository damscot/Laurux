# TestCaisses — Architecture

> Source : `.src/Caisse/TestCaisses.module`

## Vue d'ensemble

Malgré son nom, `TestCaisses` **n'est pas un harnais de test** : c'est un contrôle d'exécution
de l'écran de connexion de la caisse ([`Ouverture`](../Ouverture.class/architecture.md)). Sa
fonction unique `TestCai` vérifie qu'un vendeur (caissière) n'est pas déjà connecté sur une
**autre** caisse du poste, en lisant les fichiers de verrou `~/Caisse1.lock` … `~/Caisse10.lock`
écrits par `Ouverture.Button1_Click` (`Print #hFile, caissiere.Text & "O"`, première ligne =
code vendeur, nom, puis `O`).

Il ne relève donc **pas** de la conversion des `Internal_Test` en gb.test (PLAN §0, harnais) : il
n'y a rien à convertir. Il peut en revanche être **testé** en gb.test une fois la logique séparée
du `Message.Warning` (TESTCAISSES-002).

Il remplace l'ancien [`Dcaisses.TestCai`](../Dcaisses.module/architecture.md) (code mort).

Nature : **mixte** (lecture de fichiers + `Message.Warning`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `TestCai` | 3-31 | Public | 6 | 25 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`TestCai(Cai As String, Vdr As String) As String`** [portée : nécessaire] [nature : mixte]
  (CC 6). Pour `C` de 1 à 10 : si `~/Caisse<C>.lock` existe, lit sa première ligne et en garde le
  **premier caractère** (`$Vdr = Left$(lig, 1)`) ; si `C <> Cai` et que ce caractère égale `Vdr`,
  affiche `Message.Warning("Cette caissière est déjà utilisée sur la caisse " & $Vdr)`, met
  `b = 1` et sort de la boucle (`Break`). Renvoie `b` (Integer 0/1 converti en `String` `"0"`/
  `"1"` ; les appelants l'affectent à `b As Integer` et testent `B = 1`).
  - Appelants (`Ouverture.class:132` dans `Caissiere_Click`, `Ouverture.class:200` dans
    `Button1_Click`) passent `Vdr = Left$(Caissiere.Text, 1)` : comparaison sur **un seul
    caractère** alors que le code vendeur est un `char(2)` (`Fiches_Vendeurs.code`) → deux vendeurs
    `10` et `11` se bloquent mutuellement (TESTCAISSES-A02).
  - Le message affiche `$Vdr` (le caractère du vendeur) et **non le numéro de caisse** `C`
    (TESTCAISSES-A01).
  - En cas de `Break`, le fichier n'est pas fermé explicitement (fermé à la libération de
    l'objet `File`).
  - `Cai` est une `String` comparée à l'entier `C` (conversion implicite) ; `Ouverture` passe
    `Left$(Combobox1.Text, 1)` : une caisse 10 serait vue comme « 1 » (défaut d'`Ouverture`).

## État global utilisé

- `User.home` (répertoire des verrous), système de fichiers.
- `Message.Warning` (GUI).

## Propositions d'amélioration

### Réécriture / refactorisation

- Fermer le fichier avant `Break` (aucun effet visible).
- Renvoyer explicitement une chaîne (`CStr(b)`) ou documenter la conversion implicite ; changer
  le type de retour en `Integer` imposerait de modifier `Ouverture` (2 appels, même commit).

### Commonalisation avec d'autres fichiers

- Gestion des verrous de caisse dispersée : écriture dans `Ouverture.Button1_Click`, lecture ici
  et dans `Dcaisses` (mort), suppression dans `Fondcaisse` (`Fondcaisse.class:322`, qui supprime
  `~/Caisse.lock` **sans numéro** : à vérifier dans le lot de
  [`Fondcaisse`](../Fondcaisse.class/architecture.md)). Proposition : module unique
  `VerrouCaisse` (`Chemin(n)`, `Lit(n)`, `Ecrit(n, vendeur)`, `Supprime(n)`, `CaisseDuVendeur(vdr)`).

### Réduction de portée

- `TestCai` reste `Public` (appelé par `Ouverture`).

### Séparation traitement / GUI

- Extraire `CaisseDuVendeur(Cai, Vdr) As Integer` (pure vis-à-vis de la GUI : renvoie le numéro
  de la caisse occupée, 0 sinon, en conservant la comparaison sur le premier caractère) ;
  `TestCai` garde le `Message.Warning` identique et le même retour.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les verrous de caisse sont des fichiers locaux au poste (`User.home`) : deux postes ne se
  voient pas. Un état de connexion en base (colonne vendeur connecté dans `Fiches_Caisses`)
  rendrait le contrôle fiable en multiposte.
