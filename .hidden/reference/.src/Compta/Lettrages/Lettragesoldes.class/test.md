# Lettragesoldes — Tests

> Source : `.src/Compta/Lettrages/Lettragesoldes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Traitement de masse : `replay` avec dump normalisé de `Fiches_Mvt` et texte du message, puis
`gbtest` sur la fonction extraite. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LETTRAGESOLDES-T01 | replay | Clients sur la base de référence | `Laurux01.sql` ; menu, Clients, Lancer | dump `Fiches_Mvt` ; message (nombre de comptes) | `tests/clients_reference/` | à faire |
| LETTRAGESOLDES-T02 | replay | Fournisseurs | même base, radio Fournisseurs | dump `Fiches_Mvt` ; message | `tests/fournisseurs_reference/` | à faire |
| LETTRAGESOLDES-T03 | replay | Jeu dérivé contrôlé | compte soldé dont les lignes non lettrées ont des lots différents ; compte soldé dont le premier lot est NULL ; compte non soldé | lettrage partiel (A01) et compte compté sans lettrage figés ; compte non soldé intact | `tests/jeu_controle/` | à faire |
| LETTRAGESOLDES-T04 | gbtest | `LettrerComptesSoldes` (après LETTRAGESOLDES-005) | jeu de T03 | nombre de comptes ; dump identique à T03 | `tests/calcul/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; le jeu de T03 fixe `Fiches_Comptes.solde` et insère des écritures
  par script SQL (sans passer par `Csolde`).
- **Comparaison** : dump de `Fiches_Mvt` (`numlot`, `lettree`, `control`).
- **Non couvert** : la page d'aide ouverte par `Button1_Click` (vérification manuelle).
