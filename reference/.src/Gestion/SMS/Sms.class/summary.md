# Sms — Synthèse

> Source : `.src/Gestion/SMS/Sms.class` · Synthèse des autres documents.

## Rôle

Écran de gestion des textes SMS prédéfinis (`Fiches_Sms` : code `numcom` sur 2 caractères et
`intitule`), ouvert par `Fmenu` › Textes SMS (menu masqué si `/Soc<XX>/Sms = 0`). Les textes sont
choisis ensuite dans `Gsm` pour un envoi unitaire.

## Points clés

- Copie de `ComMail` (textes de courriel) sans le mode « choix » ; l'en-tête cite encore
  `Comment.class`.
- Accès SQL par `Cbase.Table("TabSms")` ; `Catch` dans `Form_Open` si la table n'existe pas.
- Boutons regroupés dans `Btn` : `Button3_Click` est un handler inactif (code mort) ;
  `Button1/2/4_Click` ne sont appelés que par `Btn_Click`.
- Aucun envoi de SMS dans cet écran.

## Dépendances principales

- Utilise : `Utils` (`db`, `Observers`, `ReplaceLb`, `SetEditColor`), `Cbase`, `Doc`, `Start.Son`.
- Utilisé par : `Fmenu` (`Menu315_Click`) ; table partagée avec `Gsm`.

## Risques

- Suppression de la ligne sélectionnée au lieu du code saisi (A01).
- Erreur après UPDATE si le code est saisi sans sélection ; `Maj_Zones` sans test `Available` (A02).
- Toute touche sur Enregistrer enregistre (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 128 |
| Lignes de commentaire | 22 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 8 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 scénarios `replay` (SMS-T01 à T06) comparés sur le dump de `Fiches_Sms` : liste, création,
modification, suppression, table absente, touche sur Enregistrer. Jeu de données commun possible
avec ComMail.

## Rework

6 étapes sans changement de comportement (SMS-001 à 006) : documentation, code mort, UPDATE
simplifié (dump identique), module code/texte partagé avec ComMail/Comment, séparation
traitement/GUI, réduction de portée de 6 fonctions. 3 anomalies (SMS-A01 à A03).
