# Facture — Synthèse

> Source : `.src/Gestion/Facturation/Facture.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de gestion commerciale : saisie des documents de vente (commande, BL, devis, proforma,
facture, abonnement, fiche atelier) et de leurs lignes (main d'œuvre, articles, commentaires,
caractéristiques, composants, écotaxes, taxe copie privée), gestion du stock associé, duplication,
avoir, archivage, recherche dans les documents. Deux modes : facturation standard (`Fiches_Bl`) et
facturation entretien (`Fiches_BlM`, matériel réparé). La facture définitive (numéro, historique,
écritures, PDF, GED) est produite par `OptFac` et `ObjFacB`, appelés depuis cet écran.

## Points clés

- Plus gros fichier legacy du projet (12 479 lignes, 327 fonctions + 4 non détectées, CC 3 098,
  CC max 166 dans `Coldetail_KeyRelease`) : AGENTS.md règle 21, reworks minimaux.
- 21 groupes fonctionnels (architecture.md) ; les plus lourds : saisie des articles (G08, CC 584),
  saisie des lignes (G05, CC 393), duplication/avoir (G16, CC 288), liste des documents (G03).
- La grille `Coldetail` porte l'état de saisie (colonnes cachées décalées de 2 en option boisson) ;
  chaque ligne enregistrée recharge tout le document ; `Maj_Base` supprime puis réécrit toutes
  les lignes.
- Montants manipulés et stockés en texte (virgule) ; calculs lisant les contrôles.
- Stock « réversible » : réintégré à l'ouverture de la saisie des lignes, re-sorti à la fermeture.
- Numérotations sous `LOCK TABLES` (MySQL) ; aucune transaction ; ~170 noms de tables en dur.
- ~150 variables d'instance (drapeaux texte `B`, `ChkFocus`, `Modif`, `N`…), dont ~110 sans
  mot-clé ; 5 membres `Public` jamais lus ; 14 fonctions mortes.

## Dépendances principales

- Ouvert par `Fmenu` (Menu42, Menu193) et `ConVendeurs` (circularité via F5).
- Utilise `ObjFacB` (totaux, archivage), `OptFac` (édition), `TarArt` (tarif), `facopt` (option
  boisson), `VerifDate`, `DocActif`, `LGed`, `ArtPromo`, `CPrix`, `Listextcpt`, les sélecteurs
  `TriCpt`, `TriArticles`, `TriEqu`, `Tricp`, `TriFac(2)` (retour par `Object.SetProperty` ou
  `Variables`), `Utils` (SQL, conversions, grilles virtuelles, journal de rejeu).
- Une trentaine de tables : `Fiches_Bl(M)`, `Fiches_Ligbl(M)`, `Fiches_Parametres`, `Fiches_Cli`,
  `Fiches_Comptes`, `Fiches_Art`, `Fiches_StkDepots`, `Fiches_Materiels`, `Fiches_HistoFac`…

## Risques

- **Anomalies graves** : `Wrg()` sans argument (l. 4055, erreur d'exécution probable) ; paramètres
  décalés dans l'`UPDATE Fiches_BlM` (l. 1674) et dans `Enrg_Pdc` (l. 9060) ; 6e tranche de remises
  quantitatives jamais appliquée ; marge MO au forfait fausse ; stock par dépôt diminué par les
  lignes d'avoir ; protection des BL à matériel inopérante sous SQLite ; matériel libéré au simple
  rappel d'une ligne ; absence de transaction (`Maj_Base` vide puis réécrit les lignes).
- Anomalies partagées : `VerifDate.ClotDroi` sur l'auto-instance (VERIFDATE-A02), `Free_Lock`
  toujours faux (DOCACTIF-A01), F11 `FFournisseur` (FFOURNISSEUR-A07), rapprochement matériel
  (MATERIEL-A11).
- Effets de bord multiples (`Maj_libelle` dans `Recup_ligfac`, F10 qui modifie la fiche article,
  `Utils.Observers` rappelé à chaque clic), identifiant de bloc aléatoire (`Rnd`) qui rend le dump
  non déterministe.
- Drapeaux implicites et précédences `And If … Or` à établir en replay avant toute correction.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 10446 |
| Lignes de commentaire | 712 |
| Fonctions | 331 |
| Fonctions Public | 323 |
| Complexité cyclomatique totale | 3116 |
| Complexité max (fonction) | 166 (`Coldetail_KeyRelease`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

27 tests proposés (FACTURE-T01 à T27) : 26 replays (création de BL, nouveau client,
transformations de type, édition de facture, avoir, duplications, remises et tarifs, MO, HT/TTC et
arrondis, taxes annexes, produits composés, grille, suppression, dépôts, facturation entretien,
numéros de série, raccourcis, recherche, règlement, tâches, options P/T/B, import portable,
préférences d'affichage, SQLite, contrôles client, performance) et 1 `gbtest` sur les fonctions
pures extraites. **Module complexe : la liste des scénarios doit être validée par l'utilisateur
avant la phase 2.** Jeu de données dérivé commun et normalisation de `block_ligbl`/`dte_ligbl`
requis.

## Rework

24 étapes sans changement de comportement (FACTURE-001 à 024) : documentation (en-tête, raccourcis,
`Cbase.Table` sans changement SQL), code mort (14 fonctions, membres et variables), commonalisations
transverses (réplication FMENU-005, numéro client IMPCLIENT-008, largeurs SAISECRIT-010, échéance
avec `Saisecrit`, `ArtPromo.PromoDuJour`, `Suivi`), commonalisations internes (taxes annexes, stock,
types de document, lignes de texte, recherches, petits blocs, chargement client), extraction de
fonctions pures (arrondi au pas, delta de stock, tranches de remise, inversion de signe, cumul,
couleurs), découpage de `Coldetail_KeyRelease`, réduction de portée. 33 anomalies (FACTURE-A01 à
A33) soumises à validation.
