# Gsm — Tests

> Source : `.src/Gestion/SMS/Gsm.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : scénarios `replay` capturés dans le clone **Laurux non modifié**, dans un `HOME`
isolé, avec de **faux binaires** `gammu` et `curl` en tête du `PATH` : ils écrivent leurs
arguments dans `$HOME/argv.txt` et impriment une réponse fixe (`OK` pour gammu ;
`{"resultat":1}` ou `{"premium":"5","lowcost":"0","mobile":…}` pour Spot-Hit selon l'URL). Aucun
appel réseau ni modem réel. Base `Laurux01.sql` + jeu `sms_textes` (commun avec SMS-T01).
Comparaison : `argv.txt`, messages affichés, sortie standard (lignes `Print`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GSM-T01 | replay | Ouverture depuis la fiche client | `FClient`, portable `06 12.34.56.78`, bouton SMS | `TextBox1 = 0612345678` ; appels du faux `curl` (crédits) relevés pour statuer sur `TextLabel1_GotFocus` | `tests/ouverture_fclient/` | à faire |
| GSM-T02 | replay | Choix d'un texte prédéfini | F2/bouton liste, clic sur `02` | `Comcode`/`Intitule` remplis avec le texte complet | `tests/choix_texte/` | à faire |
| GSM-T03 | replay | Envoi support 1 (gammu) | `/Support = 1- …`, numéro, texte multi-ligne | `argv.txt` de gammu de référence ; message « envoyé » | `tests/envoi_gammu/` | à faire |
| GSM-T04 | replay | Envoi support 2 (Spot-Hit) premium et lowcost | `/Support = 2- …`, `/Type`, `/Expediteur` avec espace | URL de référence (espaces → `+`) ; message « envoyé » ; réponse d'échec → « Problème ! » | `tests/envoi_spothit/` | à faire |
| GSM-T05 | replay | Envoi support 3 (Hosteur) | `/Support = 3`, `/Hidentifiant`, `/Hmdp` fictifs | URL de référence (paramètre `encodage` mal formé, figé) ; ligne `Print` contenant le mot de passe (figé, A02) ; aucun message | `tests/envoi_hosteur/` | à faire |
| GSM-T06 | replay | Texte avec caractères spéciaux | texte contenant `"`, `&`, `é`, `$(touch $HOME/pwned)` | figer la commande exécutée et la présence de `$HOME/pwned` (preuve de l'injection, A01), dans le `HOME` jetable uniquement | `tests/injection/` | à faire |
| GSM-T07 | replay | Numéro vide / texte vide | sans numéro ; numéro sans texte | rien n'est envoyé ; SMS vide envoyé (figé, A06) | `tests/saisie_vide/` | à faire |
| GSM-T08 | replay | Table des textes vide ou absente | base sans ligne puis sans table `Fiches_Sms` | avertissement « aucun Texte sms » ; « La table des textes SMS n'existe pas... » | `tests/textes_absents/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié avec les mêmes faux binaires
  et la même configuration ; `~/tmp/sms.txt` est supprimé avant chaque scénario.
- **Identifiants** : uniquement des valeurs fictives (`CLE_TEST`, `mdp_test`) ; ne jamais lancer
  ces scénarios avec un `Laurux.conf` réel (la clé ou le mot de passe seraient imprimés).
- **Non testable sans matériel ou service réel** : envoi effectif par modem GSM (`gammu` sur port
  série/USB, carte SIM), délivrance par Spot-Hit ou Hosteur, crédits réels ; seules la commande
  produite et l'interprétation d'une réponse simulée sont vérifiées.
- **Rejeu** : `Utils.Observers(Me)` appelé une fois ; `Colcol_Click` existe (pas de
  `replay_missing`). Si `TextLabel1_GotFocus` n'est jamais levé (T01), les messages de crédit ne
  font pas partie des scénarios.
