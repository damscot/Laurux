# Edregul — Architecture

> Source : `.src/Gestion/Impressions/Edregul.class` (+ `Edregul.form`)

## Vue d'ensemble

Écran « Impression des régularisations de stock » (menu `Menu91`, Gestion > Stock > Impressions,
`Fmenu.class:1040`). L'utilisateur saisit une période (par défaut : même jour, quatre ans plus tôt
→ aujourd'hui), imprime les mouvements de régularisation `Fiches_Mvtexp` de la période
(`~/tmp/Regul.pdf`, classe `Carticles`) et peut, en cochant `Effmvts`, **purger** ces mouvements.

L'en-tête du fichier est une copie (« Impression des Bl fournisseurs ») : le fichier est en réalité
le jumeau de [`Edregulprdc`](../Edregulprdc.class/architecture.md) (142 lignes communes sur 153,
ratio 0,84) et un proche parent de [`Edsdepots`](../../Depots/Edsdepots.class/architecture.md)
(102 lignes communes) et de [`Edpaiement`](../Edpaiement.class/architecture.md) (saisie de date).

Le `.form` contient deux boutons sans handler : `Button1` (aide « Doc HTML », inopérant) et
`Button6` (« Quitter », placé hors de la zone visible).

Nature : **mixte** (SQL de lecture et de purge, PDF, contrôles dans le même handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `PosX` | var | Private |  | Integer | 32 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-45 | Public | 1 | 10 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 50-78 | Public | 10 | 21 | 0 | handler GUI |
| `Cmpt_GotFocus` | 83-89 | Public | 1 | 5 | 0 | handler GUI |
| `date1_LostFocus` | 91-103 | Public | 3 | 11 | 0 | portée réductible ? |
| `date2_GotFocus` | 105-109 | Public | 1 | 3 | 0 | portée réductible ? |
| `date2_LostFocus` | 111-130 | Public | 6 | 18 | 0 | portée réductible ? |
| `Button2_Click` | 132-210 | Public | 13 | 76 | 0 | handler GUI |
| `Button3_Click` | 212-217 | Public | 2 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [méthode spéciale] [GUI] : `Utils.Observers(Me)`, centrage, `Music.Load`, dates par
  défaut (`date1` = `date2` moins 4 ans, par découpage de chaîne), focus sur `date1`.
- **`Cmpt_KeyPress()`** (CC 10) [handler du groupe `Cmpt` : `Date1` tag 1, `Date2` tag 2] [GUI] :
  Entrée/Retour/Tab → normalise la date (`date1_LostFocus`/`date2_LostFocus`) et passe au champ
  suivant ; F1 neutralisé (appel d'aide commenté).
- **`Cmpt_GotFocus()`** [handler] [GUI] : `Utils.SetEditColor`.
- **`date1_LostFocus()`** [portée : réductible] [GUI] : pseudo-handler — `Date1` est rattaché au
  groupe `Cmpt`, Gambas ne lève donc jamais `date1_LostFocus` ; il n'est exécuté que depuis
  `Cmpt_KeyPress`. Normalise par `Utils.Cdate_calc` puis `Cdate_aff` ; `"00.00.0:00"` → date du
  jour ; `Catch` → refocus. Conséquence : une date quittée **à la souris** n'est pas normalisée
  (EDREGUL-A03, à confirmer en replay).
- **`date2_GotFocus()`** [code mort] : handler inactif (contrôle groupé), signalé
  `handlers_inactifs` et `unused` par `deps.py` ; la couleur de focus est déjà gérée par
  `Cmpt_GotFocus`.
- **`date2_LostFocus()`** [portée : réductible] [GUI] : idem `date1_LostFocus`, plus un
  avertissement si la fin précède le début (comparaison `aaaammjj` par découpage), sans bloquer
  l'impression. `If Message.Warning(…) = 1 Then Endif` vide.
- **`Button2_Click()`** (CC 13) [handler] [mixte] :
  - SQL : `SELECT * FROM Fiches_Mvtexp WHERE daterecpt >= &1 and daterecpt <= &2 order by code`
    (dates `Utils.Cdate_Dbase`, `aaaammjj`) puis, par ligne, `SELECT * FROM Fiches_Art WHERE
    art_code = &1` (N+1 ; « Article inexistant » si absent). Noms de tables en dur (clés
    `TabMvtexp`, `TabArt` disponibles).
  - PDF `Carticles` : `Entete`, `Level11`, `Level12` par ligne, saut de page à 283 (`Footer` +
    `Entete` + `Level11`), `Ligne`, `Footer`, `Output`, `Visualiseur.Prog`.
  - Purge si `Effmvts` : `Message.Question` → relit la même sélection et exécute **`DELETE FROM
    Fiches_Mvtexp WHERE code = &1`** pour chaque ligne. ⚠️ Le filtre ne porte que sur le code
    article : **toutes** les régularisations de l'article sont supprimées, y compris hors période
    (perte de données, EDREGUL-A01). La question et le message « Les mouvements ont été effacés »
    s'affichent même quand aucun mouvement n'a été trouvé (EDREGUL-A02).
  - Résidus : `Shell "cd …"`, variables `p`, `Nbpage`, `dte` (affectée deux fois) inutiles.
- **`Button3_Click()`** [handler] [GUI] : `Try Kill "~/Regul.pdf"` (le PDF est en réalité dans
  `~/tmp/Regul.pdf` : suppression sans effet, EDREGUL-A04) puis fermeture.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.Observers`, `Utils.SetEditColor`, `Utils.Cdate_calc`,
  `Cdate_aff`, `Cdate_Dbase`, `Cdate_Aff`, `Utils.db`.
- Membres : `Filename`, `jour` (utile seulement dans `_New`), `son`, `PosY`, `PosX` (inutilisé).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire `ListeRegularisations(sDeb, sFin) As Result` et `PurgeRegularisations(sDeb, sFin)` du
  handler (EDREGUL-005) ; une jointure `LEFT JOIN Fiches_Art` à la place des N+1 lectures, avec
  `IsNull(art_design)` → « Article inexistant » (SQL modifié, sortie identique).
- `date1_LostFocus`/`date2_LostFocus` en `Private` (EDREGUL-003).

### Commonalisation avec d'autres fichiers

- **`Edregulprdc`** : même écran au titre, à la table (`Fiches_Mvtexpdc`), au tri (`mind, type,
  code`), au séparateur entre compositions et à la couleur de sortie de champ près. Proposition :
  un module commun (par ex. `EdMouvements`) avec `ImprimeMouvements(sTable, sTitre, sOrdre,
  bSeparateur)` et `PurgeMouvements(sTable, …)`, appelé par les deux écrans (les `.form` restent
  distincts). Même logique pour [`Edsdepots`](../../Depots/Edsdepots.class/architecture.md).
- **Saisie de période** (`Cmpt_KeyPress` + `date*_LostFocus`) : commune à `Edregulprdc`,
  `Edpaiement`, `Edsdepots` et ≈ 12 écrans (notes transverses) → helper de saisie de période.
- Purge des régularisations : [`Epurmvtexp`](../../Stock/Epurmvtexp.class/architecture.md) purge la
  même table par `mind` ; une purge unique par identifiant de ligne corrigerait A01 (voir
  anomalies).

### Réduction de portée

- `date1_LostFocus`, `date2_LostFocus` → `Private` (pseudo-handlers de contrôles groupés).

### Séparation traitement / GUI

- `Button2_Click` : sélection SQL et purge sans accès aux contrôles (dates passées en paramètre).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Mvtexp(daterecpt)` (filtre de période) et `(code)`.
- `qtep`/`qtem` stockés en `varchar(10)` : un type numérique éviterait les conversions.
