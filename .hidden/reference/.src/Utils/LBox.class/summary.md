# LBox — Synthèse

> Source : `.src/Utils/LBox.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Boîte de dialogue modale de saisie générique à cinq modes : champ contrôlé (`TextReg`), texte
libre, éditeur de liste, liste à sélection multiple avec filtre par expression régulière, sélection
de fichiers. Le résultat est écrit dans un objet transporteur (`LTrans`) ou dans le champ d'entrée.

## Points clés

- Classe GUI ; utilisée par la GED (`GedR`, `LGed`).
- `ShowModal` renvoie `True` en cas d'annulation.
- Écriture du résultat par accès dynamique (`$obj.Text` / `$obj.List`).
- Constructeur appelé avec le parent de fenêtre en 3e argument (convention Gambas des formulaires
  hérités).

## Dépendances principales

- Utilise : `TextReg` (contrôle et objet d'entrée), `Start.son`.
- Utilisé par : `GedR` (4 appels), `LGed` (1 appel).

## Risques

- Faibles ; code dupliqué dans `UpdateOut` et `ListSelection`.
- Propriétés `L`/`T` et événement `MajOut` sans usage (`L_Read` défaillant en mode texte).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 181 |
| Lignes de commentaire | 6 |
| Fonctions | 12 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 46 |
| Complexité max (fonction) | 11 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 scénarios `replay` (LBOX-T01 à T06) couvrant les modes utilisés, l'annulation et le filtre
invalide, mutualisés avec les tests GED.

## Rework

4 étapes (LBOX-001 à 004) : documentation, factorisation d'`UpdateOut` et de la sélection,
réduction de portée. 1 anomalie latente (LBOX-A01).
