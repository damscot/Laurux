# Trecarts — Tests

> Source : `.src/Compta/Trecarts.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Traitement de masse déclenché par un bouton, sans API publique : tous les tests sont des
**replays**. Le critère est le dump normalisé de `Fiches_Mvt`, `Fiches_Comptes` (soldes) et
`Fiches_Parametres` (`numecriture`), colonne `dte` masquée (date du jour) et colonne `control`
(SHA1) comparée telle quelle entre les deux clones.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRECARTS-T01 | replay | Écarts clients | jeu dérivé : 3 lots clients non lettrés d'écart +0,03, -0,04 et +0,50 ; seuil `0,05`, Clients | 2 écritures générées (tiers + 758/658 + collectif), lots lettrés en `E…`, soldes mis à jour (signe des comptes de régularisation figé, A01), `numecriture` +2 ; lot à 0,50 inchangé | `tests/ecarts_clients/` | implémenté |
| TRECARTS-T02 | replay | Écarts fournisseurs | même principe sur des comptes `F` | idem T01 côté fournisseurs | `tests/ecarts_fournisseurs/` | implémenté |
| TRECARTS-T03 | replay | Aucun écart | jeu où tous les lots sont soldés ou au-delà du seuil | message « 0 écriture(s) » ; base inchangée | `tests/aucun_ecart/` | implémenté |
| TRECARTS-T04 | replay | Seuil invalide | `Montant` = `abc` puis lancement | avertissement « Veuillez verifier votre montant » ; base inchangée | `tests/seuil_invalide/` | à faire : un montant invalide ne se saisit pas (Montant_KeyPress filtre les lettres) et « 1.2.3 » ouvre la boîte depuis Montant_LostFocus avant Button2 (non rejouable) |
| TRECARTS-T05 | replay | Compteur du message | lot à écart débiteur (ligne 658) | message final avec compteur actuel (A02 figée) | `tests/compteur_message/` | implémenté (scénario trecarts_ecarts_clients, lot 411001 → ligne 658000) |
| TRECARTS-T06 | replay | Compte sans collectif | compte client sans `coll_cc` avec un écart | ligne collectif sur compte vide (comportement actuel figé, A04, à confirmer) | `tests/sans_collectif/` | xfail : erreur SQL fatale (compte NULL), code 125 figé |
| TRECARTS-T07 | replay | Lot multi-lignes | lot de 4 lignes non lettrées sur un même compte | une seule écriture générée ; les 4 lignes lettrées sous le même numéro `E…` | `tests/lot_multilignes/` | implémenté (scénario trecarts_ecarts_clients, lot 411004) |
| TRECARTS-T08 | replay | SQLite | T01 sur la base `Laurux01.sqlite` | même dump logique qu'en MySQL (`LOCK TABLES` neutralisé, `cast(... AS char)`) | `tests/sqlite/` | à faire : runner sans base SQLite |

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

## Implémentation (phase 2, vague 4)

- Jeu partagé `.hidden/Tests/Compta/assets/trecarts_shared/trecarts_ecarts.sql` (seuil 0,05, `numecriture` 100) :
  lots clients 411001 (+0,03), 411002 (-0,04), 411003 (0,50, hors seuil), 411004 (4 lignes, +0,02) ; lots
  fournisseurs 401001 (-0,02), 401002 (+0,01).
- Scénarios `trecarts_ecarts_clients` (T01, couvre aussi T05 et T07 : même traitement de masse),
  `trecarts_ecarts_fournisseurs` (T02), `trecarts_aucun_ecart` (T03, Laurux01 sans écriture, sql.log ordonné),
  `trecarts_sans_collectif` (T06, jeu propre `trecarts_sans_coll.sql`).
- T06 : la ligne collectif est insérée avec `compte = NULL` → « Column 'compte' cannot be null »
  (Trecarts.Button2_Click.266), erreur fatale (code 125) figée, xfail par rapport au résultat décrit (ligne sur
  compte vide) ; `LOCK TABLES` reste posé (A03).
- `dte` des écritures générées = `Now` sous faketime (tolérance d'horodatage du runner).
