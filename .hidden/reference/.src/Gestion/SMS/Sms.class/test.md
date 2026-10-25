# Sms — Tests

> Source : `.src/Gestion/SMS/Sms.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI de saisie d'une table code/texte : scénarios `replay` capturés dans le clone **Laurux
non modifié**, comparés sur le dump de `Fiches_Sms`. Données : `Laurux01.sql` + jeu dérivé
`sms_textes` (3 textes, dont un multi-ligne), `Laurux.conf` avec `/Soc01/Sms = 1` pour rendre
le menu visible. Aucun envoi de SMS dans cet écran.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SMS-T01 | replay | Ouverture et liste | Fmenu › Textes SMS | 3 lignes, première ligne de l'intitulé seulement | `tests/liste_textes/` | à faire |
| SMS-T02 | replay | Création et modification | code `04` + texte, Enregistrer ; clic sur `01`, modification, Enregistrer | dump `Fiches_Sms` de référence (texte passé par `Utils.ReplaceLb`) | `tests/creation_modif/` | à faire |
| SMS-T03 | replay | Code existant saisi sans sélection | saisie `02` au clavier sans clic, Enregistrer | UPDATE exécuté puis erreur `Current.Key` (figé, A02) | `tests/maj_sans_selection/` | à faire |
| SMS-T04 | replay | Suppression | clic sur `03`, Supprimer, Oui ; puis saisie d'un code sans sélection, Supprimer | ligne `03` supprimée ; erreur ou suppression de la ligne sélectionnée (figé, A01) | `tests/suppression/` | à faire |
| SMS-T05 | replay | Table absente | base sans `Fiches_Sms` | message « La table des textes SMS n'existe pas... » et fermeture | `tests/table_absente/` | à faire |
| SMS-T06 | replay | Touche sur Enregistrer | focus sur `Button2`, touche Tab | enregistrement déclenché (figé, A03) | `tests/btn_keypress/` | à faire |

## Détail des tests

- **Valeurs attendues** : dump normalisé de `Fiches_Sms` après chaque scénario, capturé dans le
  clone Laurux non modifié.
- **Rejeu** : `colcol_Click` existe (pas de `replay_missing`) ; `Utils.Observers(Me)` appelé une
  seule fois dans `_New`, mais `Refresh` rappelle `Form_Open` (pas d'observateur ajouté).
- Jeu de données commun possible avec COMMAIL-T01-T05 (même structure de table).
