# Générateur des jeux geninvt_shared/*.sql et des scénarios geninvt_* (GENINVT-T01 à T13).
# Usage : python3 gen_geninvt.py (conserve la cadence des meta.json existants), puis runner harness apply,
# runner retime (scénarios neufs), runner replay --expected.
import json, os
A = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # .hidden/Tests/Gestion/assets
S = A + '/geninvt_shared'

ART = """-- Articles stockés : 001 (fam 01, four 401001, casier 20, stock 10), 002 (fam 02, four 401002, casier 10, stock 7),
-- 003 (fam 03, four 401001, casier 30, stock 0) ; 004 copie de 003 non stockée (fam 03, casier 15, exclue).
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_casier = '20', art_four = '401001' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7, art_casier = '10', art_four = '401002' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_casier = '30', art_four = '401001' WHERE art_code = '003';
CREATE TEMPORARY TABLE tmp_geninvt AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_geninvt SET art_code = '004', art_design = 'Produit non stocke', art_stocke = 0, art_casier = '15', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_geninvt;
DROP TEMPORARY TABLE tmp_geninvt;
DROP TABLE IF EXISTS Fiches_InvT;
"""
CREATE = """CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
"""
def lignes(valid):
    v = 'NULL' if valid is None else str(valid)
    return ("INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES\n"
            "('1', '003', 0.00, 4.00, '2018-06-01', 1, %s, 'produit 20.00', '30'),\n"
            "('2', '001', 10.00, 12.00, '2018-06-01', 1, %s, 'Produit 2.10', '20'),\n"
            "('3', '002', 7.00, 0.00, '2018-06-01', 0, %s, 'Produit 7.00', '10');\n") % (v, v, v)
os.makedirs(S, exist_ok=True)
def jeu(nom, txt):
    open(S + '/' + nom + '.sql', 'w').write(txt)
jeu('art_stock', "-- Jeu GENINVT : aucune table Fiches_InvT (première génération).\n" + ART)
jeu('invt_vide', "-- Jeu GENINVT : Fiches_InvT présente et vide.\n" + ART + CREATE)
jeu('invt_genere', "-- Jeu GENINVT : inventaire tournant du 01/06/2018 en cours (non validé), 2 lignes comptées sur 3,\n-- lignes dans l'ordre 003, 001, 002 (lind 1 à 3).\n" + ART + CREATE + lignes(None))
jeu('invt_valide', "-- Jeu GENINVT : inventaire tournant marqué validé (inv_valid = 1, validation interrompue).\n" + ART + CREATE + lignes(1))

ENTREE, TAB, BS, SUPPR = "16777220", "16777217", "16777219", "16777223"
MENU = ("Fmenu.Menu95_Click", "Click=True@Menu95#Fmenu#Menu66#Menu77#Menu94#Menu95#")
OUI = ("FMessage.FMessage_KeyPress", "Keypress=%s@FMessage#FMessage#" % ENTREE)
NON = [(1.0, "FMessage.FMessage_KeyPress", "Keypress=%s@FMessage#FMessage#" % TAB), (0.1, "FMessage.FMessage_KeyPress", "Keypress= @FMessage#FMessage#")]
TRAIT = ("GeninvT.button1_Click", "Click=True@Button1#GeninvT#Button1#")
IMPR = ("GeninvT.Button3_Click", "Click=True@Button3#GeninvT#Button3#")
def radio(nom, cadre):
    return ("GeninvT.%s_Click" % nom, "Click=True@%s#GeninvT#%s#%s#" % (nom, cadre, nom))
FM, FR, CS = radio('Fm', 'Frame1'), radio('Fr', 'Frame1'), radio('Cs', 'Frame1')
CA, DS, CS2 = radio('Ca', 'Frame2'), radio('Ds', 'Frame2'), radio('Cs2', 'Frame2')
def toggle(n):
    return ("GeninvT.ToggleButton%d_Click" % n, "Click=True@ToggleButton%d#GeninvT#Frame1#ToggleButton%d#" % (n, n))
def col(nom, cle):
    return ("GeninvT.%s_Click" % nom, "Click=%s@%s#GeninvT#%s#" % (cle, nom, nom))
