# Tresor — Tests

> Source : `.src/Compta/Tresor.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans API publique autre que le constructeur : tous les tests sont des **replays**.
Le critère est le dump normalisé de `Fiches_Mvt` (et `Fiches_Mvt1` pour le lettrage), `Fiches_MvtM`,
`Fiches_Comptes` (`solde`), `Fiches_Parametres` (`numecriture`), `Fiches_Numabon` (`compteur`) et de
la table des documents actifs (`DocActif`). Colonnes volatiles masquées : `datem`, `lind`/`lind2`
auto-incrémentés (comparés par rang), dates du jour. La colonne `control` (SHA1) est comparée telle
quelle : elle valide l'ordre et le contenu des lignes écrites.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRESOR-T01 | replay | Encaissement client simple | journal `TR` banque 512, date, compte `411…`, 120,00 crédit, n° doc auto, valider ligne puis écriture | 3 lignes `Fiches_Mvt` (client, collectif 411, banque débit 120) ; soldes client, 411000, 512 ; `numecriture` +1 ; `control` | `tests/encaissement_client/` | à faire |
| TRESOR-T02 | replay | Décaissement fournisseur avec lettrage | compte `401…` lettrable, option `/Soc01/Lettrage`, sélection de 2 factures dans `EcritL`, `Selct` | lot renuméroté sur les factures (`letcpt`), écriture lettrée si le lot est soldé (`letgroupe`), soldes | `tests/decaissement_lettrage/` | à faire |
| TRESOR-T03 | replay | Écriture multi-lignes gestion | 3 lignes (6xx débit, 7xx crédit, 6xx) puis validation | lignes définitives, banque = solde, pas de collectif | `tests/multi_lignes/` | à faire |
| TRESOR-T04 | replay | Écriture laissée en cours | 2 lignes validées puis fermeture « Oui » | lignes provisoires (`validee = 0`) + ligne banque aux montants de la dernière ligne (A07 figée) ; largeurs `LcolT`/`LcolTL` écrites dans `Laurux.conf` | `tests/abandon_saisie/` | à faire |
| TRESOR-T05 | replay | Rappel d'une écriture non validée | état de T04, menu `ToggleButton6` → « écritures non validées » → choix → validation | copie dans `Fiches_MvtM`, réaffichage sans la ligne 512, validation définitive identique à T01 | `tests/rappel_non_validee/` | à faire |
| TRESOR-T06 | replay | Modification d'une écriture validée | `Extrait` → modifier l'écriture de T01 (`New Tresor(num)`), changer le montant à 100, revalider | `MvtM` (23 colonnes), soldes annulés puis réappliqués, collectif supprimé puis recréé ; annulation partielle du collectif (A02) et délettrage sur la banque (A03) figés | `tests/modification_validee/` | à faire |
| TRESOR-T07 | replay | Refus de modification | `New Tresor(num)`, réponse « Non » | fenêtre fermée, base inchangée (hors verrou `DocActif` non pris) | `tests/modification_refus/` | à faire |
| TRESOR-T08 | replay | Suppression d'une écriture | rappel (T06) puis `Suppr` | lignes supprimées, `Fiches_MvtM.supprimee = 1`, GED supprimée ; pas de confirmation (A08 figée) | `tests/suppression/` | à faire |
| TRESOR-T09 | replay | Modification / suppression de ligne en cours | 3 lignes, Entrée sur la 2e (reprise), Suppr sur la 3e | lignes provisoires supprimées (`DelEcr`), totaux et solde affichés | `tests/edition_lignes/` | à faire |
| TRESOR-T10 | replay | Masque d'abonnement | `Fiches_Numabon` type `T` avec expressions `LVar` (date, `$montant`), F7 puis choix, montant 250 | lignes calculées dans `Ecrit1`, `compteur` +1, validation comme T03 | `tests/masque_abonnement/` | à faire |
| TRESOR-T11 | replay | Contrôles de date | date ≤ début de période, date > fin d'exercice suivant, `310299`, vide | avertissements, focus sur la date, pas de numéro réservé | `tests/controle_date/` | à faire |
| TRESOR-T12 | replay | Contrôles de compte | compte inexistant, compte principal, compte de trésorerie, collectif, journal non `TR` | messages attendus ; aucune ligne écrite | `tests/controle_compte/` | à faire |
| TRESOR-T13 | replay | Doublon de n° de document | même `numdoc` qu'une écriture du journal, réponse « Non » | question posée, saisie poursuivie (réponse ignorée, A09 figée) | `tests/doublon_numdoc/` | à faire |
| TRESOR-T14 | replay | GED | écriture de T01, `Button5`, validation de la fiche GED | document `Comptabilite`/`Treso`, tags client + 411 + 512, TTC = 120 | `tests/ged/` | à faire |
| TRESOR-T15 | replay | Clavier | F2 (journaux, libellés, comptes), F5 calculatrice, `<` rappel du compte, Tab sur `Button2` | listes affichées ; Tab sur `Button2` **valide** l'écriture (A01 figée) | `tests/clavier/` | à faire |
| TRESOR-T16 | replay | Lettrage multi-exercices | facture client dans `Fiches_Mvt1`, règlement dans l'exercice courant | `EcritL` liste la facture ; `letcpt`/`letgroupe` mettent à jour `Fiches_Mvt1` | `tests/lettrage_exercice_anterieur/` | à faire |
| TRESOR-T17 | replay | Verrou d'écriture | écriture verrouillée dans `DocActif` par un autre utilisateur, rappel par `Extrait` | message de `DocActif` puis modification **possible** (A04 figée) | `tests/verrou/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est capturé dans le clone **Laurux non
  modifié** (`./Laurux -l --logfile …`, `-c <conf de test>`), puis rejoué sur les deux clones ; dump
  normalisé et diff. Pour les reworks marqués « SQL modifié, dump identique », seul le dump fait foi.
- **Données** : `Laurux01.sql` + jeu dérivé `tresor.sql` : journal `TR` lié à `512000`, clients et
  fournisseurs lettrables avec factures ouvertes (dont une dans `Fiches_Mvt1`), libellés types,
  masque d'abonnement de type `T`, `Fiches_Parametres` (`numecriture`, `dtepc`, `dteclec`) cohérent
  avec la date fixée par le runner.
- **Date du jour** : la date de saisie par défaut et `datem` dépendent de `Now` ; le runner fixe la
  date ou masque ces colonnes.
- **Scénarios multi-écrans** : T06, T07, T17 passent par `Extrait` ; T05 par `TriEcritures` ; T02 et
  T16 par `Listextcpt`. Ils servent aussi de non-régression pour ces fichiers.
- **Concurrence** : la réservation de numéro sans verrou (A05) n'est pas testable par replay mono-poste
  (deux instances simultanées nécessaires) ; documenté comme test manuel.
- **Non testable automatiquement** : sons, couleurs de focus, aide HTML, `Wait 0.2` de `Choix1_Click`.
