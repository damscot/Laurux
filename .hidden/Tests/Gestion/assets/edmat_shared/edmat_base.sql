-- Jeu EdMat (agent 6, vague 5) : 3 marques et 8 matériels.
-- Vendus dans la plage clients 41100001-41199999 : M0001, M0002, M0006, M0008 ; hors plage : M0005 (41200001).
-- En stock (mat_cli nul, mat_vendu 0) : M0003, M0007 ; M0004 sans client mais mat_vendu 1 (ni vendu ni stock).
INSERT INTO Fiches_Marques (code, intitule) VALUES ('B01','BOSCH'),('D01','DEWALT'),('M01','MAKITA');
INSERT INTO Fiches_Materiels (mat_serie,mat_code,mat_design,mat_fam,mat_four,mat_cbarre,mat_cfour,mat_pvht,mat_tva,mat_pvttc,mat_nbd,mat_vendu,mat_marque,mat_type,mat_cli) VALUES
('S100','M0001','Perceuse a percussion','OUTIL','40100001','3000000000011','REF-P1',100.000,20.000,120.000,'2',1,'BOSCH','PSB','41100001'),
('S090','M0002','Visseuse sans fil','OUTIL','40100001','3000000000028','REF-V2',80.500,20.000,96.600,'2',1,'MAKITA','DF3','41100002'),
('S080','M0003','Meuleuse 125','OUTIL','40100001','3000000000035','REF-M3',65.000,20.000,78.000,'2',0,'BOSCH','GWS',NULL),
('S060','M0004','Scie sauteuse','OUTIL','40100001','3000000000042','REF-S4',90.000,20.000,108.000,'2',1,'DEWALT','DW3',NULL),
('S110','M0005','Rabot electrique','OUTIL','40100001','3000000000059','REF-R5',150.000,20.000,180.000,'2',1,'DEWALT','DW6','41200001'),
('S050','M0006','Ponceuse orbitale','OUTIL','40100001','3000000000066','REF-O6',55.250,20.000,66.300,'2',1,'DEWALT','DWE','41100003'),
('S070','M0007','Perforateur SDS','OUTIL','40100001','3000000000073','REF-F7',210.000,20.000,252.000,'2',0,'MAKITA','HR2',NULL),
('S040','M0008','Decapeur thermique','OUTIL','40100001','3000000000080','REF-D8',45.000,20.000,54.000,'2',1,'BOSCH','GHG','41100002');
