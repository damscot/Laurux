# Attrib — Tests

> Source : `.src/Caisse/Attrib.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI du mode caisse : scénarios `replay` capturés dans le clone **Laurux non modifié** lancé en
`./Laurux -p`, caisse connectée (`Start.$Tcai` = `01`), menu de caisse › paramétrage des touches
(`Cmenu.ControleCai`). Base `Laurux01.sql` + jeu dérivé `touches_base` : `Fiches_Touches` pour deux
caisses (`01`, `02`) avec des touches de même nom, une touche sous-famille `A1` avec `A1B1`/`A1B2`,
une touche `A12` avec `A12B3`, des articles existants. Comparaison : dump normalisé de
`Fiches_Touches` (toutes caisses) ; lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ATTRIB-T01 | replay | Ouverture et affichage | ouverture de l'écran, clic sur `A1`, `A12`, une touche vide | textes et codes affichés de référence ; seules les touches de la caisse `01` ; auto-instance `Caisse` créée (A06, à constater dans le log) | `tests/ouverture/` | à faire |
| ATTRIB-T02 | replay | Enregistrement | touche vide : texte + code article, Enregistrer ; touche existante : nouveau code ; code saisi inexistant | INSERT / UPDATE dans `Fiches_Touches` (caisse `01` seulement) ; avertissement « Cet article n'existe pas » | `tests/enregistrement/` | à faire |
| ATTRIB-T03 | replay | Suppression | clic sur une touche, Supprimer ; autre touche, Suppr dans `Bouton` | lignes supprimées sans confirmation (A07) ; la même touche de la caisse `02` intacte | `tests/suppression/` | à faire |
| ATTRIB-T04 | replay | Recherche d'article | bouton de recherche, sélection dans `TriArticles` | code recopié dans `Cart`, `Label3` vide (A04 figée) | `tests/recherche_article/` | à faire |
| ATTRIB-T05 | replay | Sous-familles | clic `A1`, case « Sous-famille », Enregistrer, bouton « Sous-familles », clic `A1B1`, modification, Enregistrer, retour « Familles » | `Fiches_Touches` de référence ; textes affichés après `Init()` en mode sous-famille (A05 figée) | `tests/sous_familles/` | à faire |
| ATTRIB-T06 | replay | Couleur et image | double-clic sur une touche de famille puis de sous-famille, choix d'une couleur et d'une image dans `FSetFormat` | `coul` mis à jour (caisse `01`) ; pas d'INSERT pour une touche absente (A02) ; `fond` mis à jour **dans les deux caisses** (A03) | `tests/couleur_image/` | à faire |
| ATTRIB-T07 | replay | Saisie manuelle du nom de touche | taper `ZZ` dans `Bouton`, code article, Enregistrer | INSERT de la touche `ZZ` puis erreur sur `Me.Controls["ZZ"]` (A07 figée) | `tests/touche_inconnue/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; les anomalies A01 à A07 sont figées.
  A01 n'est reproductible qu'en provoquant un échec d'`INSERT` (ex. libellé > 30 caractères en mode
  strict, ou base SQLite verrouillée) : scénario à construire en phase 2, sinon cas non testable.
- **Rejeu** : `Form_Open` appelle `Utils.Observers(Me)` ; les touches `Clav3` sont créées
  dynamiquement après cet appel : vérifier en phase 2 qu'elles sont journalisées (sinon T05/T06 ne
  peuvent pas être rejoués et passent en manuel). Pas de grille dans l'écran (`replay_missing` vide).
- **Double-clic** : la levée de `DblClick` par `ImageButton` est à confirmer ; `FSetFormat` est modal
  (sélecteur de fichier pour l'image) : piloter le dialogue par le rejeu ou par xdotool.
- **Effet aval** : le clavier de vente de `Caisse` relit `Fiches_Touches` ; un scénario de vente
  utilisant une touche modifiée (lot Caisse) complète T02/T05.
