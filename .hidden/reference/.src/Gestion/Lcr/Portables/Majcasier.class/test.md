# Majcasier — Tests

> Source : `.src/Gestion/Lcr/Portables/Majcasier.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran rejouable (`Utils.Observers(Me)`). `HOME` temporaire contenant `Portable/inventaire.txt` et
`tmp/` ; base `Laurux01.sql` avec quelques articles et codes-barres (`Fiches_CdBarre`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJCASIER-T01 | replay | Mise à jour nominale | casier `A12`, fichier de 3 lignes `x;y;codebarre` connues, Importer, OK | dump `Fiches_Art.art_casier` ; pas d'éditeur | `tests/nominal/` | implémenté |
| MAJCASIER-T02 | replay | Rejets | lignes avec code inconnu et 3ᵉ champ vide | rapport `~/tmp/Casier.txt`, article précédent remis à jour (A01 figée), éditeur appelé | `tests/rejets/` | implémenté (fermeture par Close : Quitter supprime le rapport) |
| MAJCASIER-T03 | replay | Casier vide | Importer sans casier | bulle d'avertissement, base inchangée | `tests/casier_vide/` | implémenté (bulle non comparée ; aucune requête) |
| MAJCASIER-T04 | replay | Fichier absent | pas de `inventaire.txt` | `Message.Error`, base inchangée ; `~/tmp/ImpT.txt` vidé par `Portable.Import` | `tests/fichier_absent/` | implémenté |
| MAJCASIER-T05 | replay | Lignes courtes | lignes à 1 ou 2 champs | champ utilisé comme code-barres (caractérisation) | `tests/lignes_courtes/` | implémenté |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** : dump normalisé de `Fiches_Art`
  (colonne `art_casier`), contenu de `~/tmp/Casier.txt`.
- L'ouverture de l'éditeur externe (`Editeur.Prog_Editeur`) est neutralisée par le harnais ; on
  vérifie seulement qu'elle est demandée.
- Après PORTABLE-004 / MAJCASIER-004, un `gbtest` sur la fonction pure `MajCasiers` pourra
  compléter T01/T02.

### Implémentation (phase 2, vague 5)
- Scénarios `.hidden/Tests/Gestion/assets/majcasier_<nom>/` ; fichiers d'entrée partagés dans `majcasier_shared/`
  (`inventaire_connus.txt`, `inventaire_rejets.txt`, `inventaire_courtes.txt`, déposés en `~/Portable/inventaire.txt`
  par `"entrees"` ; `garde.txt` crée `~/tmp`). Fichiers comparés : `tmp/Casier.txt`, `tmp/ImpT.txt`, `@ouvrir.trace`.
- Pas de jeu dérivé : `Find_cbarre` accepte les codes-barres de 001/002 (`Fiches_CdBarre`) et le code article 003.
- Défaut REPLAYOBSERVER-A08 : 1,5 s d'écart avant `Button1` pour que la réponse à `Message.Question` trouve FMessage.
- Observé (T02, T05) : le rapport `Casier.txt` n'indique pas le code rejeté (ligne « `code & " " & Codeb` » avec `code`
  vide et `Codeb` jamais affecté : une ligne blanche) ; « Quitter » (`Button2`) supprime le rapport même après
  l'ouverture de l'éditeur. Candidat anomalie.
