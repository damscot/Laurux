# Trecarts — Tests

> Source : `.src/Compta/Trecarts.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Traitement de masse déclenché par un bouton, sans API publique : tous les tests sont des
**replays**. Le critère est le dump normalisé de `Fiches_Mvt`, `Fiches_Comptes` (soldes) et
`Fiches_Parametres` (`numecriture`), colonne `dte` masquée (date du jour) et colonne `control`
(SHA1) comparée telle quelle entre les deux clones.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRECARTS-T01 | replay | Écarts clients | jeu dérivé : 3 lots clients non lettrés d'écart +0,03, -0,04 et +0,50 ; seuil `0,05`, Clients | 2 écritures générées (tiers + 758/658 + collectif), lots lettrés en `E…`, soldes mis à jour (signe des comptes de régularisation figé, A01), `numecriture` +2 ; lot à 0,50 inchangé | `tests/ecarts_clients/` | à faire |
| TRECARTS-T02 | replay | Écarts fournisseurs | même principe sur des comptes `F` | idem T01 côté fournisseurs | `tests/ecarts_fournisseurs/` | à faire |
| TRECARTS-T03 | replay | Aucun écart | jeu où tous les lots sont soldés ou au-delà du seuil | message « 0 écriture(s) » ; base inchangée | `tests/aucun_ecart/` | à faire |
| TRECARTS-T04 | replay | Seuil invalide | `Montant` = `abc` puis lancement | avertissement « Veuillez verifier votre montant » ; base inchangée | `tests/seuil_invalide/` | à faire |
| TRECARTS-T05 | replay | Compteur du message | lot à écart débiteur (ligne 658) | message final avec compteur actuel (A02 figée) | `tests/compteur_message/` | à faire |
| TRECARTS-T06 | replay | Compte sans collectif | compte client sans `coll_cc` avec un écart | ligne collectif sur compte vide (comportement actuel figé, A04, à confirmer) | `tests/sans_collectif/` | à faire |
| TRECARTS-T07 | replay | Lot multi-lignes | lot de 4 lignes non lettrées sur un même compte | une seule écriture générée ; les 4 lignes lettrées sous le même numéro `E…` | `tests/lot_multilignes/` | à faire |
| TRECARTS-T08 | replay | SQLite | T01 sur la base `Laurux01.sqlite` | même dump logique qu'en MySQL (`LOCK TABLES` neutralisé, `cast(... AS char)`) | `tests/sqlite/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est capturé dans le clone **Laurux non
  modifié** (`./Laurux -l --logfile …`, `-c <conf de test>`) puis rejoué sur les deux clones ; dump
  normalisé et diff. Les reworks TRECARTS-004 (un seul `UPDATE` de lettrage, pas de relecture du
  collectif) modifient les lignes `Exec_SQL` : seul le dump fait foi pour eux.
- **Données** : `Laurux01.sql` + jeu dérivé `ecarts.sql` (comptes `411T01…`, `401T01…`, lots
  numérotés, `Fiches_Parametres.ecart = 0.05`, `cptrplus`/`cptrmoins` renseignés).
- **Date** : `dte` des écritures générées = date du jour → masquée ou fixée par le runner.
- **Non testable automatiquement** : erreur SQL au milieu d'un lot (tables restant verrouillées,
  A03) — vérifiable seulement par injection de faute manuelle ; sons et curseur.
