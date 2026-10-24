# ObjProp — Synthèse

> Source : `.src/Utils/ObjProp.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Descripteur de contrôle : liste de (propriété, valeur, format) appliquée par réflexion à un
contrôle, utilisée par les écrans génériques (`TriGen` et dérivés, `SaiTableau`/`Sailig`, `Achat`,
`GesTar`, `Parametre`) ; et, en mode `Param`, stockage des paramètres et de l'historique de saisie
des `TextReg` dans `~/.config/gambas3/Laurux-AutoParams-<société>.conf`.

## Points clés

- `Object.SetProperty`/`GetProperty` : dépendances invisibles vers les propriétés de `TextReg` et
  des contrôles.
- Formatage numérique ou date du texte appliqué (`frmt`), `"#Error"` en cas d'échec.
- Historique MRU de 10 valeurs par contrôle.
- Code mort : `CondFilter_Read`, branche `Utils.CDec`, `AjoutCondfilter`/`CondFilter` sans
  appelant.

## Dépendances principales

- Utilisé par 21 fichiers (écrans `Tri*`, `Achat`, `GesTar`, `SaiTableau`, `Sailig`, `TextReg`…).
- Utilise `LDate`, `Start.Societe`, un fichier de configuration dédié.
- Dépendance circulaire avec `TextReg`.

## Risques

- Renommer une propriété de `TextReg` casse `ObjProp` sans erreur de compilation.
- Historique initial de 10 lignes vides (A01) ; sauvegarde conditionnelle (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 1 |
| Fonctions | 19 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 45 |
| Complexité max (fonction) | 9 (`frmt`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 `gbtest` (constructeur, champs, formats, lecture/écriture des paramètres, propriété `filter`)
et 1 `replay` des écrans génériques.

## Rework

5 étapes (OBJPROP-001 à 005) : documentation, code mort, helper de jonction, réduction de portée,
extraction de `FormatTexte` et `MajHistorique`. 2 anomalies (A01, A02).
