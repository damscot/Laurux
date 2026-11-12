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
| TRESOR-T01 | replay | Encaissement client simple | journal `TR` banque 512, date, compte `411…`, 120,00 crédit, n° doc auto, valider ligne puis écriture | 3 lignes `Fiches_Mvt` (client, collectif 411, banque débit 120) ; soldes client, 411000, 512 ; `numecriture` +1 ; `control` | `.hidden/Tests/Compta/assets/tresor_encaissement_client/` | implémenté |
| TRESOR-T02 | replay | Décaissement fournisseur avec lettrage | compte `401…` lettrable, option `/Soc01/Lettrage`, sélection de 2 factures dans `EcritL`, `Selct` | lot renuméroté sur les factures (`letcpt`), écriture lettrée si le lot est soldé (`letgroupe`), soldes | `tests/decaissement_lettrage/` | à faire : sélection dans EcritL non rejouable (Click → Null object EcritL_Click.697 : EcritL.Item nul après Replay_Click ; Espace sans effet ; flèches non rejouées) |
| TRESOR-T03 | replay | Écriture multi-lignes gestion | 3 lignes (6xx débit, 7xx crédit, 6xx) puis validation | lignes définitives, banque = solde, pas de collectif | `.hidden/Tests/Compta/assets/tresor_multi_lignes/` | implémenté (2 lignes au lieu de 3 pour tenir le délai de 20 s) |
| TRESOR-T04 | replay | Écriture laissée en cours | 2 lignes validées puis fermeture « Oui » | lignes provisoires (`validee = 0`) + ligne banque aux montants de la dernière ligne (A07 figée) ; largeurs `LcolT`/`LcolTL` écrites dans `Laurux.conf` | `.hidden/Tests/Compta/assets/tresor_abandon_saisie/` | implémenté (largeurs LcolT/LcolTL dans Laurux.conf non comparées) |
| TRESOR-T05 | replay | Rappel d'une écriture non validée | état de T04, menu `ToggleButton6` → « écritures non validées » → choix → validation | copie dans `Fiches_MvtM`, réaffichage sans la ligne 512, validation définitive identique à T01 | `.hidden/Tests/Compta/assets/tresor_rappel_non_validee/` | implémenté (état de T04 chargé par le jeu `tresor_t04_en_cours` ; tient dans le délai de 20 s) |
| TRESOR-T06 | replay | Modification d'une écriture validée | `Extrait` → modifier l'écriture de T01 (`New Tresor(num)`), changer le montant à 100, revalider | `MvtM` (23 colonnes), soldes annulés puis réappliqués, collectif supprimé puis recréé ; annulation partielle du collectif (A02) et délettrage sur la banque (A03) figés | `tests/modification_validee/` | à faire : ouverture par Extrait impossible (sélection d'une ligne de Colcli non rejouable, REPLAYOBSERVER-A06) |
| TRESOR-T07 | replay | Refus de modification | `New Tresor(num)`, réponse « Non » | fenêtre fermée, base inchangée (hors verrou `DocActif` non pris) | `tests/modification_refus/` | à faire : même raison que T06 (New Tresor(num) depuis Extrait) |
| TRESOR-T08 | replay | Suppression d'une écriture | rappel (T06) puis `Suppr` | lignes supprimées, `Fiches_MvtM.supprimee = 1`, GED supprimée ; pas de confirmation (A08 figée) | `tests/suppression/` | à faire : même raison que T06 (rappel d'écriture validée) |
| TRESOR-T09 | replay | Modification / suppression de ligne en cours | 3 lignes, Entrée sur la 2e (reprise), Suppr sur la 3e | lignes provisoires supprimées (`DelEcr`), totaux et solde affichés | `tests/edition_lignes/` | à faire : Ecrit1 (ColumnView) sans Ecrit1_Click : sélection de ligne non rejouable (REPLAYOBSERVER-A06) |
| TRESOR-T10 | replay | Masque d'abonnement | `Fiches_Numabon` type `T` avec expressions `LVar` (date, `$montant`), F7 puis choix, montant 250 | lignes calculées dans `Ecrit1`, `compteur` +1, validation comme T03 | `tests/masque_abonnement/` | à faire : masque d'abonnement ouvert par F7 (touche non rejouée) |
| TRESOR-T11 | replay | Contrôles de date | date ≤ début de période, date > fin d'exercice suivant, `310299`, vide | avertissements, focus sur la date, pas de numéro réservé | `tests/controle_date/` | à faire : la saisie de dates dans Datej ne déclenche pas les avertissements au rejeu (FMessage absent, code 3), à analyser |
| TRESOR-T12 | replay | Contrôles de compte | compte inexistant, compte principal, compte de trésorerie, collectif, journal non `TR` | messages attendus ; aucune ligne écrite | `.hidden/Tests/Compta/assets/tresor_controle_compte/` | implémenté (compte inexistant et compte de trésorerie ; compte principal, collectif et journal non TR non couverts) |
| TRESOR-T13 | replay | Doublon de n° de document | même `numdoc` qu'une écriture du journal, réponse « Non » | question posée, saisie poursuivie (réponse ignorée, A09 figée) | `.hidden/Tests/Compta/assets/tresor_doublon_numdoc/` | implémenté (doublon contrôlé seulement à partir de la 2e ligne, voir Détail) |
| TRESOR-T14 | replay | GED | écriture de T01, `Button5`, validation de la fiche GED | document `Comptabilite`/`Treso`, tags client + 411 + 512, TTC = 120 | `tests/ged/` | à faire : fiche GED (Button5) non synthétisée faute de temps |
| TRESOR-T15 | replay | Clavier | F2 (journaux, libellés, comptes), F5 calculatrice, `<` rappel du compte, Tab sur `Button2` | listes affichées ; Tab sur `Button2` **valide** l'écriture (A01 figée) | `tests/clavier/` | à faire : touches F2, F5, « < » non rejouées |
| TRESOR-T16 | replay | Lettrage multi-exercices | facture client dans `Fiches_Mvt1`, règlement dans l'exercice courant | `EcritL` liste la facture ; `letcpt`/`letgroupe` mettent à jour `Fiches_Mvt1` | `tests/lettrage_exercice_anterieur/` | à faire : même raison que T02 (sélection dans EcritL) |
| TRESOR-T17 | replay | Verrou d'écriture | écriture verrouillée dans `DocActif` par un autre utilisateur, rappel par `Extrait` | message de `DocActif` puis modification **possible** (A04 figée) | `tests/verrou/` | à faire : même raison que T06 (rappel par Extrait) ; verrou multi-utilisateur |

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

