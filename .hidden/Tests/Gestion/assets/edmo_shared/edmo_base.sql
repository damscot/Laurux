-- Edmo : la Mo 05 de Laurux01 (mo_valeurht NULL, cas EDMO-T04) reçoit une valeur ; Mo de la famille 11,
-- forfaits (mo_tempmont 0) et temps passés (1), codes TVA 1, 2 et inconnu (9).
UPDATE Fiches_Mo SET mo_valeurht = 0 WHERE mo_code = '05';
INSERT INTO Fiches_Mo (mo_code,mo_design,mo_fam,mo_four,mo_txcd,mo_txht,mo_tva,mo_tempmont,mo_montant,mo_valeurht,mo_cdarr,mo_valeurttc,mo_prvt,mo_marge,mo_impcar,mo_crst) VALUES
('06','Forfait vidange','11',401002,'1',0,'2','0',NULL,40,'0,01',42.8,20.000,0.000,0,NULL),
('07','Pose accessoire','11',401002,'2',30,'1','1',1.5,0,'0,01',0,15.000,0.000,0,NULL),
('08','Controle sans TVA connue','11',401002,'1',0,'9','0',NULL,12.5,'0,01',12.5,5.000,0.000,0,NULL),
('09','Reglage','10',401001,'1',25,'3','1',2,0,'0,01',0,10.000,0.000,0,NULL);
