# Générateur des jeux validinvt_shared/*.sql et des scénarios validinvt_* (VALIDINVT-T01 à T10, T12, T13).
# Usage : python3 gen_validinvt.py (conserve la cadence des meta.json existants), puis runner harness apply et replay --expected.
import json, os, sys
A = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # .hidden/Tests/Gestion/assets
os.makedirs(A + '/validinvt_shared', exist_ok=True)
CREATE = """CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
"""
def jeu(nom, entete, lignes, extra=""):
    s = entete + "UPDATE Fiches_Art SET art_qte = 10 WHERE art_code IN ('001', '002');\nUPDATE Fiches_Art SET art_qte = 0 WHERE art_code = '003';\nUPDATE Fiches_Art SET art_stocke = 1 WHERE art_code IN ('001', '002', '003');\n"
    s += "DROP TABLE IF EXISTS Fiches_InvT;\n" + CREATE
    s += "INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES\n"
    s += ",\n".join(lignes) + ";\n" + extra
    open(A + '/validinvt_shared/' + nom + '.sql', 'w').write(s)
jeu('invt_compte', "-- Jeu VALIDINVT : inventaire tournant du 01/06/2018 entièrement compté (GeninvT + SaisieinvT) : 001 stock 10\n-- compté 12 (écart +2), 002 stock 10 compté 7 (écart -3), 003 stock 0 compté 0 (écart nul).\n",
 ["('1', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', '')",
  "('2', '002', 10.00, 7.00, '2018-06-01', 1, NULL, 'Produit 7.00', '')",
  "('3', '003', 0.00, 0.00, '2018-06-01', 1, NULL, 'produit 20.00', '')"])
jeu('invt_partiel', "-- Jeu VALIDINVT : inventaire tournant du 01/06/2018 partiellement compté : 001 stock 10 compté 12 (+2),\n-- 002 stock 10 non compté (inv_comptee 0, quantité comptée 0), 003 stock 0 compté 5 (+5).\n",
 ["('1', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', '')",
  "('2', '002', 10.00, 0.00, '2018-06-01', 0, NULL, 'Produit 7.00', '')",
  "('3', '003', 0.00, 5.00, '2018-06-01', 1, NULL, 'produit 20.00', '')"])

M = "Click=True@Menu100#Fmenu#Menu66#Menu77#Menu94#Menu100#"
def ev(t, h, a):
    return "06/15/2018 10:00:%06.3f;Info;GUI;laurux;test;test;1;%s;%s" % (t, h, a)
OUI = ("FMessage.FMessage_KeyPress", "Keypress=16777220@FMessage#FMessage#")
def scen(nom, idt, objet, desc, dataset, evts, extra=None):
    d = A + '/validinvt_' + nom
    os.makedirs(d, exist_ok=True)
    t = 4.0
    out = [ev(t, "Fmenu.Menu100_Click", M)]
    for h, a in evts:
        t += 1.0
        out.append(ev(t, h, a))
    open(d + '/scenario.log', 'w').write("\n".join(out) + "\n")
    meta = {"id": idt, "objet": objet, "classe": "ValidinvT", "description": desc, "dataset": "validinvt_shared/" + dataset,
            "date": "2018-06-15 10:00:00", "args": [], "societe": "01", "timeout": 20,
            "cadence": {"frappe": 50, "focus": 100, "traitement": 1000, "fenetre": 1000}}
    if extra: meta.update(extra)
    p = d + '/meta.json'
    if os.path.exists(p):
        old = json.load(open(p))
        if "cadence" in old: meta["cadence"] = old["cadence"]
    json.dump(meta, open(p, 'w'), indent=1, ensure_ascii=False)
    open(p, 'a').write("\n")
VAL = ("ValidinvT.Button2_Click", "Click=True@Button2#ValidinvT#Button2#")
R2 = ("ValidinvT.RadioButton2_Click", "Click=True@RadioButton2#ValidinvT#Panel1#RadioButton2#")
scen('complet', 'VALIDINVT-T01', 'Inventaire tournant tout compté',
     "Jeu invt_compte (écarts +2, -3, 0) : Validation, « Oui », « Traitement terminé » (Entrée). Attendu : art_qte = comptage (12, 7, 0) ; Fiches_Mvtexp qtep 2 (001) et qtem 3 (002), rien pour 003 ; Fiches_HisInvT inv_num 1 (3 lignes) ; Fiches_InvT supprimée.",
     'invt_compte', [VAL, OUI, OUI])
