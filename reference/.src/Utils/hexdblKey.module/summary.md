# hexdblKey — Synthèse

> Source : `.src/Utils/hexdblKey.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Obfuscation réversible (XOR avec clé + hexadécimal) des mots de passe stockés dans `Laurux.conf` et
de quelques codes ; module exporté, repris du gestionnaire de bases de Gambas (GPL v3).

## Points clés

- Une fonction Public `Crypt("en"|"de", texte, clé)`, trois helpers privés.
- Clés en dur : `"Laurux"` (29 appels), `"LauruX2012"` (6) ; 38 appels dans 16 fichiers.
- Erreurs absorbées par un `Catch` vide (retour `""`).

## Dépendances principales

- Aucune dépendance sortante ; appelé par la configuration (`LauruxConf`, `Prefs`), la caisse
  (`Caisse`, `Cmenu`, `Fvendeurs`, `Ouverture`), `Utils.glb`, la messagerie, la facturation FTP.

## Risques

- Compatibilité des `Laurux.conf` existants : tout changement d'algorithme est exclu du rework.
- Sécurité : obfuscation seulement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 24 |
| Fonctions | 4 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 4 (`Crypt`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (HEXDBLKEY-T01 à T04) : chiffrement, déchiffrement, erreurs, compatibilité avec un
`Laurux.conf` existant.

## Rework

3 étapes (HEXDBLKEY-001 à 003) : documentation, simplification de la normalisation, constantes de
clés. 1 anomalie de sécurité (HEXDBLKEY-A01) soumise à décision.
