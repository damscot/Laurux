# Remisecli — Tests

> Source : `.src/Gestion/Tables/Remisecli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de table : tests `replay` avec diff de `Fiches_RemCliFam`. Valeurs attendues produites
dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| REMISECLI-T01 | replay | Création | client C1 (F2, liste `Colcli`), famille F1 (liste `Colfam`), remise `5` ; Entrée sur le bouton | ligne `Fiches_RemCliFam` ; grille rafraîchie | `tests/creation/` | à faire |
| REMISECLI-T02 | replay | Modification et doublon | sélection d'une ligne, remise `8` ; puis création d'un couple existant | `remise` mise à jour ; pas de doublon (mise à jour) | `tests/modification/` | à faire |
| REMISECLI-T03 | replay | Saisie invalide | client et famille inexistants, remise `abc` | bulles ; ligne enregistrée quand même (REMISECLI-A03 figée) | `tests/saisie_invalide/` | à faire |
| REMISECLI-T04 | replay | Suppression | suppression d'une ligne au milieu, puis de la dernière ligne | lignes supprimées ; comportement de `MoveTo` sur la dernière (REMISECLI-A04 figée) | `tests/suppression/` | à faire |
| REMISECLI-T05 | replay | Filtre et tri par client | frappe `41` dans l'en-tête Client, retour arrière, double-clic | contenu et ordre de la grille | `tests/filtre_client/` | à faire |
| REMISECLI-T06 | replay | En-tête Famille | clic, frappe et double-clic dans l'en-tête Famille | aucun effet (REMISECLI-A01 figée) | `tests/entete_famille/` | à faire |
| REMISECLI-T07 | replay | Caractères spéciaux dans le filtre | frappe `"` puis `'` dans l'en-tête Client | erreur SQL ou grille vide (REMISECLI-A02 figée) | `tests/filtre_guillemets/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (clients, familles) + 5 lignes `Fiches_RemCliFam` (2 clients
  `41…`, plusieurs familles).
- **Comparaison** : dump normalisé de `Fiches_RemCliFam` ; contenu et ordre de la grille relevés
  par le replay (T05-T07).
- **Phase 2** : la grille est virtuelle (`Tabcli_Data` lit `Utils.rs1`) ; le replay doit relever
  le texte des cellules après rafraîchissement.
- **Non testable** : bulles (`Balloon`) autrement que par le journal, son.
