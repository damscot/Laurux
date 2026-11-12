# FTvav — Tests

> Source : `.src/Compta/Tables/FTvav.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie avec traitement de masse : `replay` avec diff des tables, `gbtest` sur l'arrondi
extrait (FTVAV-005). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTVAV-T01 | replay | Création d'un code | menu TVA ventes ; code `4`, taux `10`, compte `445740` (clic Enregistrer) | ligne ajoutée dans `Fiches_Tvaav` ; question de recalcul répondue Non | `tests/creation/` | implémenté (taux enregistré vide après « Non », figé) |
| FTVAV-T02 | replay | Modification de taux sans recalcul | code `3`, `20` → `21`, réponse Non | taux restauré (`20,00`) puis enregistrement inchangé | `tests/modif_sans_recalcul/` | implémenté |
| FTVAV-T03 | replay | Modification de taux avec recalcul | code `3`, `20` → `21`, réponse Oui | diff de `Fiches_Tvaav`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Art`, `Fiches_Mo` | `tests/modif_avec_recalcul/` | implémenté (jeu `ftvav_recalcul`) |
| FTVAV-T04 | replay | Compte TVA déjà attribué | code `4` avec le compte du code `3`, nouveau taux, Oui | refus d'enregistrement **après** recalcul (A01 figée) | `tests/compte_deja_attribue/` | implémenté (A01 figée) |
| FTVAV-T05 | replay | Suppression, clavier, liste | suppression refusée/acceptée ; touche quelconque sur Enregistrer ; F2 sur le compte | diff `Fiches_Tvaav` ; enregistrement sans recalcul (A02) ; contenu de `Tvavlist` | `tests/suppression_clavier/` | implémenté (partiel : F2/liste `Tvavlist` non rejouable) |
| FTVAV-T06 | gbtest | `ArrondiPrix` (après FTVAV-005) | prix `12.48`, `12.43`, `12.20`, `12.80`, `0`, négatif × arrondis `0,01`/`0,05`/`0,10`/`0,50`/`1,00` × formats `0`/`0.00`/`0.000` | chaînes de référence | `tests/arrondi/` | à faire : exige l'extraction FTVAV-005 (`arrondi` travaille sur des membres privés) |
| FTVAV-T07 | replay | Performance du recalcul | base dérivée : 5 000 lignes de BL non facturés au code `3` | durée de référence (`gbx3 -p`) ; dump identique au clone de référence | `.hidden/Tests/Compta/assets/ftvav_perf_recalcul/` | implémenté (rejeu et dump dans le délai de 20 s, recalcul de 5 000 lignes ≈ 2 s ; mesure gbx3 -p hors runner) |

## Détail des tests

- **Données** : `Laurux01.sql` ; jeu dérivé pour T03/T04/T07 (script SQL) : familles, articles
  avec arrondis `0,05` et `0,50`, main-d'œuvre, BL et bons d'entretien non facturés avec lignes `A`
  et `M` au code `3`.
- **Comparaison** : dump normalisé des tables listées ; T06 compare des chaînes exactes (la virgule
  dépend de la locale `fr_FR.UTF-8`, imposée par le harnais).
- **Non testable** : erreur de `Recalcul` sur un article supprimé référencé par un bon d'entretien
  (A04) sauf jeu dédié ; son et couleurs.
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Compta/assets/ftvav_creation`, `ftvav_modif_sans_recalcul`,
  `ftvav_modif_avec_recalcul`, `ftvav_compte_deja_attribue`, `ftvav_suppression_clavier` ; jeu
  `.hidden/Tests/Compta/assets/ftvav_shared/ftvav_recalcul.sql` (articles `TV05` arrondi 0,05 et `TV50` arrondi 0,50 au code 3, BL `900001` et bon
  d'entretien `900002` non facturés avec lignes A/M au code 3 et une ligne au code 2, code TVA 5 inutilisé).
  Saisie du taux : le texte n'est pas sélectionné au focus, il est effacé par 5 × BackSpace.
- **Observé (figé)** : T01 — « Non » restaure `Txtva2` (vide pour un nouveau code) : le code 4 est inséré avec
  `taux_tva = ''`. T03 — `nettc_ligbl` écrit avec une virgule et sans arrondi (`'12,5475'` pour l'arrondi 0,05,
  `'10,050'` pour 0,50) alors que les lignes M reçoivent `'42.35'` ; `art_pvttc = 0` pour l'article `003` (prix
  HT nul). T04 — Recalcul exécuté (requêtes au code 4) puis refus, rien n'est enregistré (A01). T05 — la touche
  sur Enregistrer enregistre le code 1 sans question (A02). F2 (liste des comptes) non rejouable.
- **FTVAV-T07 (vague 2 bis, délais)** : scénario `ftvav_perf_recalcul` (mêmes événements que T03), jeu
  `ftvav_perf_recalcul.sql` : 500 BL non facturés × 10 lignes au code 3 (4 × `TP05` arrondi 0,05, 4 × `TP50`
  arrondi 0,50, 2 × main-d'oeuvre `04`), générés par les tables de séquences de MariaDB (`seq_1_to_N`). 5 000
  `UPdate Fiches_Ligbl` dans `sql.log` (attendus ≈ 1,7 Mo). Durée du rejeu ~14 s contre ~12 s pour T03 (recalcul
  ≈ 2 s) : délai standard de 20 s. La mesure fine (`gbx3 -p`) reste hors runner.
