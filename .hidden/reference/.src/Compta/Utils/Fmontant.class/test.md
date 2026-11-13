# Fmontant — Tests

> Source : `.src/Compta/Utils/Fmontant.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de recherche : tests `replay` sur MariaDB Docker (`Laurux01.sql` + jeu dérivé
`data/mvt_recherche.sql` avec montants proches, libellés avec apostrophe, comptes collectifs,
écriture clôturée, écriture de trésorerie). Le résultat comparé est le contenu de la grille
`Somme` (log), les messages et, pour T06, le dump de la base.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FMONTANT-T01 | replay | Recherche par montant | `Cb1`, montants `12`, `12,5`, `0`, × type Clients/Fournisseurs/Gestion/Bilan/Tous × `CompteCol` | lignes de `Somme` de référence (filtre `coll` figé, A02) | `tests/fmontant_montant/` | implémenté |
| FMONTANT-T02 | replay | Recherche par libellé / document | `Cb2` puis `Cb3`, textes `Fac`, `L'`, vide | lignes ; erreur SQL figée pour l'apostrophe (A01) | `tests/fmontant_libelle/` | implémenté |
| FMONTANT-T03 | replay | Montant + libellé | `Cb1` + `Cb2`, combinaisons saisies/vides | messages d'avertissement ; lignes | `tests/fmontant_mixte/` | implémenté |
| FMONTANT-T04 | replay | Saisie refusée après une recherche | recherche valide puis montant vidé | avertissement puis « Traitement terminé ! » (A03 figée) | `tests/fmontant_resultat_perime/` | implémenté |
| FMONTANT-T05 | replay | Clôture | clic sur écriture clôturée / non clôturée, puis sur une autre ligne | message ou bouton `Necrit` (comportement `Item`/`Current` figé, A04) | `tests/fmontant_cloture/` | implémenté |
| FMONTANT-T06 | replay | Modification | `Necrit` sur écriture de trésorerie et ordinaire, modification du libellé | dump `Fiches_Mvt` et `Fiches_Comptes.solde` | `tests/fmontant_modification/` | à faire : passe par Saisecrit (écran complexe, scénarios à valider par l'utilisateur) ; branche Tresor non commencée (temps) |
| FMONTANT-T07 | gbtest | Construction du filtre (après FMONTANT-004) | combinaisons type de compte × `CompteCol` | chaîne `req` identique à celle capturée en T01 | `tests/fmontant_filtre/` | à faire : attend l'extraction FMONTANT-004 (fonction de filtre) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (log du replay : lignes
  ajoutées à `Somme`, messages ; lignes `Exec_SQL` pour T01-T03).
- T07 n'existe qu'après l'extraction de la fonction de filtre ; il compare au texte SQL capturé en
  T01.
- **Non testable automatiquement** : le son (`Music.Play`), l'aide `Doc.Open`, le rendu des
  couleurs d'édition.
- **Assets** (`.hidden/Tests/Compta/assets/`) : jeu partagé `fmontant_shared/fmontant_mvt.sql` (5 écritures 2018 :
  montants 12 / 12,50 / 125 / 120, libellé « L'achat fournisseur », trésorerie, clôturée, compte collectif
  401000) ; scénarios `fmontant_montant` (T01 : 12 × Tous/Clients/Fournisseurs, 12,5 × Compte collectif + Tous ;
  Gestion et Bilan suivent le même chemin que Clients), `fmontant_libelle` (T02 : « Fac », « CHQ », puis « L' » →
  erreur fatale figée, `code_sortie` 125 ; le cas libellé vide est couvert par T03/T04), `fmontant_mixte` (T03),
  `fmontant_resultat_perime` (T04, A03 confirmée : avertissement puis « Traitement terminé ! »), `fmontant_cloture`
  (T05). Résultat comparé : requêtes de `sql.log` (`compare_sql_log` ordered) ; la grille `Somme` n'est pas comparée.
- **T05 / A04** : au rejeu, le clic sur une ligne non clôturée interroge bien `numero` de la ligne cliquée
  (`Somme.Item` suit la ligne cliquée) : A04 n'est pas reproduite par le rejeu.
