# textfamille — Rework

> Source : `.src/Utils/textfamille.class` · Message de commit (phase 4) : `reference/.src/Utils/textfamille.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 107 |
| Lignes de commentaire | 4 |
| Fonctions | 9 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 7 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 107 | 27 | 7 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TEXTFAMILLE-001 — [documentation] En-tête : rôle, dépendance à `ipr`, API publique (`text`,
  `Clear`, `setfocus`, `Select`, événements) et sémantique de `KeyPress` par zone · appelants :
  aucun · tests : aucun · sources : [textfamille.class:_new](../../../../.src/Utils/textfamille.class#L14-L44), [textfamille.class:codefam_keypress](../../../../.src/Utils/textfamille.class#L63-L88)
- [ ] TEXTFAMILLE-002 — [code mort] Supprimer le calcul de hauteur sans effet (`haut`) et la ligne
  commentée de `setfocus` ; variable `rz` conservée · tests : T01 · sources : [textfamille.class:41-42](../../../../.src/Utils/textfamille.class#L41-L42), [textfamille.class:setfocus](../../../../.src/Utils/textfamille.class#L90-L95)
- [ ] TEXTFAMILLE-003 — [complexité] Helper privé `Longueur(i)` pour les 3 calculs de longueur de
  niveau · tests : T01-T03 · sources : [textfamille.class:_new](../../../../.src/Utils/textfamille.class#L14-L44), [textfamille.class:text_Read](../../../../.src/Utils/textfamille.class#L113-L135), [textfamille.class:text_Write](../../../../.src/Utils/textfamille.class#L137-L150)
- [ ] TEXTFAMILLE-004 — [séparation traitement/GUI] Fonctions pures `Decoupe`/`Assemble` utilisées
  par `text_Write`/`text_Read` · tests : T02, T03 · sources : [textfamille.class:text_Read](../../../../.src/Utils/textfamille.class#L113-L135), [textfamille.class:text_Write](../../../../.src/Utils/textfamille.class#L137-L150)
- [ ] TEXTFAMILLE-005 — [commonalisation] Lecture/validation d'`ipr` commune avec `Trifam` (voir
  TRIFAM-004, même message et même `Quit`) · appelants : `Trifam` · tests : T06 · sources : [textfamille.class:22-27](../../../../.src/Utils/textfamille.class#L22-L27), [Trifam.class:_new](../../../../.src/Utils/Trifam.class#L25-L91)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TEXTFAMILLE-A01 — [anomalie] `ipr` absent → `Quit` à l'ouverture de n'importe quel écran
  contenant le contrôle · tests : T06 · sources : [textfamille.class:24-27](../../../../.src/Utils/textfamille.class#L24-L27)
- [ ] TEXTFAMILLE-A02 — [anomalie] `text_Read` : `Trim$` final supprime les espaces de tête quand le
  premier niveau est vide (code décalé, à confirmer) · tests : T03 · sources : [textfamille.class:134](../../../../.src/Utils/textfamille.class#L134)
