# TestCaisses — Synthèse

> Source : `.src/Caisse/TestCaisses.module` · Synthèse des autres documents.

## Rôle

Contrôle d'exécution de la connexion en caisse (**pas** un harnais de test) : `TestCai` vérifie,
via les fichiers `~/Caisse1.lock` à `~/Caisse10.lock`, qu'une caissière n'est pas déjà connectée
sur une autre caisse du poste, et affiche un avertissement sinon.

## Points clés

- Appelé deux fois par `Ouverture` (choix de la caissière, validation de la connexion).
- Rien à convertir en gb.test (aucun `Internal_Test`) ; testable en gb.test après séparation du
  `Message.Warning` (TESTCAISSES-002).
- Retour Integer converti implicitement en `String` `"0"`/`"1"`.
- Remplace `Dcaisses.TestCai` (code mort).

## Dépendances principales

- Appelant : `Ouverture`. Données : verrous écrits par `Ouverture.Button1_Click`, supprimés par
  `Fondcaisse` (`~/Caisse.lock`, sans numéro : à vérifier dans son lot).

## Risques

- Faux conflits entre vendeurs de même premier caractère (A02) : blocage de connexion.
- Message trompeur (code vendeur au lieu du numéro de caisse, A01).
- Verrous locaux au poste : aucun contrôle multiposte.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 25 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 6 (`TestCai`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests : 2 `gbtest` (cas sans conflit, puis fonction pure après TESTCAISSES-002) et 2 `replay`
sur l'écran `Ouverture` (conflit réel, faux conflit), valeurs capturées dans le clone non modifié.

## Rework

4 étapes sans changement de comportement (TESTCAISSES-001 à 004) : documentation, séparation
du message, fermeture du fichier, module commun des verrous de caisse. 2 anomalies
(TESTCAISSES-A01, A02) soumises à validation.
