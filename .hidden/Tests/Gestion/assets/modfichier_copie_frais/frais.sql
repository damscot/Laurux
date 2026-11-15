-- modfichier-T03 : Laurux01 avec deux articles à frais non nuls (art_frais <> 0), option boisson non encore activée.
UPDATE Fiches_Art SET art_frais = 1.5 WHERE art_code = '001';
UPDATE Fiches_Art SET art_frais = 2 WHERE art_code = '002';
