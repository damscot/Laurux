# numtostring — Synthèse

> Source : `.src/Caisse/numtostring.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Conversion d'un entier (1 à 6 chiffres, en chaîne) en toutes lettres pour l'impression des
chèques en caisse (`Caisse.Imp_Cheque`). Identifiants `NUMTOSTRING_CAISSE-*` (le nom
`NUMTOSTRING` appartient à `Utils/Numtostring.module`).

## Points clés

- **Jamais exécuté** : homonyme à la casse près de `Utils/Numtostring.module`, un seul
  `.gambas/NUMTOSTRING` est compilé (version `Utils`, vérifié par `strings` dans les deux clones).
  `Caisse.class:5064-5154` appelle `numtostring.nbtostring`, absent du module chargé.
- Calcul pur, 3 fonctions, CC 62 pour `nbtostring` (3 branches identiques pour 4, 5 et 6 chiffres).
- Découpe des nombres par `Str()`/`InStr(",")` : dépend de la locale française.

## Dépendances principales

- Appelé (en théorie) par `Caisse.Imp_Cheque` et `Caisse.Imp_Cheque1` ; `FRelFacture:464` vise en
  réalité `Utils/Numtostring`.
- Aucune dépendance sortante.

## Risques

- Impression des chèques en caisse en erreur (« Unknown symbol », A01).
- Si le module est réactivé : orthographe fautive (A02), centimes « 01 » vides et entrées hors
  bornes silencieuses (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 62 (`nbtostring`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests (NUMTOSTRING_CAISSE-T01 à T06) : constat de la collision de compilation, caractérisation
de `nbtostring` dans un projet Gambas minimal (0-99, centaines/milliers, bornes, locale `C`) et
replay de l'impression d'un chèque en caisse.

## Rework

3 étapes (documentation, fusion des branches 4-6 chiffres, réduction de portée), utiles seulement
si le module est conservé. 3 anomalies (A01 collision de noms à trancher en premier, A02
orthographe, A03 contrôle d'entrée et locale).
