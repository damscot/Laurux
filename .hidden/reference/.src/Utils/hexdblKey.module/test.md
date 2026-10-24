# hexdblKey — Tests

> Source : `.src/Utils/hexdblKey.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| HEXDBLKEY-T01 | gbtest | Chiffrement | `"en"`, `"EN"`, `"encrypt"` × chaînes `""`, `"motdepasse"`, `"éàç"`, 300 caractères × clés `"Laurux"`, `"LauruX2012"`, `"a"` | chaînes hexadécimales de référence | `tests/encrypt/` | à faire |
| HEXDBLKEY-T02 | gbtest | Déchiffrement et aller-retour | sorties de T01 avec `"de"`/`"decrypt"` | chaînes d'origine | `tests/decrypt/` | à faire |
| HEXDBLKEY-T03 | gbtest | Cas d'erreur | hexadécimal impair, caractères non hexadécimaux, action `"xx"`, clé vide | `""` (valeur de référence) | `tests/erreurs/` | à faire |
| HEXDBLKEY-T04 | gbtest | Compatibilité `Laurux.conf` | mots de passe chiffrés extraits d'un `Laurux.conf` de test produit par le clone de référence | déchiffrement identique | `tests/compat_conf/` | à faire |

## Détail des tests

- Toutes les valeurs attendues sont produites par le clone **Laurux non modifié**. T04 garantit que
  les configurations existantes restent lisibles après rework.
- Couverture visée : 100 %.