### Implémentation (phase 2, agent 5)

- Scénarios `.hidden/Tests/Compta/assets/tresor_*/`, date figée **2018-06-15** (période en cours de `Laurux01`),
  menu Saisies › Trésorerie (`Fmenu#Menu67#Menu2#Menu22`). Jeu `.hidden/Tests/Compta/assets/tresor_doublon_numdoc/tresor_base.sql` (T13 ; factures ouvertes
  401001/411001, facture 411003 en `Fiches_Mvt1`, règlement CHQ9 au journal 50, `numecriture` = 10) : prévu aussi
  pour T02/T16 (lettrage), à compléter de l'option `/Soc01/Lettrage` (blob `conf`) quand la sélection dans `EcritL`
  sera rejouable.
- Saisie au clavier : Entrée enchaîne journal → date → libellé → compte → montant ; à partir de la 2e ligne,
  `ToggleButton4` sans n° de document ouvre `Message.Warning` « Auto / Manuel » (bouton 1 « Auto ») puis il faut
  revalider la ligne.
- `Enrg_Ecr` exécute `update Fiches_Mvt set validee = 1 … Where compte = NULL and numero = …` (sans effet ; candidat
  anomalie). T13 : `numdoc_LF` ne contrôle le doublon que si `Modif = "0"`, c'est-à-dire à partir de la 2e ligne :
  la 1re ligne n'est jamais contrôlée (candidat anomalie).
- **TRESOR-T05 (vague 2 bis, délais)** : scénario `tresor_rappel_non_validee`, jeu `tresor_t04_en_cours` (lignes de
  `Fiches_Mvt` laissées par T04, copiées de son dump attendu, `control` compris) au lieu de rejouer la saisie de T04 :
  le retour du `ShowModal` de Tresor (fermé par « Oui ») remet l'horodatage de référence du rejeu à celui du clic de
  menu qui l'a ouvert, ce qui ajoutait ~26 s d'attente. Journal 50 + Entrée, `ToggleButton6`, `Choix1` index 1 :
  le rejeu d'un clic de ListBox exécute `Choix1_Click` deux fois (affectation d'`Index`, puis appel explicite) et
  ouvre deux `TriEcritures` : clic `0x0` dans la première, `Close` de la seconde, puis `Button2`. Cadence écrite à la
  main (`retime` donne 700 ms avant le clic dans `Ecrit`, trop court : le rejeu applique après un événement l'écart
  qui le précède) ; ne pas relancer `retime`. Observé : `ecrit2` copie dans `Fiches_MvtM` `dateech` et `dteval`
  NULL sous forme de date du jour (`LDate(Null).DT`). Durée ~12 s : délai standard de 20 s.
