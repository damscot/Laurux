# calculdroit1 — Tests

> Source : `.src/Gestion/option/calculdroit1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul avec lecture SQL, sans GUI : tests `gbtest` sur base MariaDB jetable (jeu dérivé
`option_boisson`), valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCULDROIT1-T01 | gbtest | Drapeau `opt` | `Laurux.conf` : options N, B, P, T ; `New calculdroit1(10, 6, Arr_0001, "", "01", 75, 12.5, "")` | `opt` = True, True, True, False (A01 figée) | `tests/drapeau_option/` | à faire |
| CALCULDROIT1-T02 | gbtest | `volume_total` | vol 75 cl, deg 12,5, qte 6 ; vol 0 ; deg 0 | `PuBHT`, `PuNHT`, `TotBHT`, `TotNHT` | `tests/volume_total/` | à faire |
| CALCULDROIT1-T03 | gbtest | `taxe_droit` | régie `ap` vrai / faux, `tauxa` 1 800 | `Mnt` de référence | `tests/taxe_droit/` | à faire |
| CALCULDROIT1-T04 | gbtest | `secu_droit` | `degres` 18 ; deg 12,5 / 18 / 40 ; `degres` NULL | 0 / 0 / montant / 0 | `tests/secu_seuil/` | à faire |
| CALCULDROIT1-T05 | gbtest | `accise_droit` | `drfac` vrai / faux | montant du droit / 0 | `tests/accise/` | à faire |
| CALCULDROIT1-T06 | gbtest | Taxes de `LecDra` | régie suspendue / acquittée ; TVA 20 % ; `Cpt` | liste des taxes (`Regie`, `SS`, `DA`, `TVA`), `TotNTC.G`, `Cpt` | `tests/taxes_regie/` | à faire |
| CALCULDROIT1-T07 | gbtest | Erreurs de `LecDra` | régie absente ; TVA de régie absente ; `tvass` absente | texte d'erreur (« Too many arguments » figé pour l. 51/54, A02) | `tests/erreurs_regie/` | à faire |
| CALCULDROIT1-T08 | gbtest | Propriétés en écriture | `code`, `volume`, `degre` sur un objet avec régie ; `volume` sur un objet sans régie | taxes recalculées ; erreur « Null object » figée (A03) | `tests/ecriture_proprietes/` | à faire |
| CALCULDROIT1-T09 | gbtest | Propriétés `droit`, `secu`, `accise`, `suspendu`, `drsurfac`, `code` | régie complète ; `dra` vide | valeurs et `Null`/`False` de référence | `tests/proprietes_lecture/` | à faire |
| CALCULDROIT1-T10 | replay | Moulinage caisse avec articles à droits | option T, tickets d'articles à régie `drfac` vrai et faux ; moulinage | dump `Fiches_HistoLigfac` (`netht`, `nettc`, `pu`, `brut`, `rem`) | `tests/moulinage_droits/` | à faire |

## Détail des tests

- **Données** : jeu dérivé `option_boisson` (voir `Consigne/test.md`) avec deux régies (`ap` vrai et
  faux, suspendue et acquittée, `drfac` vrai et faux), `Fiches_Parametres.tvass` renseigné, et un
  jeu sans `tvass` pour T07.
- **Configuration** : T01 fait varier `/Soc01/bois` et `/Soc01/pp` dans le `Laurux.conf` du test ;
  les autres tests utilisent l'option `T` (seule à activer les calculs, A01).
- **Comparaison** : tolérance 1e-9 sur les Float ; T10 compare le dump normalisé.
- **T10** relève du lot Caisse : scénario à faire valider avec ceux de `Moulinage` (module complexe).
