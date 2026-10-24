# FFournisseur — Synthèse

> Source : `.src/Gestion/Tables/FFournisseur.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fiche fournisseur : liste des fournisseurs et fiche sur 6 onglets (identité, divers, ventilations,
observations, contacts, dossiers GED). Crée, modifie et supprime le fournisseur **et son compte
comptable** (`Fiches_Comptes`, type `F`), numérote à partir de `Fiches_Parametres.dnf`, gère franco,
minimum de commande, frais de port, centrale d'achat, code-barres, TVA intracommunautaire, mails,
contacts, ventilations, tags/libellé par défaut, GED, étiquettes et export vers un serveur de prix.

## Points clés

- Écran legacy de 2156 LOC, 132 fonctions (131 `Public`), CC max 35 (`Cmpt_KeyPress`).
- Ouvert par l'auto-instance (`Fmenu`, `Articles`, `Saisecrit`, `Tresor`, `Facture` F4) et par une
  instance `New` depuis `Facture` (F11).
- Enregistrement par `INSERT`/`UPDATE` paramétrés de 38 colonnes, **sans transaction**.
- Jumeau de FClient (80 % des lignes en commun) : socle `FicheTiers` proposé, détaillé dans la
  documentation de FClient.
- Dispatch `Btn` par `Tag` avec des noms croisés (`Button15` → `Button14_Click`, `Button13` →
  `Button15_Click`).
- Code mort : `Tabfour3_click`, `colfo_Click`, `colfo_Activate`, `Button6_Keypress` et, par
  transitivité, `Button6_Click`, `Maj_vtl`, `FileFilter`, `HBox1_MouseDown` (vide), 4 membres.
  `ListTags_Add` est un handler (`ListEditor.Add`).

## Dépendances principales

- Utilise : `Utils`, `Cbase`, `Start.LocalSettings`, `Variables` (garde d'export), `Serveur.Pass`,
  `CTestTVA`, `LGed`/`TriGen`, `TriCpt`, `Tricp`, `Gsm`, `EnvMail`, `Cetiquettes`, `Visualiseur`,
  `Enrgcp`.
- Utilisé par : `Fmenu`, `Articles`, `Saisecrit`, `Tresor`, `Facture` ; `Tricp`, `TriCpt`, `TriGen`
  écrivent `Bsel`/`Bval`/`Codepostal`/`Bureaudistributeur`.

## Risques

- Suppression : `DELETE FROM <TabFdocs>` invalide → ventilations orphelines et **export de la
  suppression jamais émis** (A01).
- `LOCK TABLES` non relâché si `dnf` invalide (A02) ; création partielle si le compte existe déjà (A03).
- Contacts impossibles sous SQLite (`VALUE`, A04) ; dernier mail supprimé conservé dans `fo_email` (A05).
- Contrôle d'unicité du code-barres fait sur la table des cartes clients (A06).
- Instance créée par `Facture` F11 : le code postal choisi dans `Tricp` est perdu (A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2156 |
| Lignes de commentaire | 90 |
| Fonctions | 132 |
| Fonctions Public | 131 |
| Complexité cyclomatique totale | 545 |
| Complexité max (fonction) | 35 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

16 tests prévus (**scénarios à valider par l'utilisateur**), en miroir de FClient : 15 `replay`
(création, divers et code-barres, collectif, suppression, numérotation, mails, contacts
MySQL/SQLite, ventilations, GED et tags, recherche, listes de choix, étiquettes, outils, ouvertures
externes, export serveur) et 1 `gbtest` (code-barres EAN) ; `ProchainCode` est couvert par
FCLIENT-T16.

## Rework

16 étapes sans changement de comportement (FFOURNISSEUR-001 à 016) : documentation, code mort,
`Cbase.Table`, factorisation des en-têtes et des montants, séparation SQL/GUI (code-barres,
numérotation, enregistrement, suppression, contrôles), socle `FicheTiers` partagé avec FClient,
`Serveur.Actif`, `Limit 1` du panneau GED, réduction de portée de 38 fonctions. 12 anomalies
(FFOURNISSEUR-A01 à A12) soumises à validation utilisateur.
