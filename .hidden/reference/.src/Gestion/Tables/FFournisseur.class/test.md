# FFournisseur — Tests

> Source : `.src/Gestion/Tables/FFournisseur.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Écran complexe : les scénarios replay ci-dessous (création, modification, suppression,
> contacts, mails, GED…) sont une proposition à valider par l'utilisateur avant la phase 2**
> (périmètre, données, comportements à figer).

Écran GUI : `replay` avec comparaison du dump normalisé de `Fiches_Four`, `Fiches_Comptes`,
`Fiches_Parametres` (`dnf`), `Fiches_Four_Vtl`, `Mails_Four`, `Fiches_ContactF`, `Fiches_Cpostaux`,
`Docs_Ged` et des fichiers d'échange du serveur de prix ; `gbtest` sur les fonctions pures extraites
(`ProchainCode`, clé EAN). Valeurs attendues produites dans le clone **Laurux non modifié** ;
anomalies figées. Les scénarios sont construits en miroir de ceux de
[FClient](../FClient.class/test.md) pour valider le socle commun avec les mêmes enregistrements.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FFOURNISSEUR-T01 | replay | Création | menu Fournisseurs ; Créer ; identité, CP, mail, Entrée sur `Fax1` ; collectif par défaut ; Enregistrer ; puis création avec un compte `401…` déjà présent dans `Fiches_Comptes` | `Fiches_Four`, `Fiches_Comptes` type `F`, `dnf` ; second cas : fournisseur inséré puis erreur SQL (A03 figée) | `tests/creation/` | à faire |
| FFOURNISSEUR-T02 | replay | Modification onglet Divers | RIB, IBAN, TVA `FR…` valide puis invalide, site, n° client, échéance, franco `12,5` et `abc`, minimum, port, centrale, code-barres saisi (EAN-13 faux, EAN-8), F9 génération, copie PDF | colonnes `fo_*` ; messages ; code-barres déjà présent dans `Fiches_Carte` → avertissement (A06 figée) | `tests/modification_divers/` | à faire |
| FFOURNISSEUR-T03 | replay | Refus et collectif | sans nom ; collectif inexistant ; collectif `411…` ; compte `401…` non collectif | messages, aucune écriture | `tests/collectif/` | à faire |
| FFOURNISSEUR-T04 | replay | Suppression | fournisseur libre ; avec écriture `Fiches_Mvt` ; avec MO ; avec article ; avec commande ; avec réception | libre : `Fiches_Four` et `Fiches_Comptes` supprimés puis erreur `TabFdocs`, `Fiches_Four_Vtl` conservé (A01 figée) ; refus avec le message attendu pour les autres | `tests/suppression/` | à faire |
| FFOURNISSEUR-T05 | replay | Numérotation | `dnf` = 401999 ; code existant ; `dnf` = 0 | 4011000 ; `max + 1` ; message sans `UNLOCK` (A02 figée) | `tests/numerotation/` | à faire |
| FFOURNISSEUR-T06 | replay | Mails | 2 mails ; Suppr du premier puis du dernier | `Mails_Four` ; `fo_email` garde l'adresse supprimée (A05 figée) | `tests/mails/` | à faire |
| FFOURNISSEUR-T07 | replay | Contacts | 2 contacts, modification, Suppr ; même scénario sous SQLite | `Fiches_ContactF` ; erreur `VALUE` sous SQLite (A04 figée) | `tests/contacts/` | à faire |
| FFOURNISSEUR-T08 | replay | Ventilations | compte `G` saisi et par F2 (`TriCpt`), compte client, collectif, Suppr, double-clic, F2 annulé | `Fiches_Four_Vtl` ; refus ; choix précédent recopié (A07) | `tests/ventilations/` | à faire |
| FFOURNISSEUR-T09 | replay | Libellé, tags, GED | libellé, tags (`ListEditor`, Rech. Tag), scan annulé puis validé, boutons radio | `libel_def`, `tag_def`, `Docs_Ged`, contenu du panneau ; messages « client » (A09) | `tests/ged_tags/` | à faire |
| FFOURNISSEUR-T10 | replay | Recherche et liste | clic, double-clic et saisie sur chaque en-tête ; F2/Échap sur la grille | contenu de la grille relevé | `tests/recherche/` | à faire |
| FFOURNISSEUR-T11 | replay | Listes de choix et CP | F2 collectifs, F2 échéances, CP à une et plusieurs villes, `Tricp` choisi puis annulé | zones remplies ; ancien CP recopié (A07) | `tests/listes_choix/` | à faire |
| FFOURNISSEUR-T12 | replay | Étiquettes | format 1 sans puis avec code-barres ; format 2 ; deux impressions successives | `~/tmp/EtiqFour.pdf` (texte, pages) ; décalage à la seconde impression (A08 figée) | `tests/etiquettes/` | à faire |
| FFOURNISSEUR-T13 | replay | Outils externes | site, carte, vCard, Infogreffe, vérification TVA web, mail, SMS (onglets 0 et 4) | arguments de `xdg-open` journalisés, `~/Contacts.vcf` | `tests/outils/` | à faire |
| FFOURNISSEUR-T14 | replay | Ouvertures externes | `Articles` (fournisseur), `Saisecrit`/`Tresor` (compte manquant), `Facture` F4 et F11 avec choix d'un CP par `Tricp` | fiche créée ; en F11, CP non reporté (A07 figée) | `tests/ouverture_externe/` | à faire |
| FFOURNISSEUR-T15 | gbtest | Code-barres (après FFOURNISSEUR-006) | codes `401001`, `4011000` ; EAN-13 valides et invalides ; longueurs 7, 8, 12, 13 | code généré, clé, verdict identiques au code actuel | `tests/code_barre/` | à faire |
| FFOURNISSEUR-T16 | replay | Export serveur de prix | `/Soc01/Sprix`, `Sexport`, `SMajFour` à 1 ; création, modification, contacts, suppression | lignes `Four`, `ContactF` ; **pas** de ligne `Four;S` à la suppression (A01) | `tests/export_serveur/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : enregistrement du scénario, rejeu dans le clone Laurux non
  modifié (`expected/` : dump normalisé + fichiers produits), puis dans `Laurux_reworked`.
- **Données** : `Laurux01.sql` ; jeu dérivé `fournisseurs.sql` : fournisseurs libre / mouvementé /
  avec MO, article, commande, réception ; compte `401…` orphelin dans `Fiches_Comptes` ; carte
  `Fiches_Carte` portant un code-barres ; contacts, mails, ventilations, centrales, échéances,
  formats d'étiquettes.
- **`ProchainCode`** : testé en gbtest par FCLIENT-T16 (fonction du socle commun) avec la racine
  `401`.
- **Non testable automatiquement** : couleurs de focus, son, navigateur, client mail (intercepter
  `xdg-open`), PDF au pixel (comparaison du texte extrait).
- **Rejeu** : `Vents` (ColumnView sans `_Click`) à ne pas cliquer dans les scénarios (voir FClient).
- **Couverture visée** : toutes les branches de `Button2_Click`, `Button3_Click`, `Button4_Click`,
  `Cmpt2_KeyPress` (tags 6, 10-12, 15).
