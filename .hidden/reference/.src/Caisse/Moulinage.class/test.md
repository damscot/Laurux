# Moulinage — Tests

> Source : `.src/Caisse/Moulinage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (PLAN §0) : la liste des scénarios ci-dessous est à faire valider par
> l'utilisateur avant la phase 2** (ajout, retrait ou fusion de cas, jeux de données). Aucun test
> ne sera généré avant cette validation.

Le moulinage **écrit massivement en base** (écritures, soldes, compteurs, archives, factures,
suppression des tickets) : les scénarios sont des `replay` comparés par **dump normalisé** de la
base. Tables comparées : `Fiches_Mvt` à `Fiches_Mvt5` (dump de toutes les variantes par sécurité,
le moulinage n'écrit que `Fiches_Mvt`), `Fiches_Comptes.solde`, `Fiches_Parametres`
(`numecriture`, `numecriture2`, `dnbon`, `dnfac`), `Fiches_HisEntTickets`,
`Fiches_HisLigTickets`, `Fiches_EntTicketz`, `Fiches_LigTicketz`, `Fiches_Bl`, `Fiches_Ligbl`,
`Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_ligregie`, `Fiches_Caisses`. Ce sont des données
**dérivées** : horloge figée (`faketime`) pour `datee`, `numdoc`/`numlot` des corrections
(`Format(Now)`), `dtefm`, les noms de PDF et la sauvegarde ; colonne SHA-1 comparée telle quelle
(elle dépend du contenu). Les tables de travail (`Totalisation`, `Virements`, `Tmp_Caisse`) sont
exclues du dump (décision phase 2, cf. notes transverses).

**Prérequis de rejeu** : `Moulinage` n'appelle pas `Utils.Observers(Me)` (pas plus que l'écran
`Bordereaux`) : l'écran n'est **ni journalisé ni rejouable** en l'état. Les scénarios supposent
une décision utilisateur en début de phase 2 : soit ajouter l'instrumentation dans les deux clones
avant la capture, soit piloter le traitement par un module de test qui appelle l'auto-instance
après MOULINAGE-012 (date en paramètre), ce qui suppose d'exécuter ce rework avant la capture.
L'instance invisible de `Facturergbl` créée par le moulinage, elle, s'enregistre auprès de
`Utils.Observers` : le log contiendra ses événements. Les boîtes de dialogue (`Message.*`) doivent
être prises en charge par le rejeu (réponse enregistrée).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MOULINAGE-T01 | gbtest | `arrondi` (fonction pure, `Public` aujourd'hui) | montants 2,43 / 2,47 / 2,48 / 2,42 / -3,17 / 12,30 / 12,80 / "" × pas `0,05`, `0,10`, `0,50`, `1,00`, autre | chaînes de référence (séparateur `,` ou `.` selon la branche, figé) ; locale `fr_FR.UTF-8` fixée | `tests/arrondi_caisse/` | à faire |
| MOULINAGE-T02 | gbtest | Ventilation d'un article (`Recup_Art`, `Remises_quantitatives`, `CalcTTC`, `Decimal`, `Calc_Marge`) sur l'auto-instance | articles du jeu `caisse_base` : sans prix, prix modifié en caisse, remise type client, 6 tranches de remise quantitative, quantité 0, écart TTC < et > 1 centime | `Artpu`, `Artbrut`, `Artnet`, `Arttc`, `Artrm`, marge ; `Artpu` = « True »/« False » à quantité nulle (A07) et 6e tranche ignorée (A08) figés ; l'écart > 1 centime déclenche un `Message.Warning` (cas exclu de gb.test, voir T23) | `tests/ventilation_article/` | à faire |
| MOULINAGE-T03 | gbtest | `Maj_Totalisation` + `Verif` (écart ≤ 0,05 €) | séquences de cumuls 411 / 7xx / 709 / 445 / compte `Null`, écart de 0,03 € dans les deux sens | contenu de `Totalisation` ; ligne `cptrplus`/`cptrmoins` ajoutée ; `Verif` = `True` | `tests/totalisation/` | à faire |
| MOULINAGE-T04 | replay | Journée simple, une caisse | jeu `caisse_base` : 5 tickets clients caisse (espèces, carte, chèque, rendu), 2 familles, 2 taux de TVA, Z tiré ; écran Moulinage, date du jour, Oui ×2 | dump complet (écriture de ventes `Jnl` avec collectif, écritures de trésorerie `EcrReg` par mode, archives tickets, facture magasin + lignes, compteurs, soldes, tickets supprimés) ; PDF du livre de caisse (texte) | `tests/journee_simple/` | à faire |
| MOULINAGE-T05 | replay | Tickets d'avoir et règlements par avoir | ticket `savoir = 1` (retour d'articles), ticket d'avoir `EZ`, règlement `Z` depuis un avoir (compte `419700`) | lignes `Fiches_Mvt` des avoirs (sens), collectif (`Maj_Collectif`, insertion en journal `Jnal`), soldes `Csolde` ; HT/TVA négatifs dans la ventilation et la facture magasin | `tests/avoirs/` | à faire |
| MOULINAGE-T06 | replay | Acomptes et crédits | ticket d'encaissement d'acompte `EA`, ticket réglé par acompte `RA` (compte `419100`), crédit client `W` (`468700`) | écritures et soldes ; `Totalisation` corrigée du TTC caisse ; contrôle `Controle_Moulinage` (T17) cohérent | `tests/acomptes_credits/` | à faire |
| MOULINAGE-T07 | replay | Règlements multiples | un ticket réglé par espèces + carte + chèque + bon d'achat + chèque cadeau + ticket restaurant + autres + bonus avec rendu ; `Fiches_Reglements.regroup` vrai pour un mode, faux pour un autre ; un mode sans ligne `Fiches_Reglements` | une écriture `EcrReg` par mode (regroupée ou non par client, `majsld`/`majecr`) ; avertissement d'écart pour le mode non relié | `tests/reglements_multiples/` | à faire |
| MOULINAGE-T08 | replay | Tickets supprimés, en erreur, doublon | ticket supprimé avec lignes de règlement ; ticket client en compte supprimé ; deux tickets de même numéro le même jour | archives avec en-têtes « Ticket supprimé! » ; doublon passé en `statut = E` puis supprimé ; règlements du ticket supprimé passés en trésorerie (A04 figée) | `tests/tickets_supprimes/` | à faire |
| MOULINAGE-T09 | replay | BL réglés en caisse | 2 BL d'un client en compte réglés par un ticket (ligne `BL`), un BL d'un autre client, une facture non acquittée (`type = F`) réglée par un ticket | BL regroupé (`Ent_Bl`, partagé avec FACTURERGBL-T07), facture `ObjFacB.editef`, `Fiches_Bl` acquitté, écritures 1329-1353 et 1382-1403 (A13 figée), lettrage, soldes, `dnbon` | `tests/bl_regles_caisse/` | à faire |
| MOULINAGE-T10 | replay | Mouvements hors vente | ticket d'entrée `EH` et de sortie `SH` de caisse | `Totalisation` → `cptrplus`/`cptrmoins` ; lignes `EH`/`SH` dans la facture magasin | `tests/mouvements_hors_vente/` | à faire |
| MOULINAGE-T11 | replay | Écart de ventilation > 0,05 € | ticket dont le TTC diffère de la somme HT + TVA (jeu modifié) ; réponse OK puis, dans un second test, Annuler | OK : écriture de charge/produit exceptionnel ; Annuler : `UNLOCK`, message de restauration, état partiel (archives écrites) figé | `tests/ecart_ventilation/` | à faire |
| MOULINAGE-T12 | replay | Plusieurs caisses et dépôts | 2 caisses, dépôts différents, compte de vente par dépôt (`Fiches_FamDep`), un ticket en rétrocession (`compt5_fam`) | comptes de vente par dépôt ; livre de caisse multi-caisses avec cumuls entre caisses (A09 figée) | `tests/plusieurs_caisses/` | à faire |
| MOULINAGE-T13 | replay | Option boissons `B` et `T` | jeu `caisse_boisson` (dérivé de `facturation_boisson`) : articles à droits, avec et sans vignette ; une journée sans article à droits | facture magasin (`netht`/`nettc`/`pu`/`brut`/`rem`), `Fiches_ligregie` ; en `B` accise non retirée (CALCULDROIT1-A01) ; journée sans alcool : transaction ouverte par `comptmat` (OBJFACB-A02) et effet sur la suppression des tickets observé après déconnexion (A03) | `tests/option_boissons/` | à faire |
| MOULINAGE-T14 | replay | Rejeu sur une période déjà moulinée | après T04 : nouveau moulinage de la même date ; puis moulinage d'une date postérieure alors qu'il reste des tickets `V` plus anciens ; puis date au-delà du mois `dtepec` | messages « Aucune donnée », « Il reste des tickets », « date de facturation » ; **dump inchangé** (hors sauvegarde) | `tests/rejeu_periode_moulinee/` | à faire |
| MOULINAGE-T15 | replay | Garde-fous de lancement | caisse connectée ; Z non tiré ; mode de règlement de caisse sans liaison (`Verif_Reglement_Caisse`) ; réponse Non aux confirmations | aucun changement en base ; sauvegarde non lancée | `tests/gardes_fous/` | à faire |
| MOULINAGE-T16 | replay | Contrôle SHA-1 des tickets | ticket au `control` vide et ticket altéré ; réponses ANNULER puis OK | ANNULER : aucune écriture ; OK : moulinage complet | `tests/controle_sha1_tickets/` | à faire |
| MOULINAGE-T17 | replay | `Controle_Moulinage` | après T04/T06 : contrôle sans écart ; après modification manuelle d'une écriture : écart client caisse (Oui → `707999`/`445999`), écart par compte ; comptes d'erreur absents | messages ; écriture de correction (soldes non recalculés figés) ; `Majnum` | `tests/controle_moulinage/` | à faire |
| MOULINAGE-T18 | replay | Erreur fatale en cours de moulinage | compte `419100` absent avec un ticket `RA` ; compte de vente d'une famille absent de `Fiches_Comptes` (A17) | message du `Catch`, état partiel figé (écritures déjà passées, verrous), tickets non supprimés | `tests/erreur_fatale/` | à faire |
| MOULINAGE-T19 | replay | `Generation_Bl` depuis la caisse | caisse `-p` : ticket client en compte (articles, éco-taxe, remise, commentaire, quantité 0) | `Fiches_Bl`/`Fiches_Ligbl` créés, ligne « Ticket enr. sur BL » (partagé avec les tests de `Caisse`) ; `Totalisation` recréée (effet de bord) | `tests/generation_bl_caisse/` | à faire |
| MOULINAGE-T20 | replay | `Livre_caisse` depuis la caisse (X et Z) | caisse `-p` : ticket X puis Z avec tickets encaissés, annulés, client en compte, en erreur | X : PDF seul ; Z : `statut = V`, `fndc`, `dtefm`, `tkz = 1` ; PDF `~/TicketZ.pdf` (texte) | `tests/livre_caisse_xz/` | à faire |
| MOULINAGE-T21 | replay | Moulinage sous SQLite | T04 et T20 sur `Laurux01.sqlite` + jeu dérivé | `LOCK TABLES` neutralisé ; comportement de `Update … as e set e.statut` (ticket Z) et de la sauvegarde `mysqldump` (échec silencieux) figés | `tests/moulinage_sqlite/` | à faire |
| MOULINAGE-T22 | replay | Performance | 1 000 tickets de 5 lignes sur une journée | durée de référence (`gbx3 -p`), nombre de requêtes du log | `tests/perf_moulinage/` | à faire |
| MOULINAGE-T23 | replay | Écart de prix caisse / gestion dans `Generation_Bl` | ticket client en compte dont le TTC caisse diffère du prix de gestion de plus d'un centime par unité | `Message.Warning` puis BL au prix de gestion | `tests/ecart_prix_bl/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : toujours dans le clone **Laurux non modifié**, base
  MariaDB Docker restaurée avant chaque scénario, horloge figée (`faketime "2026-03-15 18:00:00"`),
  locale `fr_FR.UTF-8`, `HOME` jetable (sauvegarde `~/Sauve`, PDF `~/Caisse`). Les PDF sont
  comparés par leur texte (`pdftotext`), pas octet par octet.
