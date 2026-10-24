# Sha1Calc — Dépendances

> Source : `.src/Utils/Sha1Calc.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Sha1Calc.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `CalcSha1T` |
| `.src/Caisse/Moulinage.class` | `CalcSha1`, `CalcSha1T` |
| `.src/Communs/LauruxMaj.module` | `CalcSha1_all` |
| `.src/Communs/Prgm.class` | `CalcSha1_all` |
| `.src/Compta/Clotures/FCloture.class` | `CalcSha1_Verify` |
| `.src/Compta/Clotures/FClotureAn.class` | `CalcSha1_all` |
| `.src/Compta/Impressions/Anomalies.class` | `CalcSha1`, `CalcSha1_Verify` |
| `.src/Compta/Impressions/BordereauxC.class` | `CalcSha1` |
| `.src/Compta/Lettrages/Lettragemontant.class` | `CalcSha1` |
| `.src/Compta/Lettrages/Lettragesoldes.class` | `CalcSha1` |
| `.src/Compta/Saisecrit.class` | `CalcSha1` |
| `.src/Compta/Trecarts.class` | `CalcSha1` |
| `.src/Compta/Tresor.class` | `CalcSha1` |
| `.src/Compta/Utils/EcrAuto.class` | `CalcSha1` |
| `.src/Compta/Utils/Ecritures.class` | `CalcSha1` |
| `.src/Compta/Utils/RazClos.class` | `CalcSha1` |
| `.src/Compta/Utils/impfec.class` | `CalcSha1` |
| `.src/Gestion/Stock/ValidBR.class` | `CalcSha1` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `ProgBar` | `<type>`, `Avancement`, `Finalize` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_HisEntTickets`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés par grep** :
  - `CalcSha1` : `Caisse/Moulinage.class` (13 appels, l. 937 à 2649), `Compta/Tresor.class:376,1695,1987,2180`,
    `Compta/Saisecrit.class:2087,2642`, `Compta/Utils/EcrAuto.class:337`, `Compta/Utils/RazClos.class:12`,
    `Compta/Utils/impfec.class:240,246,335`, `Compta/Utils/Ecritures.class:301` (sans mise à jour),
    `Compta/Impressions/Anomalies.class:54` (sans mise à jour), `Compta/Impressions/BordereauxC.class:374`,
    `Compta/Trecarts.class:274`, `Compta/Lettrages/Lettragemontant.class:126`,
    `Compta/Lettrages/Lettragesoldes.class:98`, `Gestion/Stock/ValidBR.class:1097`.
  - `CalcSha1_all` : `Communs/LauruxMaj.module:4843,6105`, `Communs/Prgm.class:90,92` (programme
    `CalcSha1` lancé en ligne de commande), `Compta/Clotures/FClotureAn.class:631`.
  - `CalcSha1_Verify` : `Compta/Impressions/Anomalies.class:53`, `Compta/Clotures/FCloture.class:126`
    (écrit `CalcSha1_verify`, Gambas étant insensible à la casse).
  - `CalcSha1T` : `Caisse/Caisse.class:6153`, `Caisse/Moulinage.class:1046` (vérification).
- **Tables** : l'heuristique ne voit que `Fiches_HisEntTickets` (en dur). Les tables réelles sont
  passées en paramètre : `Fiches_Mvt`, `Fiches_Mvt1-5` et `Fiches_MvtM`, `Fiches_MvtM1-5` (déduites),
  `Fiches_EntTicketz`, ainsi que des tables temporaires (`Tmvt` de `ValidBR`, `Tab2` de `Trecarts`).
- **Contrat de données** : la liste des colonnes hachées et l'ordre de concaténation sont un format
  persistant (clés déjà stockées en production) ; aucun rework ne doit les modifier.
- **Ordre de rework** : après `DB_Connection` ; les tests SHA1CALC doivent exister avant tout rework
  des appelants comptables (`Moulinage`, `Tresor`, `Saisecrit`), car une clé différente est
  silencieuse jusqu'au contrôle d'anomalies.
