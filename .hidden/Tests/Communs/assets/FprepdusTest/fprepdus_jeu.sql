-- Fprepdus (FPREPDUS-T02/T04) : soldes contrôlés de 3 comptes clients et 2 comptes fournisseurs.
UPDATE Fiches_Comptes SET solde = 0;
UPDATE Fiches_Comptes SET solde = 100 WHERE compte_cc = 411001;
UPDATE Fiches_Comptes SET solde = 50.5 WHERE compte_cc = 411002;
UPDATE Fiches_Comptes SET solde = -20 WHERE compte_cc = 411003;
UPDATE Fiches_Comptes SET solde = -300 WHERE compte_cc = 401001;
UPDATE Fiches_Comptes SET solde = 10 WHERE compte_cc = 401002;
