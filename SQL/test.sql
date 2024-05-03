--------------------------------------------------------------------------------

        -- INFORMATIONS SUR LES DONNÉES DE L'INSTANCE DE LA BD --

--------------------------------------------------------------------------------

SET DATESTYLE TO EUROPEAN;



/*______________________________________________________________________________

BESOIN N°1.

Affichage de toutes les représentations futures

______________________________________________________________________________*/




select coderep from representation;




/*______________________________________________________________________________

BESOIN N°2.

Affichage du jour, de l'heure de début, du lieu et du nombre de numéros

présentés, pour chacune des représentations futures.

Résultat ordonné sur la date, puis l'heure des représentations

______________________________________________________________________________*/







select r.jour, r.heuredebut, l.adresse, count(p.titre)
from r.coderep = p.coderep and r.idlieu = l.idlieu
group by r.coderep



/*______________________________________________________________________________

BESOIN N°3.

Nombre de représentations  passées ou à venir où est présenté un numéro sous la

responsabilité de Etoile, mais aucun numéro sous la responsabilité de Bozzo

CONTRAINTE : utiliser EXISTS / NOT EXISTS pour coder ce BESOIN

______________________________________________________________________________*/


select count(*) from representation r
where exists(select n.titre from presente p, numero n where p.coderep = r.coderep and p.titre = n.titre and Responsable='Etoile')
and not exists(select n.titre from presente p, numero n where p.coderep = r.coderep and p.titre = n.titre and Responsable='Bozzo')




/*______________________________________________________________________

BESOIN N°4.

Date, heure de début et adresse des représentations dans lesquelles

au moins 5 numéros sont présentés - Résultat ordonné par date, puis heure début

______________________________________________________________________________*/



select r.date, r.heuredebut l.adresse
from representation r, lieu l, presente p
where r.idlieu = l.idlieu and r.coderep = p.coderep
group by r.date, r.heuredebut, l.adresse
having count(p.titre) > 5












select r.date, r.heuredebut, l.adresse
from representation r, lieu l
where r.idlieu = l.idlieu
and r.coderep in (select p.coderep from presente p where count(titre) > 5)




/*______________________________________________________________________________

BESOIN N°5.

Date, heure de début et adresse des représentations dans lesquelles

tous les numéros sont présentés

______________________________________________________________________________*/


select r.date, r.heuredebut, l.adresse
from representation r, lieu l, presente p
where r.idlieu = l.idlieu
group by r.date, r.heuredebut, l.adresse
having count(p.titre) = (select count(*) from numero);



/*______________________________________________________________________________

BESOIN N°6.

Un entracte de 30 à 45 minutes doit être respecté lors de chaque représentation

(valeur par défaut 30 mn).

______________________________________________________________________________*/

-- (1) Faites le nécessaire sans modifier le fichier create.sql



ALTER TABLE representation ADD COLUMN Entracte Time DEFAULT '00:30:00' CHECK (Entracte BETWEEN '00:30:00' AND '00:45:00');

--ALTER TABLE representation ADD CONSTRAINT entr_30_45 CHECK (interect BETWEEN '30:00' AND '45:00');





-- (2) Afichez les n-uplets de REPRESENTATION



SELECT * FROM representation;





-- Que remarquez-vous ?





/*______________________________________________________________________________

BESOIN N°7.

Durée de la représenation de code 'R1ANN', entracte non comprise

______________________________________________________________________________*/



SELECT n.duree FROM representation r, presente p, numero n

WHERE r.coderep = p.coderep AND p.titre = n.titre AND r.coderep = 'R1ANN';





/*______________________________________________________________________________

BESOIN N°8.

Faites en sorte que l'entracte des représentations qui présentent

plus de 5 numéros soit de 40 mn

______________________________________________________________________________*/



UPDATE representation SET entracte = '00:40:00'

WHERE CodeRep IN (

    SELECT p.CodeRep

    FROM PRESENTE p

    GROUP BY p.CodeRep

    HAVING COUNT(p.Titre) > 5

);



SELECT * FROM representation;





/*______________________________________________________________________________

BESOIN N°9.

Code, Date, Heure début, Durée (entracte comprise) de chaque représentation

passée ou à venir

Résultat ordonné par date, puis par heure début

______________________________________________________________________________*/



SELECT r.coderep, r.date, r.heuredebut, n.duree

FROM representation r, presente p, numero n

WHERE r.coderep = p.coderep AND p.titre = n.titre;





/*______________________________________________________________________________

BESOIN N°10.

Selon la RG8. énoncée dans le TD6, il doit y avoir au moins 5h d'écart entre

l'heure de début d'une représentation et l'heure de fin de la précédente.



------------------------------

(1) À quelle heure maximale devrait commencer une représentation qui présenterait

    tous les numéros, avec une entracte de 40 mn et qui serait programmée

    avant la représentation de code R1ANN ?



    INDICATIONS

    Procédez par étape pour constuire le résultat...

    (a) Requête donnant la durée nécessaire à la présentation de tous les

        numéros à laquelle s'ajouterait un entracte de 40 mn

    (b) Requête donnant l'heure de fin maximale d'une représentation qui serait

        donnée avant la représentation de code R1ANN (cf. RG8)

    (c) Production du résultat attendu...*/

-------------------------------



-- (a) Durée totale de présentation de tous les numéros + 40mn d'entracte



SELECT sum(duree) + '00:40:00' FROM numero;









-- (b) Heure de fin maximale d'une représentation commençant avant celle

--     de code R1ANN







-- (c) Heure de début maximale d'une représentation de tous les numéros....







/*-----------------------------

(2) Si l'heure trouvée est supérieure à 10h, créez une représentation

    de code R2ANN dans le même lieu et le même jour que la réservation R1ANN

    et débutant à cette heure.

	NOTE : l'insertion dans PRESENCE de tous les numéros pour cette représentation

         n'est pas demandée

-----------------------------*/











--------------------------------------------------------------------------------

-- FIN !!!

--------------------------------------------------------------------------------