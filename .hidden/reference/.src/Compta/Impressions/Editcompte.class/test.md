# Editcompte — Tests

> Source : `.src/Compta/Impressions/Editcompte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran : tests `replay`. Le rendu PDF (bouton **Imprimer**) est couvert par
[`EditcompteM`](../EditcompteM.module/test.md) ; ici : bornes, contrôles de saisie, export texte et
table `Ctrln`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITCOMPTE-T01 | replay | Ouverture et bornes d'exercice | ouverture (date du jour fixée), puis `E1`, `N1`…`N5`, `E0` | `dteN0`/`dteN1`, `cpt`/`cpt2` (`411999999`) après chaque étape | `tests/bornes_exercice/` | implémenté (requêtes Fiches_Parametres ; dates et comptes affichés non comparés) |
| EDITCOMPTE-T02 | replay | Ouverture avec début d'exercice futur | jeu où `dteclec` est postérieur à aujourd'hui | dates affichées (chemin `Exo` de `_New`) | `tests/ouverture_debut_futur/` | à faire : seul l'affichage diffère (dates non comparées par le rejeu) |
| EDITCOMPTE-T03 | replay | Contrôle du préfixe de compte | pour chaque nature, Entrée sur `cpt` puis `cpt2` avec un compte valide et un invalide | messages et focus ; en gestion, `cpt2` toujours refusé (A01 figée) | `tests/controle_compte/` | implémenté partiellement (client : Cpt = 401 → avertissement) ; à faire : cas gestion (Cpt2 refusé, A01) non déclenché au rejeu (Entrée sur Cpt2 après Bgestion sans boîte, code 3) |
| EDITCOMPTE-T04 | replay | Contrôle des dates | `dteN0` hors période, `dteN1` avant le début, après la fin, `dteN1 < dteN0` | messages, focus (`dteN0` pour A03), période remise sur `Exo` (A04) | `tests/controle_dates/` | à faire : contrôles de dates non scénarisés (durée de la vague) |
| EDITCOMPTE-T05 | replay | Export grand livre client | `Bclient`, période courante, **Exporter** | `~/tmp/Glivre.txt` de référence | `tests/export_client/` | implémenté |
| EDITCOMPTE-T06 | replay | Export avec compte centralisé | compte `cent_cc = 1` avec écritures sur 3 mois et 2 journaux | lignes « Centralisation » mensuelles ; dump : contenu final de `Ctrln` | `tests/export_centralise/` | implémenté |
| EDITCOMPTE-T07 | replay | Export grand livre général | `Bgen`, 10000 → 99999999 | comptes `B` puis `G`, ordre `type_cc, compte` | `tests/export_general/` | implémenté |
| EDITCOMPTE-T08 | replay | Export sans compte | plage vide, puis un export normal | message « Aucune ecriture… » ; le second export réussit malgré le fichier resté ouvert (A05) | `tests/export_vide/` | implémenté |
| EDITCOMPTE-T09 | replay | `TriCpt` | F2 sur `cpt` en `Bgen` puis en `Bclient` | `TriCpt` en mode `Tous` puis `Client` ; `cpt` rempli | `tests/tricpt/` | à faire : touche F2 non rejouée |
| EDITCOMPTE-T10 | replay | Export sur exercice archivé | `N2`, **Exporter** | lecture de `Fiches_Mvt2` | `tests/export_n2/` | implémenté |

## Détail des tests

- **Données** : jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)),
  avec en plus un compte centralisé (`cent_cc = 1`) mouvementé sur plusieurs mois et journaux, et des
  écritures dans `Fiches_Mvt2`.
- **Base** : l'export **écrit** en base (table `Ctrln`, détruite et recréée) : le dump après le test est
  comparé à la référence (contenu de `Ctrln` inclus). Le diff `Exec_SQL` est informatif.
- **Date du jour** : `_New` et `Ex1` dépendent de `Now` : `faketime` pour T01/T02, dates saisies sinon.
- **`finmois`** : couvert par T06 (fins de mois 28/29/30/31 dans le jeu, dont février bissextile) ; un
  test `gbtest` direct est porté par [EditcompteM](../EditcompteM.module/test.md) (fonction identique).
- **Non testable automatiquement** : son, coloration du focus, aide HTML, ouverture de l'éditeur
  (neutralisée par `/CmdEditor0`).

- **Phase 2 (agent 3, vague 3)** : scénarios `.hidden/Tests/Compta/assets/editcompte_<nom>/` (`bornes_exercice`,
  `controle_compte`, `export_client`, `export_centralise`, `export_general`, `export_vide`, `export_n2`).
  `tmp/Glivre.txt` comparé (`"fichiers"`), `Ctrln` dans le dump. Jeux : `Compta/extrait_shared/extrait_base`
  (réutilisé en lecture), `editcompte_export_centralise/editcompte_centralise.sql` (707000 centralisé,
  janvier/février/avril, journaux 70/71), `editcompte_export_n2/editcompte_n2.sql` (Fiches_Mvt2 2016).
  Réponse à la question « Voulez-vous l'ouvrir ? » : bouton 2 « Non » (Tab + Espace).
  Observé : la ligne « Centralisation » de février porte le journal de la dernière écriture lue (71).
  T08 : un clic sur `Bclient` déjà coché ne relance pas `Bclient_Click` au rejeu (la plage reste vide) ;
  le second export se fait donc en `Bfournisseur`.
