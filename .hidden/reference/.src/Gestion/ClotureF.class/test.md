# ClotureF — Tests

> Source : `.src/Gestion/ClotureF.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module à risque (clôture) : la liste de scénarios ci-dessous est à **valider par l'utilisateur**
avant la phase 2 (règle « modules complexes » de PLAN.md).

Scénarios validés par l'utilisateur le 2026-11-16 : T04-T07 ; T01-T03 en attente de la validation d'ObjFacB ; T08 après extraction.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CLOTUREF-T01 | replay | Clôture nominale | jeu dérivé : `dtepec = 03.2026`, 3 factures imprimées (`imp=1`, `type='F'`) dans `Fiches_Bl` datées de mars, 1 non imprimée, 1 d'avril ; Fmenu → Clôture mensuelle facturation → Lancer → Oui | dump de `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Parametres` (`dtepp`, `dtepec`), `Fiches_Comptes.solde` identique à la référence | `tests/cloture_nominale/` | à faire : passe par ObjFacB (module complexe, non validé par l'utilisateur le 2026-11-16) |
| CLOTUREF-T02 | replay | Factures « entretien » et borne de fin de mois | facture `Fiches_BlM` datée du dernier jour du mois et une du jour précédent ; idem dans `Fiches_Bl` | dump identique (fige l'anomalie A01 : la `BlM` du dernier jour reste non archivée) | `tests/borne_fin_mois/` | à faire : passe par ObjFacB (module complexe, non validé par l'utilisateur le 2026-11-16) |
| CLOTUREF-T03 | replay | Facture déjà archivée | même `numfac` présent dans `Fiches_HistoFac` et dans `Fiches_Bl` | avertissement de `transblfac` acquitté ; facture non transférée ; période avancée malgré tout | `tests/deja_archivee/` | à faire : passe par ObjFacB (module complexe, non validé par l'utilisateur le 2026-11-16) |
| CLOTUREF-T04 | replay | Refus de la confirmation | Lancer → Non | aucune modification de la base (dump identique au dump initial) ; fenêtre fermée | `tests/annulation/` | implémenté |
| CLOTUREF-T05 | replay | Recalcul des soldes | écritures validées et non validées sur 3 comptes, solde initial faux | `Fiches_Comptes.solde` = Σ(débit − crédit) des écritures validées de `Fiches_Mvt` | `tests/recalcul_soldes/` | implémenté |
| CLOTUREF-T06 | replay | Décembre → janvier | `dtepec = 12.2025` | `dtepp = 12.2025`, `dtepec = 01.2026` | `tests/changement_annee/` | implémenté |
| CLOTUREF-T07 | replay | Paramètres vides / dates nulles | `dtepec` nul ou `00.0000` | affichage de la période courante (`Now`, horloge figée) ; fige le comportement actuel | `tests/dates_nulles/` | implémenté |
| CLOTUREF-T08 | gbtest | Calcul « période suivante » | après séparation (CLOTUREF-006) : `03.2026`, `12.2025`, `01.2026` | `04.2026`, `01.2026`, `02.2026` | `tests/periode_suivante/` | à faire : après extraction CLOTUREF-006 |

## Détail des tests

- **Valeurs attendues** : chaque replay est joué dans le clone **Laurux non modifié**, sur MariaDB
  Docker, et le dump normalisé est capturé dans `tests/<nom>/expected/`.
- **Données** : `Laurux01.sql` ne contient pas de facture imprimée non archivée ; un jeu dérivé
  (`tests/<nom>/*.sql`) ajoute les BL/factures, lignes et écritures nécessaires. Prévoir des
  factures avec matériel (`Fiches_Materiels`) pour couvrir la mise à jour `mat_bl` de
  `transblfac`.
- **Horloge** : `Aff_date` et `ObjFacB` utilisent `Now` → figer l'horloge (faketime) pour T07.
- **Non testable automatiquement** : le cas « table des paramètres vide » termine l'application
  (`Quit`) ; il est documenté et vérifié manuellement. L'interruption via la `ProgBar` n'est pas
  disponible (barre non interruptible).

### Implémentation (phase 2, vague 8)

Ouverture : Fmenu → Gestion → Clôture mensuelle (`Menu147`, `ClotureF.ShowModal`), date figée 2018-06-15 ;
les scénarios ne finissent pas par Quitter (l'écran se ferme lui-même : `Me.Close` de `Calc_solde`, `Try Me.Close`
de `Button1_Click`). Jeux partagés `.hidden/Tests/Gestion/assets/cloturef_shared/` : aucune facture imprimée
(`Fiches_Bl`/`Fiches_BlM` vides dans Laurux01), la boucle `Maj_Archives` n'appelle donc pas ObjFacB (vérifié dans
`sql.log` : seul le `SELECT … UNION ALL …` sur `Fiches_Bl`/`Fiches_BlM`, aucune requête `HistoFac`/`Ligbl`).

| Test | Scénario (`.hidden/Tests/Gestion/assets/…`) | Jeu | Vérification |
|---|---|---|---|
| T04 | `cloturef_annulation` | `soldes_faux` | Message.Question bouton 2 « Non » (Tab, Espace) : aucune écriture, sql.log comparé (`ordered`) |
| T05 | `cloturef_recalcul_soldes` | `soldes_faux` (dtepec 05.2018 ; 4 comptes à solde faux, écritures validées et non validées) | `dtepp` 05.2018, `dtepec` 06.2018 ; soldes 411001 = 120, 401001 = -180, 512000 = 224.5, 706100 (non validées seules) = 0 |
| T06 | `cloturef_changement_annee` | `decembre` (dtepec 12.2017) | `dtepp` 12.2017, `dtepec` 01.2018 |
| T07 | `cloturef_dates_nulles`, `cloturef_dates_zero` | `dates_nulles` (NULL), `dates_zero` (`00.0000`) | période courante prise sur `Now` figé : `dtepp` 06.2018, `dtepec` 07.2018 (le libellé affiché n'est pas comparé : effet vérifié par la clôture confirmée) |