scen('zero', 'VALIDINVT-T02', 'Partiel, non comptés mis à zéro',
     "Jeu invt_partiel, RadioButton1 (par défaut) : Validation, « Oui », fin. Attendu : 002 non compté art_qte = 0 et sortie qtem = 10 ; 001 = 12, 003 = 5 avec entrées qtep ; historique des seules lignes comptées.",
     'invt_partiel', [VAL, OUI, OUI])
scen('conserve', 'VALIDINVT-T03', 'Partiel, non comptés conservés (A02)',
     "Jeu invt_partiel, RadioButton2 « Laisser la valeur d'origine » : Validation, « Oui », fin. Attendu : 002 art_qte = 10 inchangé mais sortie qtem = 10 écrite dans Fiches_Mvtexp (VALIDINVT-A02 figée).",
     'invt_partiel', [R2, VAL, OUI, OUI])
LC = ["('1', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', '')",
      "('2', '002', 10.00, 7.00, '2018-06-01', 1, NULL, 'Produit 7.00', '')",
      "('3', '003', 0.00, 0.00, '2018-06-01', 1, NULL, 'produit 20.00', '')"]
jeu('invt_histo', "-- Jeu VALIDINVT-T04 : invt_compte + un premier inventaire tournant historisé (inv_num 1, 01/03/2018).\n", LC,
    "INSERT INTO Fiches_HisInvT (inv_num, inv_code, inv_qtestock, inv_qtecomptee, inv_date) VALUES\n(1, '001', 8.00, 9.00, '2018-03-01'),\n(1, '002', 4.00, 4.00, '2018-03-01');\n")
jeu('invt_deja', "-- Jeu VALIDINVT-T07 : invt_compte dont la 1re ligne porte inv_valid = 1 (validation interrompue).\n",
    [LC[0].replace(", 1, NULL,", ", 1, 1,")] + LC[1:])
jeu('invt_sans_histo', "-- Jeu VALIDINVT-T08 : invt_compte sans la table Fiches_HisInvT.\n", LC, "DROP TABLE Fiches_HisInvT;\n")
open(A + '/validinvt_shared/invt_absent.sql', 'w').write("-- Jeu VALIDINVT-T06 : ni Fiches_InvT (aucun inventaire tournant généré) ni Fiches_HisInvT.\nDROP TABLE IF EXISTS Fiches_InvT;\nDROP TABLE IF EXISTS Fiches_HisInvT;\n")
NON = [("FMessage.FMessage_KeyPress", "Keypress=16777217@FMessage#FMessage#"), ("FMessage.FMessage_KeyPress", "Keypress= @FMessage#FMessage#")]
scen('num', 'VALIDINVT-T04', 'Deuxième inventaire tournant (inv_num 2)',
     "Jeu invt_histo (Fiches_HisInvT contient l'inventaire n° 1) : Validation, « Oui », fin. Attendu : historique inv_num = 2 pour les 3 lignes, inventaire n° 1 conservé.",
     'invt_histo', [VAL, OUI, OUI])
scen('non', 'VALIDINVT-T05', 'Refus de la validation',
     "Jeu invt_compte : Validation, « Non » (Tab puis Espace). Attendu : dump identique au jeu (art_qte, Fiches_Mvtexp, Fiches_HisInvT inchangés, Fiches_InvT conservée).",
     'invt_compte', [VAL] + NON)
scen('absent', 'VALIDINVT-T06', 'Sans inventaire tournant',
     "Jeu invt_absent (ni Fiches_InvT ni Fiches_HisInvT) : Validation. Attendu : message « Il n'existe aucun inventaire » (Entrée), fermeture de l'écran ; Fiches_HisInvT créée vide.",
     'invt_absent', [VAL, OUI])
scen('deja', 'VALIDINVT-T07', 'Inventaire déjà validé',
     "Jeu invt_deja (inv_valid = 1 sur la 1re ligne) : Validation. Attendu : message « L'inventaire à déjà été validé » (Entrée) ; aucune mise à jour.",
     'invt_deja', [VAL, OUI])
