-- Jeu BordereauxC T07 (agent 2, vague 4) : 2 chèques clients et un chèque de 45 sans code client (entre les deux).
INSERT INTO Fiches_BordereauxC (lind,banque,dateremise,bordereau,montant,etat,code,nom,nfacture) VALUES
(1,NULL,'2018-06-10',NULL,120.00,0,'411001','A Divers','F001'),
(2,NULL,'2018-06-11',NULL,45.00,0,NULL,'Inconnu',NULL),
(3,NULL,'2018-06-12',NULL,30.00,0,'411002','B Divers','F003');
