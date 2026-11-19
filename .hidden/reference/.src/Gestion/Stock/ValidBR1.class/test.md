# ValidBR1 — Tests

> Source : `.src/Gestion/Stock/ValidBR1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Module complexe** (validation comptable des réceptions) : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle.

`replay` avec diff de `Fiches_Entrecpt` (`validee`), `Fiches_Mvt` (écritures générées),
`Fiches_Comptes` (soldes), `Fiches_Parametres` (numéros d'écriture), `Docs_Ged`/`Docs_Tag`. Les
valeurs attendues sont produites dans le clone **Laurux non modifié** (anomalies figées).
L'écran n'appelle pas `Utils.Observers` : la capture suppose une instrumentation par le harnais
ou la correction VALIDBR1-A06 (à décider en phase 2).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDBR1-T01 | replay | Validation seule | 1 fournisseur, 2 BR non validées ; clic fournisseur ; « Validation Seule » | `validee = 2` pour les 2 BR ; aucune écriture | `tests/vbr_seule/` | implémenté (gb.test `ValidBR1Test.T01ValidationSeule` : écran instancié, clic fournisseur remplacé par `TriFou_majsel` ; jeu `validbr1_shared/receptions`) |
| VALIDBR1-T02 | replay | Validation + compta | 2 fournisseurs (dont 1 exonéré), lignes de 2 familles et 2 taux de TVA ; date et libellé saisis ; « Validation + Compta » | `validee = 1` ; écritures `Fiches_Mvt` (comptes d'achat, TVA, fournisseur), soldes, texte de `~/tmp/EcrBr.pdf` | `tests/vbr_compta/` | implémenté (gb.test `T02ValidationCompta` : 8 lignes `Fiches_Mvt`, `~/tmp/EcrBr.pdf` produit ; texte du PDF non relevé (édition gb.report)) |
| VALIDBR1-T03 | replay | Désélection d'une BR | fournisseur à 3 BR, clic sur une BR pour la retirer ; « Validation Seule » | 2 BR validées, 1 restante ; totaux de la grille | `tests/vbr_deselection/` | implémenté (gb.test `T03Deselection` : `TriBr_majsel` reçoit la Collection construite comme `TriGen.Coltri_Click`) |
| VALIDBR1-T04 | replay | Filtres | radios `brval` puis `Valid` avant sélection ; sélection d'un fournisseur ; tentative de changer de radio | listes affichées ; radios désactivés après sélection (figé) | `tests/vbr_filtres/` | implémenté (gb.test `T04Filtres` : listes relues dans la GridView de `lesfour`/`lesbr` ; après sélection, le radio `br` change mais le filtre reste, figé) |
| VALIDBR1-T05 | replay | Double validation | T02 puis second clic « Validation + Compta » sans fermer | état actuel figé (écritures en double attendues, A03 à confirmer) | `tests/vbr_double/` | implémenté (gb.test `T05DoubleValidation` : second clic → écriture n° 2 identique à la n° 1, A03 confirmée et figée) |
| VALIDBR1-T06 | replay | Option boissons | base `B`, BR avec palettes/colis consignés | ligne de consigne fournisseur (`consfou`) dans l'écriture | `tests/vbr_consignes/` | à faire : option boissons (base `B`, consignes palettes/colis via `Consigne.recuppalette`) : jeu à construire, non commencé en vague 9 |
| VALIDBR1-T07 | replay | Compte de famille absent | famille sans `compt3_fam` valide | erreur « Compte comptable inconnu » (`Error.Raise`), état de la base figé | `tests/vbr_compte_inconnu/` | implémenté (gb.test `T07CompteInconnu` : `Compte comptable inconnu : 999999` levée, aucune BR validée) |
| VALIDBR1-T08 | replay | Scan GED | GED active, fournisseur `fo_copie`, code fournisseur alphanumérique ; « GED (scan facture) » puis annuler | document GED (montants HT/TTC inversés, A02 figée) ; tags (erreur SQL possible, A04) | `tests/vbr_ged/` | à faire : scan GED (`LGed.ShowModal`, `fo_copie`) : non commencé en vague 9 |
| VALIDBR1-T09 | replay | Validation depuis `commande1` | `commande1`, réception relue, « Valider les factures », date, « Avec écriture » | `validee = 1`, écriture ; libellé par défaut et date GED de l'auto-instance (A05 figée) | `tests/vbr_depuis_commande1/` | implémenté (gb.test `ValidBR1Test.T09Ecritures` : `ValidBR1.Ecritures` appelé sur l'auto-instance avec les arguments de `commande1.rececp_Click` « Avec écriture » ; libellé par défaut « Réception n° R00001 du 15.06.2018 » ; parcours complet depuis commande1 : COMMANDE1-T04) |
| VALIDBR1-T10 | replay | Ouverture d'une réception | double-clic sur une BR (radio `Valid` puis `br`) | `commande1` ouvert en état Validée / Réception (voir COMMANDE1-T10) | `tests/vbr_ouvre_reception/` | à faire : essai vague 9 en gb.test (`TriBr_Activate` appelé avec la Collection de la BR, jeu `validbr1_shared/receptions`) : délai dépassé à l'ouverture de `Commande1`, cause non identifiée (le jeu a des `pbht` NULL que `Achat.LitCommande` lit en Float ; reprendre avec `commande1_shared/receptions`) ; ouverture couverte côté commande1 par COMMANDE1-T10 |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `receptions.sql` (3 fournisseurs dont un exonéré et
  un avec `libel_def`/`tag_def`, BR non validées et validées sans compta, familles avec
  `compt3_fam`, `Fiches_Tvaac`, `jrnal5` renseigné) ; base `B` pour T06.
- **Horloge** : `datej` saisi explicitement ; `Now` du pied de page des PDF exclu de la
  comparaison.
- **Comparaison** : dump normalisé des tables listées (numéros d'écriture comparés en valeur,
  `Sha1` éventuel masqué selon la convention d'`EcrAuto`) ; texte des PDF (`pdftotext`).
- **Non testables automatiquement** : scanner (T08 : la fenêtre `LGed` est annulée) ; son.
- **Implémentation (vague 9)** : module `.src/Tests/Gestion/ValidBR1Test.test`, jeu `.hidden/Tests/Gestion/assets/validbr1_shared/receptions.sql` (401001 : 3 BR sur deux familles et deux taux ; 401002 exonéré ; 401003 BR déjà validée sans compta ; 401004 famille 03 à compte d'achat `999999`). Date d'écriture 15.06.2018.
- **gbtest** : `ajouligne` (cumul débit/crédit d'un `VarEcr`) est un calcul pur sur `VarEcr` à
  la lecture d'un compte près : testable en gb.test après VALIDBR1-003.
