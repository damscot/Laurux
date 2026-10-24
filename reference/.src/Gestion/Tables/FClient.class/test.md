# FClient — Tests

> Source : `.src/Gestion/Tables/FClient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Écran complexe : les scénarios replay ci-dessous (création, modification, suppression,
> contacts, mails, GED…) sont une proposition à valider par l'utilisateur avant la phase 2**
> (périmètre, données, comportements à figer).

Écran GUI : `replay` avec comparaison du dump normalisé de `Fiches_Cli`, `Fiches_Comptes`,
`Fiches_Parametres` (`dnc`), `Fiches_Cli_Vtl`, `Mails_Cli`, `Fiches_ContactC`, `Fiches_AdrlivC`,
`Fiches_Cpostaux`, `Corsage`, `Docs_Ged` ; `gbtest` sur les fonctions pures extraites
(`ProchainCode`, `ClauseRecherche`). Les valeurs attendues sont produites en rejouant les mêmes
scénarios dans le clone **Laurux non modifié** ; les anomalies sont figées (caractérisation).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLIENT-T01 | replay | Création d'un client | menu Clients ; Créer ; civilité, nom, adresse, CP avec une seule ville puis CP à plusieurs villes (liste `Colcp`), mail (Entrée), collectif par défaut ; Enregistrer | ligne `Fiches_Cli`, compte `Fiches_Comptes` type `C`, `dnc` incrémenté, `Mails_Cli`, CP mémorisé ; client resélectionné | `tests/creation/` | à faire |
| FCLIENT-T02 | replay | Numérotation | `dnc` = 411999 ; `dnc` = code existant ; `dnc` = 0 | 4111000 ; `max + 1` avec avertissement ; message sans `UNLOCK` (A05 figée : écriture suivante en erreur sous MySQL) | `tests/numerotation/` | à faire |
| FCLIENT-T03 | replay | Modification | sélection d'un client ; onglets Identité et Divers (RIB, IBAN, échéance, remises, frais, mode de règlement, type, statut, commercial, exemplaires, copie PDF, lettrable) ; Enregistrer | colonnes modifiées dans `Fiches_Cli` et `Fiches_Comptes` ; formes `-1`/`0` des cases | `tests/modification/` | à faire |
| FCLIENT-T04 | replay | Refus et collectif | Enregistrer sans nom ; collectif inexistant ; collectif `401…` ; collectif = compte client `411…` non collectif | messages, aucune écriture ; le compte non collectif est **accepté** (A01 figée) | `tests/collectif/` | à faire |
| FCLIENT-T05 | replay | Suppression | client libre ; client avec écriture `Fiches_Mvt` ; client avec BL | libre : `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Cli_Vtl` supprimés puis message d'erreur SQL `TabCdocs` (A04 figée), `Corsage`, mails, contacts, adresses conservés ; refus pour les deux autres | `tests/suppression/` | à faire |
| FCLIENT-T06 | replay | Mails | ajout de 2 mails (Entrée, perte de focus) ; Suppr sur le premier ; Suppr sur le dernier | `Mails_Cli` ; `cli_email` = adresse supprimée au dernier (A08 figée) | `tests/mails/` | à faire |
| FCLIENT-T07 | replay | Contacts | onglet Contacts : 2 contacts, modification, Suppr ; puis ajout d'une adresse de livraison sans sélection | `Fiches_ContactC` (`num` global) ; `Numero` de l'adresse = n° de contact + 1 (A02 figée) | `tests/contacts/` | à faire |
| FCLIENT-T08 | replay | Adresses de livraison | ajout de 2 adresses (CP par `Cpman2` et par `Tricp`), modification, Suppr ; même scénario sous SQLite | `Fiches_AdrlivC` sous MySQL ; erreur `VALUE` sous SQLite (A07 figée) | `tests/adresses_livraison/` | à faire |
| FCLIENT-T09 | replay | Ventilations | compte `G` par saisie et par F2 (`TriCpt`) ; compte client `411…` ; compte collectif ; Suppr et double-clic sur une ligne ; F2 annulé après un choix | `Fiches_Cli_Vtl` ; refus ; choix précédent recopié (A10 figée) | `tests/ventilations/` | à faire |
| FCLIENT-T10 | replay | Libellé, tags, GED | libellé par défaut ; tags par saisie (`ListEditor`) et par « Rech. Tag » ; scan (`LGed` modal) annulé puis validé ; boutons radio Tous / Docs / Factures / Compta / BL / Commande / Devis | `libel_def`, `tag_def` (doublon éventuel de `ListTags_Add` à observer) ; `Docs_Ged` ; contenu du panneau | `tests/ged_tags/` | à faire |
| FCLIENT-T11 | replay | Recherche et liste | clic et saisie sur chaque en-tête ; CP (« commence par ») ; double-clic (ordre inverse) ; F2/Échap (agrandissement) ; filtres Inactifs et Statut ; `V1` = Contact ; contact orphelin | contenu de la grille relevé ; table temporaire laissée sur contact orphelin (A13 figée) | `tests/recherche/` | à faire |
| FCLIENT-T12 | replay | Listes de choix | F2 collectifs, F2 sur `Teldom` (échéances, A16), types clients, CP (`Tricp`) choisi puis annulé ; région TIPP et tournée (option `P`/`T`) inconnues puis valides | zones remplies ; ancien CP recopié après annulation (A10) | `tests/listes_choix/` | à faire |
| FCLIENT-T13 | replay | Étiquettes | format 1 (planche) avec position de départ 3 et 5 exemplaires ; format 2 (colis) | `~/tmp/EtiqCli.pdf` : texte extrait (`pdftotext`) et nombre de pages | `tests/etiquettes/` | à faire |
| FCLIENT-T14 | replay | Outils et sous-écrans | F6 (CA) ; onglet Abonnement ; « documents en cours » (`Button20`) ; Extrait ; tarifs client et type ; liste des commandes ; SMS onglet 0 et onglet 6 ; mail (texte prédéfini) | bulle CA sur 4 ans (A09) ; facture affichée (A12) ; `Form_Open` relancé (A11, à confirmer) ; SMS contact impossible (A03) ; appels `xdg-open`/client mail interceptés | `tests/outils/` | à faire |
| FCLIENT-T15 | replay | Ouverture depuis la compta et la facturation | `Saisecrit` puis `Tresor` : compte client inexistant → création ; `Facture` : F4 sur la zone client, puis question « client abonnement » | client créé ou complété, retour à l'écran appelant | `tests/ouverture_externe/` | à faire |
| FCLIENT-T16 | gbtest | `ProchainCode` (après FCLIENT-007) | `"411000"`, `"411998"`, `"411999"`, `"4119999"`, `"41110000"`, racine `"411"` | codes attendus et valeur `dnc` à écrire | `tests/prochain_code/` | à faire |
| FCLIENT-T17 | gbtest | `ClauseRecherche` (après FCLIENT-004) | tris × `sel` (`""`, `"du"`) × CP (`Org`) × actif × statut | texte SQL identique à celui de `Deb2`/`Deb3` actuels | `tests/clause_recherche/` | à faire |
| FCLIENT-T18 | replay | Export serveur de prix | `/Soc01/Sprix`, `Sexport`, `SMajCli` à 1 ; création, modification, contacts | lignes ajoutées aux fichiers d'échange de `Serveur.Pass` (`Cli`, `ContactC`) | `tests/export_serveur/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est enregistré une fois (log GUI), rejoué dans
  le clone Laurux non modifié pour produire `expected/` (dump normalisé + fichiers produits), puis
  rejoué dans `Laurux_reworked`. Le dump de la base fait foi.
