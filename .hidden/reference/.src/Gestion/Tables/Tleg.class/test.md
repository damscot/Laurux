# Tleg — Tests

> Source : `.src/Gestion/Tables/Tleg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Tleg`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TLEG-T01 | replay | Modification du texte | menu Réserve de propriété ; texte modifié avec `&` ; Enregistrer | UPDATE de `lind = 1`, `&` → `et` | `tests/modification/` | implémenté (jeu tleg_court) |
| TLEG-T02 | replay | Texte vide | texte effacé ; Enregistrer | aucune écriture | `tests/texte_vide/` | implémenté |
| TLEG-T03 | replay | Table sans ligne `lind = 1` | jeu dérivé avec une seule ligne `lind = 2` ; modification ; Enregistrer | nouvelle ligne insérée, affichage inchangé (A01 figée) | `tests/lind_absent/` | implémenté (lind auto = 9 : compteur AUTO_INCREMENT de Laurux01) |
| TLEG-T04 | replay | Lecture en facturation | facture imprimée après T01 | texte modifié repris sur le PDF (via `ObjFac`) | `tests/lecture_facture/` | implémenté (gb.test `TlegTest.T04LectureFacture` : texte enregistré par `Button2_Click` relu par `ObjFac.treserve` ; le PDF, imprimé par `ObjFacB`, n'est pas comparé) |

## Détail des tests

- **Données** : `Laurux01.sql` (une ligne `lind = 1`) ; jeu dérivé pour T03.
- **Comparaison** : dump normalisé de `Fiches_Tleg` ; T04 compare le texte extrait du PDF (à
  mutualiser avec les scénarios du lot Facturation).

- **Assets (phase 2)** : jeux `.hidden/Tests/Gestion/assets/tleg_shared/tleg_court.sql` (texte ABC) et `tleg_lind2.sql`
  (T03) ; scénarios `tleg_modification`, `tleg_texte_vide`, `tleg_lind_absent`.