scen('creation_histo', 'VALIDINVT-T08', 'Fiches_HisInvT absente : créée puis alimentée',
     "Jeu invt_sans_histo : Validation, « Oui », fin. Attendu : Fiches_HisInvT créée (CREATE TABLE if not exists) et alimentée (inv_num 1, 3 lignes) ; mises à jour comme T01.",
     'invt_sans_histo', [VAL, OUI, OUI])
jeu('invt_depots', "-- Jeu VALIDINVT-T12 : invt_compte + stock par dépôt de 001 et 002 (dépôts 01 et 02).\n", LC,
    "INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES\n('01', '001', 6.000),\n('02', '001', 4.000),\n('01', '002', 10.000);\n")
jeu('invt_mouvements', "-- Jeu VALIDINVT-T10 : invt_compte + vente (BL B000901 du 10/06/2018, 2 x 001) après la génération du\n-- 01/06/2018 et avant la validation : art_qte de 001 = 8 (10 - 2), inv_qtestock reste 10.\n", LC,
    "UPDATE Fiches_Art SET art_qte = 8 WHERE art_code = '001';\n"
    "INSERT INTO Fiches_Bl (numbl, type, datebl, cdclibl, nmclibl) VALUES ('B000901', 'B', '2018-06-10 09:00:00', '411000', 'VENTE APRES GENERATION');\n"
    "INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, dte_ligbl, typel_ligbl) VALUES ('B000901', '1', '001', 'Produit 2.10', '2', '2018-06-10', 'A');\n")
CALC = [("Fmenu.Menu168_Click", "Click=True@Menu168#Fmenu#Menu66#Menu144#Menu168#"),
        ("Calcstock.Cbx3_Click", "Click=True@Cbx3#Calcstock#Panel1#Cbx3#"),
        ("Calcstock.Button2_Click", "Click=True@Button2#Calcstock#Button2#"), OUI]
scen('recalcul', 'VALIDINVT-T09', 'Validation partielle « conservés » puis recalcul du stock',
     "Jeu invt_partiel : RadioButton2, Validation, « Oui », fin ; puis Gestion › Outils › Recalcul des stocks, « Pour tous les produits », Lancer, « Traitement terminé ». Attendu : art_qte recalculé depuis Fiches_HisInvT + mouvements ; l'écart fictif (qtem 10) écrit pour 002 non compté est repris par le recalcul (A02 figée).",
     'invt_partiel', [R2, VAL, OUI, OUI] + CALC)
scen('mouvements', 'VALIDINVT-T10', 'Vente entre génération et validation (A03)',
     "Jeu invt_mouvements (vente de 2 x 001 le 10/06, après la génération du 01/06) : Validation, « Oui », fin, puis recalcul de tous les stocks. Attendu : art_qte de 001 = 12 juste après la validation (vente ignorée), puis valeur recalculée figée (A03).",
     'invt_mouvements', [VAL, OUI, OUI] + CALC)
scen('depots', 'VALIDINVT-T12', 'Stock par dépôt inchangé (A07)',
     "Jeu invt_depots : Validation, « Oui », fin. Attendu : art_qte = comptage, Fiches_StkDepots inchangé (6 + 4 pour 001 alors que le comptage est 12 ; VALIDINVT-A07 figée).",
     'invt_depots', [VAL, OUI, OUI])
scen('sauvegarde', 'VALIDINVT-T13', 'Sauvegarde mysqldump de la base Laurux en dur (A01)',
     "Jeu invt_compte : Validation, « Oui », fin. Attendu : mysqldump appelé (trace, mot de passe masqué) sur la base « Laurux » écrite en dur et non sur la base de test Laurux01 : ~/Sauve/LauruxInvT.sql20180615 vide (base inconnue) (VALIDINVT-A01 figée) ; mises à jour comme T01.",
     'invt_compte', [VAL, OUI, OUI],
     {"outils": {"mysqldump": {"hidden_argv": ["-p*"]}}, "fichiers": ["@outils.trace", "Sauve/LauruxInvT.sql20180615"]})
