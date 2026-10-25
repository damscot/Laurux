# ValidBR1 — Tests

> Source : `.src/Gestion/Stock/ValidBR1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Module complexe** (validation comptable des réceptions) : **cette liste de scénarios est à faire
valider par l'utilisateur avant la phase 2** (PLAN.md §0).

`replay` avec diff de `Fiches_Entrecpt` (`validee`), `Fiches_Mvt` (écritures générées),
`Fiches_Comptes` (soldes), `Fiches_Parametres` (numéros d'écriture), `Docs_Ged`/`Docs_Tag`. Les
valeurs attendues sont produites dans le clone **Laurux non modifié** (anomalies figées).
L'écran n'appelle pas `Utils.Observers` : la capture suppose une instrumentation par le harnais
ou la correction VALIDBR1-A06 (à décider en phase 2).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDBR1-T01 | replay | Validation seule | 1 fournisseur, 2 BR non validées ; clic fournisseur ; « Validation Seule » | `validee = 2` pour les 2 BR ; aucune écriture | `tests/vbr_seule/` | à faire |
| VALIDBR1-T02 | replay | Validation + compta | 2 fournisseurs (dont 1 exonéré), lignes de 2 familles et 2 taux de TVA ; date et libellé saisis ; « Validation + Compta » | `validee = 1` ; écritures `Fiches_Mvt` (comptes d'achat, TVA, fournisseur), soldes, texte de `~/tmp/EcrBr.pdf` | `tests/vbr_compta/` | à faire |
| VALIDBR1-T03 | replay | Désélection d'une BR | fournisseur à 3 BR, clic sur une BR pour la retirer ; « Validation Seule » | 2 BR validées, 1 restante ; totaux de la grille | `tests/vbr_deselection/` | à faire |
| VALIDBR1-T04 | replay | Filtres | radios `brval` puis `Valid` avant sélection ; sélection d'un fournisseur ; tentative de changer de radio | listes affichées ; radios désactivés après sélection (figé) | `tests/vbr_filtres/` | à faire |
| VALIDBR1-T05 | replay | Double validation | T02 puis second clic « Validation + Compta » sans fermer | état actuel figé (écritures en double attendues, A03 à confirmer) | `tests/vbr_double/` | à faire |
| VALIDBR1-T06 | replay | Option boissons | base `B`, BR avec palettes/colis consignés | ligne de consigne fournisseur (`consfou`) dans l'écriture | `tests/vbr_consignes/` | à faire |
| VALIDBR1-T07 | replay | Compte de famille absent | famille sans `compt3_fam` valide | erreur « Compte comptable inconnu » (`Error.Raise`), état de la base figé | `tests/vbr_compte_inconnu/` | à faire |
| VALIDBR1-T08 | replay | Scan GED | GED active, fournisseur `fo_copie`, code fournisseur alphanumérique ; « GED (scan facture) » puis annuler | document GED (montants HT/TTC inversés, A02 figée) ; tags (erreur SQL possible, A04) | `tests/vbr_ged/` | à faire |
| VALIDBR1-T09 | replay | Validation depuis `commande1` | `commande1`, réception relue, « Valider les factures », date, « Avec écriture » | `validee = 1`, écriture ; libellé par défaut et date GED de l'auto-instance (A05 figée) | `tests/vbr_depuis_commande1/` | à faire |
| VALIDBR1-T10 | replay | Ouverture d'une réception | double-clic sur une BR (radio `Valid` puis `br`) | `commande1` ouvert en état Validée / Réception (voir COMMANDE1-T10) | `tests/vbr_ouvre_reception/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `receptions.sql` (3 fournisseurs dont un exonéré et
  un avec `libel_def`/`tag_def`, BR non validées et validées sans compta, familles avec
  `compt3_fam`, `Fiches_Tvaac`, `jrnal5` renseigné) ; base `B` pour T06.
- **Horloge** : `datej` saisi explicitement ; `Now` du pied de page des PDF exclu de la
  comparaison.
- **Comparaison** : dump normalisé des tables listées (numéros d'écriture comparés en valeur,
  `Sha1` éventuel masqué selon la convention d'`EcrAuto`) ; texte des PDF (`pdftotext`).
- **Non testables automatiquement** : scanner (T08 : la fenêtre `LGed` est annulée) ; son.
- **gbtest** : `ajouligne` (cumul débit/crédit d'un `VarEcr`) est un calcul pur sur `VarEcr` à
  la lecture d'un compte près : testable en gb.test après VALIDBR1-003.
