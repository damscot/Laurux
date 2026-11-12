-- Jeu FEditrel prêt (agent 6, vague 3) : écritures de feditrel_relances + table Fiches_relances déjà générée.
-- 411001 : 401 F401 100 D échue 2018-05-01 (relance NULL -> niveau 1) ; 402 F402 50 D non échue (dateech 2018-07-30) ;
-- 411002 : 403 F403 80 D échue, relance 2 (-> 3) ; 404 sans numdoc 20 D, relance 3 (-> 3) ;
-- 411999 : 405 F405 10 D échue, compte sans fiche Fiches_Cli (exclu).
INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,dateech,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,relance) VALUES
(401,'70',61,61,'411001',NULL,'A Divers','2018-04-01 00:00:00','2018-05-01 00:00:00','F401',NULL,'Facture F401',100.00,0.00,1,0,0,0,NULL,0,0,NULL),
(402,'70',62,62,'411001',NULL,'A Divers','2018-06-01 00:00:00','2018-07-30 00:00:00','F402',NULL,'Facture F402',50.00,0.00,1,0,0,0,NULL,0,0,NULL),
(403,'70',63,63,'411002',NULL,'B Divers','2018-03-01 00:00:00','2018-04-01 00:00:00','F403',NULL,'Facture F403',80.00,0.00,1,0,0,0,NULL,0,0,2),
(404,'70',64,64,'411002',NULL,'B Divers','2018-02-01 00:00:00','2018-03-01 00:00:00',NULL,NULL,'Facture sans numero',20.00,0.00,1,0,0,0,NULL,0,0,3),
(405,'70',65,65,'411999',NULL,'Inconnu','2018-01-10 00:00:00','2018-02-01 00:00:00','F405',NULL,'Facture F405',10.00,0.00,1,0,0,0,NULL,0,0,NULL);
-- Table de travail Fiches_relances déjà générée (état d'une génération précédente, cf. FEDITREL-T02).
CREATE TABLE Fiches_relances (compte Char(8) NOT NULL,rs char(10) ,intitule char(50) ,adr1 char(35) ,adr2 char(35) ,cp char(10) ,ville char(35) ,pays char(35) ,dte date ,numdoc char(10),numlot char(10) ,libelle char(50) ,montantd Decimal(12,2) ,montantc Decimal(12,2) ,numero char(8) ,journal char(2) ,niveau integer(1),lind char(10) ,PRIMARY KEY (compte, lind)) ENGINE = InnoDB;
INSERT INTO Fiches_relances (compte, rs, intitule, adr1, adr2, cp, ville, pays, dte, numdoc, numlot, libelle, montantd, montantc, numero, journal, niveau, lind) VALUES
('411001', NULL, 'A Divers  ', NULL, NULL, NULL, NULL, 'France', '2018-04-01', 'F401', NULL, 'Facture F401', 100.00, 0.00, 61, '70', 1, 401),
('411002', NULL, 'B Divers  ', NULL, NULL, NULL, NULL, 'France', '2018-02-01', NULL, NULL, 'Facture sans numero', 20.00, 0.00, 64, '70', 3, 404),
('411002', NULL, 'B Divers  ', NULL, NULL, NULL, NULL, 'France', '2018-03-01', 'F403', NULL, 'Facture F403', 80.00, 0.00, 63, '70', 3, 403);