- **Données** : `Laurux01.sql` ne contient ni caisse ni ticket. Jeu **`caisse_base`** à produire en
  phase 2 (`tests/_donnees/caisse_base.sql`, dérivé de `facturation_base` décrit dans
  [ObjFac](../../Gestion/Facturation/ObjFac.class/test.md)) : `Fiches_Caisses` (2 caisses,
  dépôts, `connecte = 0`, `tkz = 1`), `Fiches_ClientCaisse`, journaux de vente/trésorerie
  (`jrnal2`, `jrnal4`), comptes `411…`, collectif, `419100`, `419700`, `468700`, `707999`,
  `445999`, `cptrplus`/`cptrmoins`, familles avec `compt_fam`/`compt5_fam`/`coef_fam`,
  `Fiches_FamDep`, TVA, `Fiches_Reglements` reliés aux modes de caisse, tickets
  `Fiches_EntTicketz`/`Fiches_LigTicketz` **avec un `control` SHA-1 valide** (calculé par
  `Sha1Calc.CalcSha1T` dans le clone de référence). Jeu **`caisse_boisson`** dérivé de
  `facturation_boisson` pour T13. Les tickets peuvent aussi être produits en rejouant une saisie
  de caisse (tests de `Caisse`), puis figés en SQL.
- **Anomalies figées** (caractérisation) : A01 (non atteinte dans les jeux standards, cas dédié
  dans T05 avec collectif = compte client si la décision le demande), A03/A04/A05/A07/A08/A09/A10/
  A13, CALCULDROIT1-A01, OBJFACB-A02, FACTURERGBL-A03. Les tests seront mis à jour avec chaque
  correction validée.
- **Non testable automatiquement** : la concurrence multi-postes (verrous `LOCK TABLES`, A02) ;
  l'impression réelle (seul le PDF est comparé) ; `Doc.Open` (aide HTML).
- **Couverture visée** : toutes les branches de `Moulinage`, `Moulinage_Acomptes_Avoir`,
  `Maj_Compta`, `Maj_Tresorerie`, `genfac`, `Controle_Moulinage` ; `Livre_caisse` par T04, T12,
  T20 ; `Generation_Bl`/`Recup_Art` par T02, T19, T23. Le bloc 3 de `Controle_Moulinage` (A05)
  n'est pas couvrable sans correction.
