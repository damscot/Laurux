# Edpaiement — Architecture

> Source : `.src/Gestion/Impressions/Edpaiement.class` (+ `Edpaiement.form`)

## Vue d'ensemble

Écran modal « Impression des paiements d'une journée » (menu `Menu194`, `Fmenu.class:1805`,
`ShowModal`). Pour une **date de facture** donnée, il liste les règlements portés par les
documents facturés (`reg`/`mtreg` et `reg2`/`mtreg2` de `Fiches_Bl` et/ou `Fiches_BlM`), regroupés
par mode de règlement, avec un total par mode. Sortie `~/tmp/Regl.pdf` (classe `Cbordereaux`).

Le choix de la table dépend de trois boutons radio du panneau `Panel1`, visible seulement si
l'option matériel/entretien est active (`/Soc<XX>/Materiel`) : `Fact` (toutes, par défaut,
`UNION`), `Face` (entretien, `Fiches_BlM`), `Facn` (hors entretien, `Fiches_Bl`).

La liste passe par une **table de travail `Paiements`** (supprimée puis recréée à chaque
impression, hors `db_control.csv`, sans clé Cbase), relue triée par mode puis numéro, avant une
nouvelle lecture du document pour chaque règlement.

Boutons du `.form` sans handler : `Button1` (aide), `Button6`.

Nature : **mixte** ; `Button2_Click` (CC 29, 140 lignes) concentre tout.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `pdf` | var | Private |  | Cbordereaux | 32 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-45 | Public | 2 | 10 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 50-68 | Public | 6 | 12 | 0 | handler GUI |
| `Cmpt_GotFocus` | 73-79 | Public | 1 | 5 | 0 | handler GUI |
| `date1_LostFocus` | 81-93 | Public | 3 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 95-100 | Public | 3 | 4 | 0 | handler GUI |
| `Button2_Click` | 102-246 | Public | 29 | 140 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [méthode spéciale] [GUI] : `Utils.Observers(Me)`, `date1` = aujourd'hui, `Panel1`
  visible si `/Soc<XX>/Materiel`.
- **`Cmpt_KeyPress()`** [handler du groupe `Cmpt`, `Date1` tag 1] [GUI] : Entrée/Retour/Tab →
  `date1_LostFocus()` ; F1 neutralisé.
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`date1_LostFocus()`** [portée : réductible] [GUI] : pseudo-handler (contrôle groupé, appelé
  seulement par `Cmpt_KeyPress`) ; normalise la date (`Cdate_calc`/`Cdate_aff`).
- **`Button3_Click()`** [handler] : supprime `~/tmp/Regl.pdf` s'il existe, ferme.
- **`Button2_Click()`** (CC 29) [handler] [mixte] :
  1. `SELECT * FROM Fiches_Parametres` (sans test `Available`) → devise (`Euros` si nulle).
  2. `DROP TABLE IF EXISTS Paiements` puis `CREATE TABLE Paiements (numero, type, montant, lind
     auto)` (`Utils.db.AutoIncrement`/`Engine`).
  3. Documents de la date : `SELECT * FROM Fiches_Bl WHERE dtefac = &1 UNION SELECT * FROM
     Fiches_BlM WHERE dtefac = &1 order by reg, numfac` (ou une seule table selon le bouton).
     ⚠️ `dtefac` est un `datetime` : l'égalité avec `aaaammjj` exclut les documents dont la date de
     facture porte une heure (ex. factures de caisse écrites par `Moulinage` avec `LDate.DT`) —
     à confirmer (EDPAIEMENT-A01).
  4. Un `INSERT INTO Paiements` par règlement non nul (`reg`, puis `reg2`).
  5. `SELECT * FROM Paiements order by type, numero` ; pour chaque ligne, relecture du document par
     `numbl` (même choix de table ; en mode `Fact`, `UNION` des deux tables : un numéro présent
     dans `Fiches_Bl` **et** `Fiches_BlM` imprimerait les deux documents, à confirmer,
     EDPAIEMENT-A02).
  6. PDF : à chaque changement de mode, `Ligne`, total du mode (`Level3`, libellé singulier ou
     pluriel construit deux fois à l'identique), `footer`, nouvel en-tête `EnteteP` + `Level1` ;
     ligne `level2(code client, nom, n° facture, TTC facture, montant réglé)` ; saut de page à
     288. La branche « Aucun mouvement » à l'intérieur de la boucle est **inatteignable**
     (`Nbrglt` vaut au moins 1 quand le mode change).
  7. `Output`, `Visualiseur.Prog` ; sinon message « Aucun mouvement ».
  Résidus : `Shell "cd …"`, `p`, `Nbpage`, `dte`, lignes `INSERT` commentées.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Materiel"]`, `Start.Son`, `Start.Musique`.
- `Utils.Observers`, `SetEditColor`, `Cdate_*`, `cpoint`, `Utils.db` (`AutoIncrement`, `Engine`).
- Table de travail globale `Paiements` : deux postes qui impriment en même temps se la disputent.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la table de travail par une liste en mémoire triée (mode, numéro) : supprime le DDL à
  chaque impression et la collision multi-poste (SQL modifié ; dump identique hors table de
  travail `Paiements`, à exclure du dump normalisé) — EDPAIEMENT-006.
- Extraire `LibelleTotal(n, mode, total, devise)` (deux copies) et `NouvellePage(mode)` (trois
  copies) ; supprimer la branche inatteignable (EDPAIEMENT-004).

### Commonalisation avec d'autres fichiers

- Saisie de date (`Cmpt_KeyPress`, `date1_LostFocus`) commune avec
  [`Edregul`](../Edregul.class/architecture.md), [`Edregulprdc`](../Edregulprdc.class/architecture.md)
  et les autres écrans de période.
- Lecture de la devise (`Fiches_Parametres.devise`, défaut « Euros ») : répétée dans plusieurs
  éditions ; un accesseur commun (ex. `Utils.Devise()`) serait à recenser en phase 3.

### Réduction de portée

- `date1_LostFocus` → `Private`.

### Séparation traitement / GUI

- `ReglementsDuJour(sDate, iSource) As Collection` (SQL), puis impression ; le handler garde les
  messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les règlements sont dénormalisés dans `Fiches_Bl` (`reg`, `reg2`) : une table de règlements par
  document (ou l'usage de `Fiches_Reglements`/`Fiches_Acomptes`) permettrait une seule requête
  groupée.
- Index sur `Fiches_Bl(dtefac)` / `Fiches_BlM(dtefac)`.
