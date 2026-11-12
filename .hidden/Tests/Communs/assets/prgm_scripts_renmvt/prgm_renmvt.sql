-- Prgm (PRGM-T06, RenMvt) : écriture 1005 du journal 80 dans Fiches_Mvt (2 lignes) et écriture 7 du journal 10
-- (non concernée). RenMvt la déplace vers Fiches_Mvt1 sous le numéro 5 (premier chiffre retiré).
INSERT INTO Fiches_Mvt (jour, numero, compte, intitule, dte, libelle, montantd, montantc, validee, pointee, cloturee) VALUES
 ('80', 1005, '411000', 'Clients', '2026-01-10', 'Report 80', 120.50, 0, 0, 0, 0),
 ('80', 1005, '512000', 'Banque', '2026-01-10', 'Report 80', 0, 120.50, 0, 0, 0),
 ('10', 7, '607000', 'Achats', '2026-01-11', 'Achat', 50, 0, 0, 0, 0);
