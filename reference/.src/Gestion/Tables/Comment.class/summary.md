# Comment — Synthèse

> Source : `.src/Gestion/Tables/Comment.class` · Synthèse des autres documents.

## Rôle

Écran de la table des commentaires de facturation (`Fiches_Commentaires`), appelé depuis le menu
et depuis la saisie de facture (F4).

## Points clés

- Squelette partagé avec ComMail (similarité 0,89) et proche de FPostes/FLibelle (Compta).
- Lecture via `Cbase.Table("TabCom")`, écritures avec le nom en dur.
- Liste : seule la première ligne de chaque texte est affichée.
- Code mort : `Button3_Click` (handler inactif, bouton groupé), branche `Case 2` de `Lib_KeyPress`.
- `Btn_KeyPress` : toute touche sur Enregistrer enregistre.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.ReplaceLb`, `Utils.SetEditColor`, `Cbase`, `Doc`.
- Utilisé par : `Fmenu` (`Show`), `Facture` (F4, `ShowModal`) ; table lue par `Facture`, `Dup`.
- `MvtProdcomp.RazBl` appelle `Comment.clear` sur ce formulaire : appel latent, `RazBl` n'est jamais
  appelée (vérifié dans le lot Stock, MVTPRODCOMP-002).
- `colcol_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : suppression de la ligne sélectionnée ; A02 : erreur après UPDATE sans sélection ;
  A03 : `ReplaceLb` altère le texte.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 125 |
| Lignes de commentaire | 28 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 34 |
| Complexité max (fonction) | 7 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création multiligne, modification, modification sans sélection, suppression, appel
depuis la facture) avec diff de `Fiches_Commentaires`.

## Rework

7 étapes (001 à 007) : documentation, code mort, `Cbase.Table`, UPDATE simplifié, module partagé
avec ComMail, séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
