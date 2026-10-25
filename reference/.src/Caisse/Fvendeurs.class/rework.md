# Fvendeurs — Rework

> Source : `.src/Caisse/Fvendeurs.class` · Message de commit (phase 4) : `reference/.src/Caisse/Fvendeurs.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 163 |
| Lignes de commentaire | 31 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 9 (`Cais_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 163 | 43 | 9 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FVENDEURS-001 — [documentation] En-tête en français : rôle, deux points d'entrée
  (`Menu206` modal, `Menu287` non modal), colonnes cachées de la liste, contrat `admin = -1` et
  `mdp` chiffré par `hexdblKey` · appelants : aucun · tests : T01-T06 · sources : [Fvendeurs.class:_New](../../../../.src/Caisse/Fvendeurs.class#L28-L42), [Fvendeurs.class:Form_Open](../../../../.src/Caisse/Fvendeurs.class#L44-L59)
- [ ] FVENDEURS-002 — [code mort] Supprimer les blocs `With Utils` inutiles et la branche `Else`
  vide de `Button3_Click` · appelants : aucun · tests : T01, T03, T04 · sources : [Fvendeurs.class:Maj_Zones](../../../../.src/Caisse/Fvendeurs.class#L70-L82), [Fvendeurs.class:Button1_Click](../../../../.src/Caisse/Fvendeurs.class#L172-L206), [Fvendeurs.class:217](../../../../.src/Caisse/Fvendeurs.class#L217)
- [ ] FVENDEURS-003 — [séparation traitement/GUI] Extraire `EnregistreVendeur(sCode, sNom,
  sMdpClair, bAdmin)`, `SupprimeVendeur(sCode)` et `ControleMotDePasse(s1, s2) As String`, sans
  accès aux contrôles · appelants : aucun · tests : T01-T04 · sources : [Fvendeurs.class:Button1_Click](../../../../.src/Caisse/Fvendeurs.class#L172-L206), [Fvendeurs.class:Button3_Click](../../../../.src/Caisse/Fvendeurs.class#L208-L220)
- [ ] FVENDEURS-004 — [commonalisation] Chiffrement/déchiffrement et liste des vendeurs via le
  helper `LVendeur` (partagé avec `Ouverture`, `Svendeur`, `Cmenu`, `ConVendeurs`) · appelants :
  aucun · tests : T01, T03, OUVERTURE-T03 · sources : [Fvendeurs.class:Maj_Zones](../../../../.src/Caisse/Fvendeurs.class#L70-L82), [Fvendeurs.class:Button1_Click](../../../../.src/Caisse/Fvendeurs.class#L172-L206), [Ouverture.class:Caissiere_Click](../../../../.src/Caisse/Ouverture.class#L125-L147)
- [ ] FVENDEURS-005 — [commonalisation] Gabarit d'écran de table partagé avec `Fcaisses`
  (FCAISSES-007) · appelants : aucun · tests : T01-T06 · sources : [Fvendeurs.class:Refresh](../../../../.src/Caisse/Fvendeurs.class#L61-L68), [Fvendeurs.class:Btn_Click](../../../../.src/Caisse/Fvendeurs.class#L149-L164), [Fvendeurs.class:Vendeur_KeyPress](../../../../.src/Caisse/Fvendeurs.class#L225-L246)
- [ ] FVENDEURS-006 — [réduction de portée] `Refresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`,
  `Button3_Click` → `Private` (aucun appelant externe ; `Button1`/`Button3` dans le groupe `Btn`) ;
  `Vendeur_Click` reste `Public` (rejeu) · appelants : aucun · tests : T01-T06 · sources : [Fvendeurs.class:Refresh](../../../../.src/Caisse/Fvendeurs.class#L61-L68), [Fvendeurs.class:Maj_Zones](../../../../.src/Caisse/Fvendeurs.class#L70-L82), [Fvendeurs.class:Cleanchamps](../../../../.src/Caisse/Fvendeurs.class#L84-L92), [Fvendeurs.class:Button1_Click](../../../../.src/Caisse/Fvendeurs.class#L172-L206), [Fvendeurs.class:Button3_Click](../../../../.src/Caisse/Fvendeurs.class#L208-L220)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FVENDEURS-A01 — [anomalie] Suppression : test sur `Code.Text` mais `DELETE` sur
  `Vendeur.Current[0]` (ligne sélectionnée), par concaténation ; sans sélection, erreur non
  interceptée (pas de `Catch`) ; aucun contrôle d'usage (vendeur connecté sur une caisse, dernier
  administrateur) · tests : T04 · sources : [Fvendeurs.class:213](../../../../.src/Caisse/Fvendeurs.class#L213)
- [ ] FVENDEURS-A02 — [anomalie] `Btn_KeyPress` : toute touche (Tab, flèches) sur « Enregistrer »
  enregistre · tests : T05 · sources : [Fvendeurs.class:Btn_KeyPress](../../../../.src/Caisse/Fvendeurs.class#L138-L147)
- [ ] FVENDEURS-A03 — [anomalie] Échap/F2 dans la liste la masque jusqu'à la réouverture de
  l'écran · tests : T05 · sources : [Fvendeurs.class:239](../../../../.src/Caisse/Fvendeurs.class#L239)
- [ ] FVENDEURS-A04 — [anomalie, à confirmer] Le mot de passe d'un vendeur (administrateurs
  compris) est relu et déchiffré à l'écran par toute personne qui ouvre la table ; le code vendeur
  n'est contrôlé ni en longueur (`char(2)`) ni en caractères, alors que `Svendeur`/`ConVendeurs`
  ne lisent qu'un caractère (voir OUVERTURE-A02) · tests : T03 · sources : [Fvendeurs.class:54](../../../../.src/Caisse/Fvendeurs.class#L54), [Fvendeurs.class:76](../../../../.src/Caisse/Fvendeurs.class#L76), [Fvendeurs.class:180](../../../../.src/Caisse/Fvendeurs.class#L180)
