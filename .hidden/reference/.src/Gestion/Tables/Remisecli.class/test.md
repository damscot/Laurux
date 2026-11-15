# Remisecli — Tests

> Source : `.src/Gestion/Tables/Remisecli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de table : tests `replay` avec diff de `Fiches_RemCliFam`. Valeurs attendues produites
dans le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| REMISECLI-T01 | replay | Création | client C1 (F2, liste `Colcli`), famille F1 (liste `Colfam`), remise `5` ; Entrée sur le bouton | ligne `Fiches_RemCliFam` ; grille rafraîchie | `tests/creation/` | implémenté |
| REMISECLI-T02 | replay | Modification et doublon | sélection d'une ligne, remise `8` ; puis création d'un couple existant | `remise` mise à jour ; pas de doublon (mise à jour) | `tests/modification/` | implémenté (couple existant ressaisi : UPDATE ; la sélection d'une ligne de Tabcli reste à faire : grille sans Tabcli_Click, erreur 125 du harnais) |
| REMISECLI-T03 | replay | Saisie invalide | client et famille inexistants, remise `abc` | bulles ; ligne enregistrée quand même (REMISECLI-A03 figée) | `tests/saisie_invalide/` | implémenté |
| REMISECLI-T04 | replay | Suppression | suppression d'une ligne au milieu, puis de la dernière ligne | lignes supprimées ; comportement de `MoveTo` sur la dernière (REMISECLI-A04 figée) | `tests/suppression/` | à faire : sélection d'une ligne de Tabcli non rejouable (seulement Tabcli_Select, pas de Tabcli_Click : erreur fatale 125 du harnais) ; pas d'équivalent gb.test : `Button2_Click` ouvre `Message.Delete` (bloquant en gb.test) avant la suppression et le `MoveTo` (A04) |
| REMISECLI-T05 | replay | Filtre et tri par client | frappe `41` dans l'en-tête Client, retour arrière, double-clic | contenu et ordre de la grille | `tests/filtre_client/` | implémenté (filtre ; double-clic non rejouable) |
| REMISECLI-T06 | replay | En-tête Famille | clic, frappe et double-clic dans l'en-tête Famille | aucun effet (REMISECLI-A01 figée) | `tests/entete_famille/` | implémenté (focus et frappe ; clic/double-clic non rejouables) |
| REMISECLI-T07 | replay | Caractères spéciaux dans le filtre | frappe `"` puis `'` dans l'en-tête Client | erreur SQL ou grille vide (REMISECLI-A02 figée) | `tests/filtre_guillemets/` | implémenté (guillemet double : Query failed, code 125 figé ; apostrophe non testée car l’erreur fatale arrête le rejeu) |

## Détail des tests

- **Données** : `Laurux01.sql` (clients, familles) + 5 lignes `Fiches_RemCliFam` (2 clients
  `41…`, plusieurs familles).
- **Comparaison** : dump normalisé de `Fiches_RemCliFam` ; contenu et ordre de la grille relevés
  par le replay (T05-T07).
- **Phase 2** : la grille est virtuelle (`Tabcli_Data` lit `Utils.rs1`) ; le replay doit relever
  le texte des cellules après rafraîchissement.
- **Non testable** : bulles (`Balloon`) autrement que par le journal, son.

- **Assets (phase 2)** : jeu `.hidden/Tests/Gestion/assets/remisecli_shared/remisecli_cinq.sql` (5 lignes, clients 411001
  et 411003) ; scénarios `remisecli_creation` (T01), `remisecli_modification` (T02), `remisecli_saisie_invalide` (T03),
  `remisecli_filtre_client` (T05), `remisecli_entete_famille` (T06), `remisecli_filtre_guillemets` (T07). La touche F2
  est remplacée par le bouton ToggleButton1 ; Cdf (textfamille) est rempli par la liste Colfam.