def saisie(champ, texte, efface=5):
    """Focus, effacement (Suppr puis BackSpace), frappe, Entrée : liste de (attente, gestionnaire, action)."""
    p = "%s#GeninvT#Frame1#%s#" % (champ, champ)
    out = [(1.0, "GeninvT.Cmpt_GotFocus", "Focus=@" + p)]
    for k in [SUPPR] * efface + [BS] * efface + list(texte) + [ENTREE]:
        out.append((0.05 if len(out) > 1 else 0.1, "GeninvT.Cmpt_KeyPress", "Keypress=%s@%s" % (k, p)))
    return out

def ev(t, h, a):
    return "06/15/2018 10:%02d:%06.3f;Info;GUI;laurux;test;test;1;%s;%s" % (int(t // 60), t % 60, h, a)
def scen(nom, idt, objet, desc, dataset, evts, extra=None):
    d = A + '/geninvt_' + nom
    os.makedirs(d, exist_ok=True)
    t = 4.0
    out = [ev(t, *MENU)]
    for e in evts:
        if isinstance(e, list):
            for (dt, h, a) in e:
                t += dt
                out.append(ev(t, h, a))
        else:
            t += 1.0
            out.append(ev(t, *e))
    open(d + '/scenario.log', 'w').write("\n".join(out) + "\n")
    meta = {"id": idt, "objet": objet, "classe": "GeninvT", "description": desc, "dataset": "geninvt_shared/" + dataset,
            "date": "2018-06-15 10:00:00", "args": [], "societe": "01", "timeout": 20,
            "cadence": {"frappe": 50, "focus": 100, "traitement": 1000, "fenetre": 1000}}
    if extra:
        meta.update(extra)
    p = d + '/meta.json'
    if os.path.exists(p):
        old = json.load(open(p))
        if "cadence" in old:
            meta["cadence"] = old["cadence"]
    json.dump(meta, open(p, 'w'), indent=1, ensure_ascii=False)
    open(p, 'a').write("\n")

PDF = {"conf": {"/Soc01/caisse/CmdVis": "sh -c 'pdftotext -layout \"$0\" - >> {home}/edition.txt'"}, "fichiers": ["edition.txt"]}

scen('familles', 'GENINVT-T01', 'Génération par familles, bornes par défaut, tri Casier',
     "Jeu invt_vide (Fiches_InvT vide) : Traitement, « Traitement terminé » (Entrée). Attendu : Fiches_InvT recréée avec 001, 002, 003 (004 non stocké exclu), ordre art_fam, art_design (tri Casier ignoré, figé), date 2018-06-15, comptages à 0.",
     'invt_vide', [TRAIT, OUI])
scen('familles_code', 'GENINVT-T02', 'Plage de familles restreinte, tri Code article',
     "Jeu invt_vide : familles 01 à 02, tri Code article, Traitement, fin (Entrée). Attendu : 001 et 002 seulement, ordre art_code.",
     'invt_vide', [saisie('Fam', '01'), saisie('Fam2', '02'), CA, TRAIT, OUI])
scen('fournisseurs', 'GENINVT-T03', 'Fournisseurs, bornes par défaut puis un fournisseur, tri Désignation',
     "Jeu invt_vide : Fournisseurs, tri Désignation, Traitement (bornes 40100001-40199999 : 001, 002, 003), fin ; puis bornes 401002-401002, Traitement, « inventaire non validé en cours » Oui (Entrée), fin. Attendu : Fiches_InvT = 002 seul (ordre art_four, art_design).",
     'invt_vide', [FR, DS, TRAIT, OUI, saisie('Four', '401002', 8), saisie('Four2', '401002', 8), TRAIT, OUI, OUI])
scen('casiers', 'GENINVT-T04', 'Casiers, plage de casiers, tri Casier',
     "Jeu invt_vide : Casier, bornes 10 à 20, Traitement, fin. Attendu : 002 (casier 10) puis 001 (casier 20), ordre art_casier, art_design ; 003 (30) et 004 (non stocké) exclus.",
     'invt_vide', [CS, saisie('Casier', '10'), saisie('Casier2', '20'), TRAIT, OUI])
scen('bornes', 'GENINVT-T05', 'Bornes manquantes',
     "Jeu invt_genere : borne de fin des familles vidée, Traitement. Attendu : « Veuillez saisir les bornes » (Entrée) ; Fiches_InvT inchangée.",
     'invt_genere', [saisie('Fam2', ''), TRAIT, OUI], {"compare_sql_log": "ordered"})
scen('regen_oui', 'GENINVT-T06', 'Régénération d\'un inventaire non validé : Oui',
     "Jeu invt_genere (inventaire en cours, comptages) : Traitement, « inventaire non validé en cours » bouton 1 Oui (Entrée, GeninvT.class:78), fin. Attendu : Fiches_InvT recréée (comptages perdus, lind 1 à 3).",
     'invt_genere', [TRAIT, OUI, OUI])
scen('regen_non', 'GENINVT-T06', 'Régénération d\'un inventaire non validé : Non',
     "Jeu invt_genere : Traitement, « inventaire non validé en cours » bouton 2 Non (Tab, Espace, GeninvT.class:78). Attendu : Fiches_InvT inchangée.",
     'invt_genere', [TRAIT, NON], {"compare_sql_log": "ordered"})
scen('regen_valide', 'GENINVT-T07', 'Régénération d\'un inventaire marqué validé',
     "Jeu invt_valide (inv_valid = 1) : Traitement, « détruire l'inventaire validé » bouton 1 Oui (Entrée, GeninvT.class:85), fin. Attendu : Fiches_InvT recréée, inv_valid NULL.",
     'invt_valide', [TRAIT, OUI, OUI])
scen('premiere', 'GENINVT-T08', 'Première génération (table absente)',
     "Jeu art_stock (pas de Fiches_InvT) : Traitement. Le SELECT sur la table absente part dans le Catch de button1_Click qui appelle gen_Inv (GENINVT-A02 figée) ; fin (Entrée). Attendu : Fiches_InvT créée avec 001, 002, 003.",
     'art_stock', [TRAIT, OUI])
scen('vide', 'GENINVT-T09', 'Plage vide',
     "Jeu invt_genere : familles 05 à 09 (aucun article), Traitement, « non validé » Oui, « Aucun article pour cette demande » (Entrée). Attendu : Fiches_InvT recréée vide (comptages en cours perdus).",
     'invt_genere', [saisie('Fam', '05'), saisie('Fam2', '09'), TRAIT, OUI, OUI])
scen('imp_renum', 'GENINVT-T10', 'Impression avec renumérotation',
     "Jeu invt_genere (lignes 003, 001, 002) : tri Désignation, Imprimer ; tri Code article, Imprimer. Attendu : inv_nlig renumérotés selon le dernier tri (001=1, 002=2, 003=3 ; GENINVT-A01 figée) ; texte des deux PDF dans edition.txt (stock théorique imprimé).",
     'invt_genere', [DS, IMPR, CA, IMPR], PDF)
scen('imp_sans_stock', 'GENINVT-T11', 'Impression sans stock théorique',
     "Jeu invt_genere : case « Impression du stock theorique » décochée, tri Casier (défaut), Imprimer. Attendu : colonne quantité vide dans le PDF (edition.txt) ; inv_nlig renumérotés par inv_casier.",
     'invt_genere', [("GeninvT.Stkt_Click", "Click=0@Stkt#GeninvT#Stkt#"), IMPR], PDF)
scen('imp_absent', 'GENINVT-T11', 'Impression sans inventaire',
     "Jeu art_stock (pas de Fiches_InvT) : Imprimer. Attendu : « Impression impossible ! Veuillez génerer votre inventaire » (Catch de Button3_Click, Entrée) ; aucune table créée.",
     'art_stock', [IMPR, OUI], {"compare_sql_log": "ordered"})
scen('listes_choix', 'GENINVT-T12', 'Listes de choix par clic',
     "Jeu invt_vide : ToggleButton1 puis clic famille 02 (Colfam), ToggleButton2 puis clic 02 (Colfam2), Traitement, fin. Puis Fournisseurs, ToggleButton3 clic 401002 (Colfour), ToggleButton4 clic 401002 (Colfour2), Traitement, Oui, fin. Attendu : Fiches_InvT = 002 seul.",
     'invt_vide', [toggle(1), col('Colfam', '02'), toggle(2), col('Colfam2', '02'), TRAIT, OUI,
                   FR, toggle(3), col('Colfour', '401002'), toggle(4), col('Colfour2', '401002'), TRAIT, OUI, OUI])
scen('criteres', 'GENINVT-T13', 'Changement de critère répété',
     "Jeu invt_vide : Fournisseurs, Casier, Familles × 3 (Utils.Observers rappelé à chaque clic, GENINVT-A04), Traitement, fin. Attendu : génération par familles bornes par défaut (001, 002, 003), une seule fois.",
     'invt_vide', [FR, CS, FM, FR, CS, FM, FR, CS, FM, TRAIT, OUI])
