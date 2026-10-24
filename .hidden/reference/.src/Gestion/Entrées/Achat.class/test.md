# Achat — Tests

> Source : `.src/Gestion/Entrées/Achat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Achat` n'a pas de formulaire propre : tous les scénarios passent par l'écran
`commande1` (menu Gestion › Achats / Réceptions). **Module complexe** : cette liste de scénarios
est à faire valider par l'utilisateur avant la génération des tests (PLAN.md §0). Les valeurs
attendues sont produites dans le clone **Laurux non modifié** ; les anomalies sont figées
(tests de caractérisation). Tables comparées par défaut : `Fiches_Entcom`, `Fiches_Ligcom`,
`Fiches_Entrecpt`, `Fiches_Ligrecpt`, `Fiches_Art` (stock, PAMP, prix), `Fiches_TarTemp`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ACHAT-T01 | replay | Création d'une commande saisie | fournisseur F1 ; 2 articles (code tapé, puis F2 + `TriArticles`) ; quantités, remise `5%` ; Enregistrer | `Fiches_Entcom`/`Fiches_Ligcom` (montants, `rm`, `paht`, `nligne`) | `tests/commande_saisie/` | à faire |
| ACHAT-T02 | replay | Génération automatique | fournisseur dont 3 articles sont sous `art_stkmin` (dont 1 déjà commandé, 1 avec `art_mincom`) ; bouton Générer | lignes et quantités de la grille, puis `Fiches_Ligcom` après enregistrement | `tests/generer/` | à faire |
| ACHAT-T03 | replay | Modification d'une commande | relire la commande de T01, changer une quantité, ajouter une ligne, enregistrer | anciennes lignes supprimées, nouvelles écrites (`SupAchat` + `EnrAch`) | `tests/modif_commande/` | à faire |
| ACHAT-T04 | replay | Réception d'une commande avec reliquat | commande T01 → Réception ; quantité reçue < commandée ; « Oui » au reliquat | `Fiches_Entrecpt`/`Ligrecpt`, stock et PAMP (`Fiches_Art`), commande supprimée ; figer le contenu de la grille de reliquat (ACHAT-A08 à confirmer) | `tests/reception_reliquat/` | à faire |
| ACHAT-T05 | replay | Réception directe et prix | réception sans commande, `/Soc01/prixRecpt` vrai, `TX_Conv = 6`, frais | `paht = Px_Net × TX_Conv`, `prvt`, `pattc`, stock et PAMP | `tests/reception_directe/` | à faire |
| ACHAT-T06 | replay | Modification d'une réception | relire T05, changer un prix, enregistrer | `Fiches_Ligrecpt` modifiées ; stock décrémenté puis réincrémenté (PAMP) | `tests/modif_reception/` | à faire |
| ACHAT-T07 | replay | Suppression d'une réception | supprimer T05 | lignes supprimées, stock et PAMP décrémentés | `tests/suppression_reception/` | à faire |
| ACHAT-T08 | replay | Matériels (numéros de série) | article `art_mat` qté 2 ; saisie de 2 numéros ; puis suppression de la réception | `Fiches_Materiels` créés ; suppression refusée avec message (ACHAT-A01 figée) | `tests/materiels/` | à faire |
| ACHAT-T09 | replay | Doublon de série | numéro déjà présent sur une autre réception, saisi sur une ligne sans focus | validation acceptée (ACHAT-A03 figée) | `tests/serie_doublon/` | à faire |
| ACHAT-T10 | replay | Options boissons (B/T) | licence `B`, article avec droits (`art_dra`), palettes/colis consignés, vignette | `Fiches_ligregie`, `Fiches_ligcons`, blocage des quantités à la relecture | `tests/boissons/` | à faire |
| ACHAT-T11 | replay | Import inventaire portable | `~/Portable/inventaire.txt` (codes valides, code-barre vide, code inconnu) ; bouton Import | lignes de la grille (ACHAT-A04 figée), `~/tmp/ImpT.txt` | `tests/import_portable/` | à faire |
| ACHAT-T12 | replay | Doublons de tarif | même article sur 2 lignes avec « Mise à jour des tarifs » coché | fenêtre de doublons, pas d'enregistrement | `tests/doublons/` | à faire |
| ACHAT-T13 | replay | Impression | commande T01 et réception T05, code article / réf. fournisseur, chiffrée / non chiffrée | texte des PDF (`pdftotext`) de `~/tmp/BonReception.pdf` et du PDF de commande | `tests/impression/` | à faire |
| ACHAT-T14 | replay | Remise sans `%` et prix brut nul | Rem `5` (sans `%`), `Px_Brut = 0`, enregistrer | erreur de division et rollback (ACHAT-A05 figée) | `tests/remise_sans_pct/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `achats.sql` (fournisseur F1, 5 articles dont un
  matériel, un article sous stock mini, un article avec droits ; `Fiches_Tvaav` standard). Une
  base `B` (licence boissons) pour T10. `Laurux.conf` du test : `/Soc01/prixRecpt` selon le
  scénario.
- **Horloge** : dates de document et `Now` (pied d'impression, `Fiches_Materiels.mat_ddate`) à
  fixer (`faketime`) ; le pied de page des PDF est exclu de la comparaison.
- **Comparaison** : dump normalisé des tables listées ; la grille est relevée par le replay
  (texte des colonnes) pour T02, T04, T11.
- **Non testables automatiquement** : `mail()` (envoi réel par `EnvMail.Envoi2`, à remplacer par
  un faux client SMTP ou à vérifier manuellement), la fenêtre `Editeur.Prog_Editeur` (T11 : le
  fichier `ImpT.txt` est comparé à la place), le son.
- **gb.test** : aucun aujourd'hui (toute la logique lit les contrôles). Après ACHAT-008
  (séparation), `RemiseDepuisTexte` et le calcul des quantités de `generer` pourront être testés
  en gb.test.
