/*Création de tables*/

create table camelot(nom VARCHAR,
pays_naissance VARCHAR,
merite numeric,
id_hf numeric,
lieu VARCHAR,
nature VARCHAR,
jour date);

\copy camelot FROM ’camelot.csv’
WITH (DELIMITER ’;’, format CSV, HEADER, ENCODING ’UTF8’);

create table chevalier AS
select DISTINCT nom, pays_naissance, merite
from camelot;
alter table chevalier add primary key(nom);
alter table chevalier add column merite set default 0;

create table haut_fait AS
select DISTINCT id_hf, lieu, nature, jour
from camelot;
alter table haut_fait add primary key(id_hf);
alter table haut_fait alter column jour set default current_date;

create table participe AS
select id_hf, equipier
from participe;
alter table participe add primary key(id_hf,equipier);
alter table participe add foreign key(id_hf) references haut_fait(id_hf);
alter table participe add foreign key(equipier) references chevalier(nom);

/*Schéma alternatif*/
create or update view equipe_an_passe as
select * from participe
where extract("annee" from jour) = extract("annee" from lieu current_date) - 1;


create or update view bilan(heros, nb_hf) as
select nom, count(id_hf) from chevalier left join equipe_an_passe as nom=equipier
group by nom
order by nb_hf desc;

upate merite
set merite = merite + (select nb_hf from bilan where nom =heros);

create or replace view traces_du_graal as(id, authentique, lieu, jour)
select id, authentique, lieu, jour
from graal natural join haut_fait;

/*Trigger simple*/

CREATE OR REPLACE FUNCTION fonction()
RETURNS TRIGGER AS $$
BEGIN
	delete from haut_fait where id_hf not in (selet id_hf from participe);
    if found THEN
        raise notice '%on%fires%suppression de haut-fait', TG_OP
	RETURN null;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER
trigger
AFTER delete on participe
FOR EACH ROW
EXECUTE FUNCTION fonction();

SQL
/* Crée la fonction qui sera appelée par le trigger (Fonction) */

CREATE OR REPLACE FUNCTION name_function()
RETURNS TRIGGER AS $$
BEGIN
	if old.authentique and not new.authentique THEN
        raise exception ''
    end if;
    return new;
END;
$$ LANGUAGE plpgsql;


/* Crée le trigger qui déclenchera la fonction une fois qu'il sera appelé (Trigger) */

CREATE OR REPLACE TRIGGER
name_trigger
BEFORE update on Graal
FOR EACH ROW
EXECUTE FUNCTION name_function();

SQL
/* Crée la fonction qui sera appelée par le trigger (Fonction) */

CREATE OR REPLACE FUNCTION name_function()
RETURNS TRIGGER AS $$
BEGIN
	if((select count(authentique) from graal where authentique = true) > 0) THEN
        raise exception ''
    end if;
	RETURN {OLD/NEW};
END;
$$ LANGUAGE plpgsql;


/* Crée le trigger qui déclenchera la fonction une fois qu'il sera appelé (Trigger) */

CREATE OR REPLACE TRIGGER
name_trigger
{BEFORE/AFTER} action
{FOR EACH ROW / COLUMN}
EXECUTE FUNCTION name_function();
