-- FMENU-T19 : rendez-vous de l'utilisateur courant (« laurux » dans le conteneur de test) à 10h01 le 2026-01-15
-- (date figée du scénario : 10:00:10, premier tick de Timer1 60 s après la création de Fmenu, soit vers 10:01:13),
-- un rendez-vous à une autre heure et un rendez-vous d'un autre utilisateur à la même heure (non rappelés).
INSERT INTO Fiches_Agenda (lind, daction, haction, iaction, nuser) VALUES
 (1, '2026-01-15', '10h01', 'Rendez-vous client Martin', 'laurux'),
 (2, '2026-01-15', '11h30', 'Reunion fournisseur', 'laurux'),
 (3, '2026-01-15', '10h01', 'Rendez-vous d un autre utilisateur', 'autre');
