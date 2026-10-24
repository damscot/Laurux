# FClient — Synthèse

> Source : `.src/Gestion/Tables/FClient.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fiche client de la gestion commerciale : liste filtrable des clients et fiche sur 9 onglets
(identité, divers/RIB/SEPA, ventilations, observations, matériels, adresses de livraison, contacts,
dossiers GED, abonnement) plus un onglet Statistiques (`gridvi`). Crée, modifie et supprime le
client **et son compte comptable** (`Fiches_Comptes`, type `C`), numérote les nouveaux clients à
partir de `Fiches_Parametres.dnc`, gère mails, contacts, adresses, ventilations, tags/libellé par
défaut, documents GED, étiquettes PDF et l'export vers un serveur de prix.

## Points clés

- Écran legacy de 2716 LOC, 157 fonctions (155 `Public`), CC max 42 (`Maj_Zones`).
- Ouvert uniquement par son auto-instance (`Fmenu`, `Saisecrit`, `Tresor`, `Facture`).
- Boutons groupés `Btn` dispatchés par `Tag` : les `ButtonN_Click` sont des pseudo-handlers.
- Enregistrement par `Result` modifiable (`Create9`/`Edit`) dans une transaction ; numérotation sous
  `LOCK TABLES`.
- SQL de recherche **concaténé** (en-têtes de colonne), le reste paramétré.
- **Jumeau de FFournisseur** : 1725 lignes communes (80 % de FFournisseur), 105 fonctions
  homonymes dont 43 identiques et 54 à plus de 90 %. Un socle `FicheTiers` (classe paramétrée par
  le type de tiers, handlers conservés) supprimerait 900 à 1 000 LOC sans toucher aux `.form`.
- Code mort : `Remmo_LF`, `Remart_LF` (pas des événements), `Maj_vtl`, `Ref`, `Cpman`, `ChkCp`,
  `FileFilter`, `Cmpt3_Click`, 5 membres. `ListTags_Add` n'est **pas** mort : handler `Add` du
  `ListEditor`.

## Dépendances principales

- Utilise : `Utils` (db, Base, Observers…), `Cbase`, `Start.LocalSettings`, `Variables` (garde
  d'export), `Serveur.Pass`, `LGed`/`TriGen` (GED, tags), `TriCpt`, `Tricp`, `Gsm`, `Commail`,
  `EnvMail`, `Extrait`, `TarTypeCli`, `Listecom`, `Rechtipp`, `Rechtour`, `Cetiquettes`,
  `Visualiseur`, `gridvi`, `hexdblKey`, `Enrgcp`.
- Utilisé par : `Fmenu`, `Saisecrit`, `Tresor`, `Facture` (ouverture modale) ; `Tricp`, `TriCpt`,
  `TriGen` écrivent `Bsel`/`Bval`/`Codepostal`/`Bureaudistributeur`.

## Risques

- `collman` accepte tout compte existant non collectif comme collectif (A01).
- Suppression : `DELETE FROM <TabCdocs>` invalide (CBASE-A01) → message d'erreur, nettoyage
  interrompu, orphelins (A04).
- `LOCK TABLES` non relâché si `dnc` est invalide (A05) ; transaction non close (A06).
- `INSERT … VALUE` : contacts et adresses impossibles sous SQLite (A07).
- `Aff_Ct` écrit le numéro d'adresse : écrasement possible d'une adresse de livraison (A02).
- SMS contact sur le mauvais onglet (A03) ; dernier mail supprimé recopié dans `cli_email` (A08).
- Non-déterminisme pour le rejeu : RUM aléatoire, `Now`, fichiers dans `HOME`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2716 |
| Lignes de commentaire | 84 |
| Fonctions | 157 |
| Fonctions Public | 155 |
| Complexité cyclomatique totale | 675 |
| Complexité max (fonction) | 42 (`Maj_Zones`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

18 tests prévus (**scénarios à valider par l'utilisateur**) : 16 `replay` (création, numérotation,
modification, collectif, suppression, mails, contacts, adresses MySQL/SQLite, ventilations, GED et
tags, recherche, listes de choix, étiquettes, outils, ouvertures externes, export serveur) et
2 `gbtest` sur les fonctions pures extraites (`ProchainCode`, `ClauseRecherche`). Comparaison par
dump normalisé, valeurs produites dans le clone Laurux non modifié.

## Rework

16 étapes sans changement de comportement (FCLIENT-001 à 016) : documentation, code mort,
`Cbase.Table`, factorisation de la recherche et du code postal, séparation SQL/GUI (numérotation,
compte comptable, suppression, contrôles), socle commun `FicheTiers` avec FFournisseur (mails,
contacts, ventilations, GED, listes, étiquettes), `Serveur.Actif`, réduction de portée de 39
fonctions. 16 anomalies (FCLIENT-A01 à A16) soumises à validation utilisateur.
