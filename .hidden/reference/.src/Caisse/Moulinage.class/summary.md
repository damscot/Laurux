# Moulinage — Synthèse

> Source : `.src/Caisse/Moulinage.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Passage en comptabilité de la caisse pour une journée : écritures de ventes (`Fiches_Mvt`),
trésorerie par mode de règlement (`EcrReg`), acomptes/avoirs/crédits, facturation des BL réglés
en caisse, facture magasin du jour (`Fiches_HistoFac`), archivage puis suppression des tickets,
livre de caisse PDF. Sert aussi de bibliothèque à la caisse (`Generation_Bl`, `Livre_caisse` via
l'auto-instance du formulaire) et d'outil de contrôle a posteriori (`Controle_Moulinage`).

## Points clés

- 2 902 lignes, CC 622 ; `Livre_caisse` (CC 196) et `Moulinage` (CC 126) concentrent la complexité.
- Traitement **non transactionnel**, protégé par un `LOCK TABLES` qui est en pratique remplacé ou
  libéré par les classes appelées ; la sauvegarde `mysqldump` préalable sert de filet.
- Ventilation par table de travail `Totalisation`, contrôle d'écart (`Verif`), une écriture de
  ventes par journée, soldes mis à jour par incrément (sauf comptes d'acompte et BL :
  `Csolde.Solde_caisse`).
- Nombreuses copies : résolution famille → compte (5 fois), `INSERT Fiches_Mvt` (12 fois), 4 blocs
  d'impression de tickets, `arrondi` = `Caisse.arrondi`, `Ecritures`/`Maj_Collectif` = `BordereauxC`.
- 13 appels `Sha1Calc.CalcSha1("Fiches_Mvt")` et de nombreux noms de tables en dur.

## Dépendances principales

- Appelé par `Fmenu` (écran), `Caisse` (`Generation_BL`, `Livre_caisse`).
- Utilise `Facturergbl` (instance invisible, `Ent_Bl`), `ObjFacB` (`editef`, `comptmat`),
  `Calculdroit1`, `Mreglement` (auto-instance), `EcrReg`/`VarEcr`, `Sha1Calc`, `Csolde`, `Cfacture`,
  `ProgBar`, `LDate`, `Utils`, `Cbase`.
- Anomalies liées : CALCULDROIT1-A01, OBJFACB-A02, FACTURERGBL-A03, FACTURE-A07, SAISECRIT-A01,
  BORDEREAUXC-A03.

## Risques

- État partiel en cas d'erreur, transaction laissée ouverte par `comptmat` pour une facture
  magasin sans alcool : suppression des tickets possiblement annulée, donc double moulinage
  (A03, à confirmer).
- Règlements des tickets supprimés passés en trésorerie (A04) ; suppression des tickets par numéro
  sans la date (A10).
- `Maj_Collectif` : solde du collectif modifié du cumul, `montantc` effacé (A01, latent ici, réel
  dans `BordereauxC`).
- Livre multi-caisses cumulant les caisses (A09) ; contrôle des tickets oubliés inopérant (A05) et
  erreur sur colonne `fam` absente (A06).
- Accise non retirée en option boissons `B` (A14) ; `pu_ligbl` booléen à quantité nulle (A07).
- Écran ni journalisé ni rejouable (`Utils.Observers` absent) : prérequis des tests de phase 2.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2430 |
| Lignes de commentaire | 218 |
| Fonctions | 33 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 622 |
| Complexité max (fonction) | 196 (`Livre_caisse`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

23 tests prévus (MOULINAGE-T01 à T23) : 3 `gbtest` (arrondi, ventilation d'article, totalisation)
et 20 `replay` comparés par dump de `Fiches_Mvt*` et des tables d'archives/factures/paramètres,
horloge figée : journée simple, avoirs, acomptes et crédits, règlements multiples, tickets
supprimés et doublons, BL réglés, mouvements hors vente, écart de ventilation, plusieurs caisses,
option boissons, rejeu sur une période déjà moulinée, garde-fous, SHA-1, contrôle, erreur fatale,
appels depuis la caisse, SQLite, performance. **Liste à faire valider par l'utilisateur avant la
phase 2** (module complexe) ; jeux `caisse_base` et `caisse_boisson` à créer.

## Rework

17 étapes sans changement de comportement (MOULINAGE-001 à 017) : documentation, code mort
(variables, recherche de collectif, table `Virements`), `Cbase.Table`, factorisation du livre de
caisse, des comptes de vente et des `INSERT`, découpage de `Moulinage()`, requêtes par ligne,
réduction de portée de 21 membres, date en paramètre, confirmations isolées, services communs avec
`BordereauxC`/`Saisecrit`, `Caisse.arrondi`, `Facturergbl.Ventilation` et `CompteClientCaisse()`. 17 anomalies
(MOULINAGE-A01 à A17) soumises à validation utilisateur.