- **Données** : `Laurux01.sql` ; jeu dérivé `clients.sql` : 3 clients (libre, mouvementé dans
  `Fiches_Mvt`, avec BL), contacts, adresses, mails, ventilations, un contact orphelin, un compte
  client non collectif, échéances, types clients, statuts, commerciaux, formats d'étiquettes ;
  `Laurux.conf` du test avec `Materiel`, `Faca`, `Sms` actifs et `Utils.Option()` = `T` pour
  T12.
- **Non-déterminisme** : `GenRum` (`Rnd`) → colonne `cli_rum` exclue du dump ; `ChiffreA` dépend de
  `Now` (horloge fixée) ; `Pays.txt` lu dans le répertoire courant du test ; `~/tmp` doit exister
  (T13) ; `HOME` isolé (vCard `~/Contacts.vcf`).
- **Rejeu** : `Vents` et `Colmat` (ColumnView) n'ont pas de handler `_Click` ; un clic enregistré sur
  ces listes ferait appeler `Vents_Click`/`Colmat_Click` inexistants par `ReplayObserver` (à éviter
  dans les scénarios ou à traiter par REPLAYOBSERVER-A06). `V1` est une ComboBox : rejeu par index.
- **Non testable automatiquement** : couleurs de focus, son, ouverture réelle du navigateur et du
  client mail (intercepter `xdg-open` par un script factice qui journalise ses arguments).
- **Couverture visée** : toutes les branches de `Button2_Click`, `Button3_Click`, `Button4_Click`,
  `majchamp`, `collman` ; l'impression d'étiquettes par T13.
