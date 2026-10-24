# LScript — Synthèse

> Source : `.src/Utils/LScript.class` · Synthèse des autres documents.

## Rôle

Lancement journalisé d'un programme externe avec ses arguments, par shell ou par `Exec`, utilisé par
la GED (`LGed`) pour la numérisation multipage et la conversion en PDF. Fabrique `LScript(...)` via
`_call` (`Create Static`), enchaînement par `LScript.RunA`.

## Points clés

- `Run` renvoie 1 seulement si le lancement échoue ; le code de sortie du programme est ignoré.
- Mode shell sans quotage (les redirections de `LGed` en dépendent) ; mode exec sans shell.
- Programmes spéciaux `debug` (boîte) et `debug2` (console).
- `Internal_Test` existant sans assertion : la classe n'est aujourd'hui pas testée.

## Dépendances principales

- Utilise : `Utils.Log` (→ `LLog` → `DB_Connection`), `Start.LocalSettings` (test).
- Utilisé par : `LGed` ; harnais `Start.Start_Test`.

## Risques

- Échecs de programmes non détectés (A01) ; effet de bord sur le tableau d'arguments (A02) ;
  quotage absent en mode shell (A03).
- `Internal_Test` lance des commandes réelles, dont un script configuré éventuellement vide.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`Run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `gbtest` prévus (LSCRIPT-T01 à T08), issus de la conversion de l'`Internal_Test` : modes shell
et exec, codes de retour, quotage, `RunA`, `debug2`, double exécution, journalisation.

## Rework

4 étapes sans changement de comportement (LSCRIPT-001 à 004) : documentation, retrait de
l'`Internal_Test` après conversion, suppression d'`Inherits Array`, séparation de l'affichage.
3 anomalies (LSCRIPT-A01 à A03).
