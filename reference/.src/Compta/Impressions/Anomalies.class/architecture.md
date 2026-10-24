# Anomalies — Architecture

> Source : `.src/Compta/Impressions/Anomalies.class` · Formulaire : `.src/Compta/Impressions/Anomalies.form`

## Vue d'ensemble

Écran **« Anomalies des clés »** (menu Compta « Anomalies des clés », `Fmenu.Menu324_Click`). Il
contrôle l'**inaltérabilité** des écritures : pour chaque ligne d'écriture d'un exercice
(`Fiches_Mvt` ou `Fiches_Mvt1`…`5` selon le bouton radio N, N-1…N-5) entre deux dates, il compare
la clé SHA-1 mémorisée (`control`) à la clé recalculée (`Sha1Calc.CalcSha1_Verify`) et imprime
dans un PDF (`Ccompta`, `~/tmp/Anomalies.pdf`) la liste des écritures dont la clé diffère.

Nature : **mixte** ; boucle de contrôle et impression dans le handler `Button2_Click`. Les deux
fonctions `Exercice_Begin`/`Exercice_End` sont un calcul de dates d'exercice dupliqué de `LDate`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 3 |
| `dte1` | var | Private |  | String | 4 |
| `dte2` | var | Private |  | String | 5 |
<!-- /AUTO:declarations -->

Contrôles du `.form` : `DteN0`/`DteN1` (dates du / au), `E0`, `N1`…`N5` (RadioButton du groupe `N`,
`Tag` 0 à 5), `Button2` Imprimer, `Button1` Fermer.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 8-13 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 17-82 | Public | 9 | 63 | 0 | handler GUI |
| `Button1_Click` | 84-88 | Public | 1 | 3 | 0 | handler GUI |
| `Exercice_Begin` | 91-95 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exercice_End` | 99-125 | Public | 6 | 23 | 0 | portée réductible ? |
| `N_Click` | 127-137 | Public | 2 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [handler] [mixte] : dates de l'exercice en cours dans `DteN0`/`DteN1`,
  `Tab = "Fiches_Mvt"`.
- **`N_Click()`** [handler du groupe `N`] [mixte] : dates de l'exercice `Last.Tag` et
  `Tab = "Fiches_Mvt" & Tag` (vide pour 0).
- **`Button2_Click()`** (CC 9) [handler] [mixte ; partie extractible : sélection des lignes et
  vérification] :
  - Ligne 28 : `SELECT * FROM  Fiches_Mvt` **sans usage** (résultat écrasé ligne 40) : lecture
    complète inutile de la table.
  - Ligne 40 : `Try SELECT * FROM <Tab> WHERE dte BETWEEN DteN0 AND DteN1 ORDER BY numero, lind
    desc` ; en cas d'erreur, message « La base ne contient pas de somme de control (exercice avant
    2017-2018) » (l'erreur réelle peut être une table ou une date invalide).
  - `ProgBar` interruptible ; pour chaque ligne, `Sha1Calc.CalcSha1_Verify(Tab, numero, lind)`
    (une requête par ligne) ; si la clé diffère, ligne PDF `Level2A2(numero, compte, intitule,
    date, control, CalcSha1("Fiches_Mvt", numero, lind, False), PosY)`.
  - ⚠️ La clé recalculée **affichée** est toujours calculée sur `Fiches_Mvt`, même pour un exercice
    N-1…N-5 : pour ces exercices, la colonne « clé calculée » du rapport est fausse (anomalie A01).
  - `Ste` n'est jamais renseignée (`Level0P("")`), `dte`, `$cle`, `$cle2` inutilisées.
  - Si aucune anomalie : « Aucune anomalie ! » ; si aucune ligne dans la plage : aucun message
    (anomalie A03).
- **`Button1_Click()`** [handler] : ferme.
- **`Exercice_End(Annee)`** [portée : réductible — aucun appelant externe (grep)] [calcul + SQL] :
  `SELECT * FROM Cbase.Table("TabParam")` puis `dteclec<Annee>` (0 → `dteclec`). Équivalent de
  [`LDate.Exercice_Cloture(Annee)`](../../../Utils/LDate.class/architecture.md) (qui renvoie la même
  date à 23:59:59.999). `With utils` inutile ; aucun test `Available`.
- **`Exercice_Begin(Annee)`** [portée : réductible] [calcul] : `Exercice_End − 1 an + 1 jour`, même
  hypothèse d'exercice de 12 mois que `LDate.Exercice_Debut`.

## État global utilisé

- `Utils.db`, `Utils.Cdate_Dbase` ; `Cbase.Table("TabParam")` ; `Sha1Calc.CalcSha1_Verify`,
  `Sha1Calc.CalcSha1` ; `Ccompta`, `ProgBar`, `Visualiseur`.
- Tables : `Fiches_Mvt`…`Fiches_Mvt5` (noms construits, en dur), `Fiches_Parametres`.
- Variables d'instance : `Tab` (table de l'exercice choisi), `dte1`/`dte2` (inutilisées).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la requête morte de la ligne 28, `dte1`, `dte2`, `Ste`, `dte`, `$cle`, `$cle2` et le
  `Shell "cd"`.
- Factoriser l'en-tête de page (répété lignes 34-39 et 59-64) dans un helper privé `Entete(pdf)`.

### Commonalisation avec d'autres fichiers

- `Exercice_End`/`Exercice_Begin` → [`LDate.Exercice_Cloture(n)`](../../../Utils/LDate.class/architecture.md)
  et un début d'exercice dérivé (`Exercice_Debut`), formatés en `dd.mm.yyyy` : même affichage
  (l'heure n'est pas affichée). Voir LDATE-008.
- Nom de table d'exercice `"Fiches_Mvt" & n` : même proposition transverse que
  [Listextcpt](../../Utils/Listextcpt.class/architecture.md) (helper `Cbase.TableMvt(n)`).
- La vérification ligne à ligne pourrait utiliser une fonction `Sha1Calc.Verify_Plage(Tab, d1, d2)`
  qui renvoie les lignes en anomalie (à proposer au rework de `Sha1Calc`).

### Réduction de portée

- `Exercice_Begin`, `Exercice_End` → `Private`, ou suppression après commonalisation avec `LDate`.

### Séparation traitement / GUI

- `Private Function LignesEnAnomalie(sTab, sDu, sAu) As Collection` (ou tableau de lignes) sans
  accès aux contrôles ni au PDF ; `Button2_Click` garde la `ProgBar` (interruption) et l'impression.
  La `ProgBar` devant rester interruptible, la fonction peut prendre un rappel ou rester une boucle
  dans le handler : à arbitrer au rework.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(dte)` sur `Fiches_Mvt*` (aujourd'hui `idx_compte(compte, dte)` et `idx_jour(jour, dte)`)
  pour la sélection par plage de dates.
