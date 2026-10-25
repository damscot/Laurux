# MvtProdcomp — Tests

> Source : `.src/Gestion/Stock/MvtProdcomp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Art` (`art_qte` du produit et des composants) et
`Fiches_Mvtexpdc`. Écran instrumenté (`Utils.Observers`). Chaque « Enregistrer » écrit en base :
le dump est comparé à la fin du scénario. Valeurs attendues produites dans le clone **Laurux non
modifié** (anomalies A01-A04 figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MVTPRODCOMP-T01 | replay | Entrée d'un produit composé | « Entrée », produit P (2 composants, qtés 2 et 0,5), qté 3 ; Enregistrer | `art_qte` P +3, C1 −6, C2 −1,5 ; 3 lignes `Mvtexpdc` (`P`, `C`, `C`) de même `mind` | `tests/prdc_entree/` | à faire |
| MVTPRODCOMP-T02 | replay | Sortie (démontage) | « Sortie », P qté 1 | P −1, composants +qté ; lignes `qtem`/`qtep` inversées | `tests/prdc_sortie/` | à faire |
| MVTPRODCOMP-T03 | replay | Ressaisie : cumul | P qté 2, puis P qté 1 → « 1 » | état actuel figé : stock P +3, une seule ligne `P`, composants non mis à jour pour la 2e saisie (A01) | `tests/prdc_cumul/` | à faire |
| MVTPRODCOMP-T04 | replay | Ressaisie : remplacement | P qté 2, puis P qté 5 → « 2 » | état actuel figé (A02) | `tests/prdc_remplace/` | à faire |
| MVTPRODCOMP-T05 | replay | Article non stocké / inexistant / code-barre / article simple | saisie clavier dans `Cart` de chaque cas ; Enregistrer pour l'article simple | messages ; pour l'article simple : stock et ligne `P` écrits, question « déjà saisi » (A03 figée) | `tests/prdc_article/` | à faire |
| MVTPRODCOMP-T06 | replay | Sélection par liste | F2 dans `Cart`, Entrée sur un produit ; puis bouton liste et clic (`Colart_Click`) | produit repris, stock affiché | `tests/prdc_liste/` | à faire |
| MVTPRODCOMP-T07 | replay | Bascule Entrée/Sortie | 1 saisie puis clic « Sortie » | grille vidée, base inchangée par la bascule | `tests/prdc_bascule/` | à faire |
| MVTPRODCOMP-T08 | replay | Numérotation `mind` | `Fiches_Mvtexpdc` contenant déjà `mind` 41 ; 2 produits saisis | `mind` 42 et 43 | `tests/prdc_mind/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `prodcomp.sql` : produit composé P (`art_prdcomp = 1`)
  avec deux composants dans `Fiches_PrdComp` (quantités entière et décimale), un article simple
  stocké, un article non stocké, un code-barre ; mouvements `Fiches_Mvtexpdc` préexistants.
- **Date** : `datej` est pré-rempli avec la date du jour : la saisir explicitement (ou
  `faketime`).
- **Comparaison** : dump normalisé (`id` auto-incrément masqué ; `mind` conservé) ;
  `qtep`/`qtem` comparés en texte (format `Utils.Cdec`).
- **Grille** : pas de clic dans `Colrcp` (`replay_missing`).
- **Non testable** : concurrence entre deux postes (A04/A05) ; à vérifier manuellement si
  l'utilisateur le souhaite.
- **gbtest** : après MVTPRODCOMP-004, `EnregistreLot` peut être testé sans formulaire.
