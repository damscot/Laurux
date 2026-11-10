-- Jeu de données TRIFAM-T01..T05 (Trifam.class) : familles hiérarchiques ajoutées aux 5 familles de Laurux01.sql
-- (01, 02, 03, 10, 11). Arbre A > A01, A02 > A0101, A0102 ; préfixes B et B01 sans fiche (B0101 seule) ;
-- codes limites : z, Z, espace, accent, « Azz » (borne supérieure de la recherche des fils).
INSERT INTO Fiches_Fam (code_fam, libell_fam) VALUES
('A', 'Alimentaire'),
('A01', 'Epicerie'),
('A02', 'Boissons'),
('A0101', 'Conserves'),
('A0102', 'Pates'),
('B0101', 'Visserie'),
('C', 'Cadeaux'),
('Az1', 'Code avec z'),
('AZ2', 'Code avec Z'),
('Azz', 'Code Azz'),
('A 1', 'Code avec espace'),
('Aé1', 'Code accentué'),
('z9', 'Code z en tête');
