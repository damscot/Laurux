# Editfac — Tests

> Source : `.src/Reports/Editfac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Report gb.report construit à partir d'un `ObjFacB` : les tests passent par la chaîne réelle
`Facture`/`OptFac` → `ObjFacB` → `New EditfacB(Me, Me)` → `edit.Print` et comparent le PDF
produit (`~/tmp/Facture.pdf` ou `~/Impressions/<type>.pdf`). L'option boisson (`EditfacB`) est
testée par [EDITFACB-T01 à T04](../../Gestion/option/EditfacB.class/test.md) ; ici l'option
est `N` (rendu « standard » d'`Editfac`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITFAC-T01 | replay | Facture standard HT | client standard, 5 lignes (article, MO, commentaire `C`), 1 taux de TVA, remise, colonnes colorées | texte `pdftotext` de référence (en-tête société, titre « Facture n° », totaux, TVA) | `tests/facture_ht/` | à faire |
| EDITFAC-T02 | replay | Facture TTC complète | `ttc`, 3 taux, écotaxes DEE/DEA, 5 lignes de pied, coupon détachable, frais de gestion, récapitulatif articles/MO | texte de référence ; libellés « PU TTC »/« Brut TTC »/« Net TTC » | `tests/facture_ttc_complete/` | à faire |
| EDITFAC-T03 | replay | **Facture multi-pages** | 90 lignes dont libellés longs (troncature `longueur()`) et commentaires `TD`/`C`/`R` non tronqués | nombre de pages (`pdfinfo`), répétition de la bande de lignes, totaux en dernière page | `tests/facture_multipage/` | à faire |
| EDITFAC-T04 | replay | Avoir et duplicata (A01) | facture de montant négatif ; réimpression d'une facture archivée (`choix = archive`) | « Avoir n° » ; duplicata imprimé « Facture n° » sans « Impression du » (A01 figée) | `tests/avoir_duplicata/` | à faire |
| EDITFAC-T05 | replay | Bon de livraison | BL chiffré et non chiffré (`blchif`), `blrecap` actif avec des devis/commandes/BL facturés pour le même client, adresse de livraison, client « à livrer » | texte de référence ; « Total BL a facturer » = nombre actuel (A03 figée) | `tests/bon_livraison/` | à faire |
| EDITFAC-T06 | replay | Devis, commande, proforma | devis (`affref`, `libdev`, signature), estimation (`tab = "M"`), commande et proforma avec `AffClient` : réponse « Oui » puis « Non » à la question | titres, colonne code masquée, coordonnées client masquées ou non | `tests/devis_commande/` | à faire |
| EDITFAC-T07 | replay | Fiche atelier et matériel | document atelier (`tab = "M"`) avec marque, série, désignation, type | bandeau matériel, TVA masquée, bloc « signature client » | `tests/fiche_atelier/` | à faire |
| EDITFAC-T08 | replay | Régimes sans TVA | société en franchise, auto-entrepreneur ; BL exonéré (`exobl`) | sous-total et tableau de TVA masqués, mentions légales | `tests/regimes_tva/` | à faire |
| EDITFAC-T09 | replay | Options d'affichage | `Stock`, `simpcond`, `pxsdec` (format `,0`), `entete` faux (papier pré-imprimé), `adrlogo` (logo pleine largeur), `lgo` | colonnes présentes/masquées, largeur de l'intitulé (`lgint`), formats | `tests/options_affichage/` | à faire |
| EDITFAC-T10 | replay | Lignes de TVA inutilisées (A02) | même facture avec 1 puis 5 taux | positions (`pdftotext -bbox`) du bloc de totaux : figer l'espace vide actuel | `tests/tva_lignes_vides/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** avec la même base et la
  date figée (`faketime` : `LDate(Now)` est imprimé). Comparaison du texte `pdftotext -layout`
  normalisé, plus `pdfinfo` (pages) et `-bbox` (T03, T10) ; normalisation commune des PDF par
  `check_output.py` (voir [PdfWriter/test.md](../PdfWriter.class/test.md)), le moteur gb.report
  produisant lui aussi des dates de création.
- **Données** : jeu `facturation_base` (voir
  [ObjFac/test.md](../../Gestion/Facturation/ObjFac.class/test.md)), complété par une société
  de chaque régime (franchise, auto-entrepreneur), un matériel (`Fiches_HisentMat`) et des
  devis/commandes/BL facturés pour le même client (T05).
- **Base** : seules des lectures (`Fiches_Societes`, `Fiches_Bl`) ; le dump doit rester identique,
  sauf les écritures propres à la chaîne de facturation (`ObjFacB`), déjà figées par ses tests.
- **Interaction** : la question de la ligne 86 (T06) doit être enregistrée dans le scénario de
  replay ; les chaînes d'envoi par mail (`ObjFacB.mail`) la posent aussi.
- **Non testable directement** : `Editfac.code_Data`/`intitule_Data`, surchargés par `EditfacB`
  et jamais exécutés tant que seule `EditfacB` est instanciée ; leur équivalent est couvert par
  T01-T03 via les surcharges. Un `gbtest` direct demanderait gb.report et un serveur d'affichage
  (à confirmer en phase 2, `xvfb-run`).
