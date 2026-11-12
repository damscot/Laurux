-- FMENU-T03 : tarifs différés (Fiches_TarTemp, dtmaj = 1). Échus à la date du scénario (2026-01-15 10:00) :
-- tarif général de l'article 001, tarif client 411001 sur 002, tarif type client 01 sur 002 (suppression),
-- et tarif général non échu de l'article 003 (2026-02-01) ; une ligne échue sans dtmaj (ignorée).
INSERT INTO Fiches_TarTemp (art, dtmaj, date, pbht, rm, paht, frais, pxrev, txconv, temp_type, code, temp_coef, temp_sup) VALUES
 ('001', 1, '2026-01-10 08:00:00', 12.000, 10.00, 10.800, 0.500, 11.300, 1.0000, 1, '', 1.5000, 0),
 ('002', 1, '2026-01-14 08:00:00', 20.000, 0.00, 20.000, 0.000, 20.000, 1.0000, 2, '411001', 1.2000, 0),
 ('002', 1, '2026-01-14 09:00:00', 20.000, 0.00, 20.000, 0.000, 20.000, 1.0000, 3, '01', 1.1000, 1),
 ('003', 1, '2026-02-01 08:00:00', 30.000, 0.00, 30.000, 0.000, 30.000, 1.0000, 1, '', 1.4000, 0),
 ('004', 0, '2026-01-01 08:00:00', 40.000, 0.00, 40.000, 0.000, 40.000, 1.0000, 1, '', 1.3000, 0);
INSERT INTO Fiches_TarTypcli (type, cart, coef) VALUES ('01', '002', 1.0500);
