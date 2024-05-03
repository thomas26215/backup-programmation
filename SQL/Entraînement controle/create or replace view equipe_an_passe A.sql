create or replace view equipe_an_passe AS
select p.* from participe natural join haut_fait
where extraxt("year" from jour) = extract ("year" from CURRENT_DATE) -1

create or replace view bilan(heros, nb_hf) as
select nom, id_hf from chevalier left join equipe_an_passe on nom=equipier
group by nom;

CREATE OR REPLACE FUNCTION name_function()
RETURNS TRIGGER AS $$
BEGIN
	delete from haut_fait where id_hf not in (select id_hf from participe);
    if found THEN
        raise notice 'Le % sur la table % entraîne le déclencheur % : Suppression dun élément de haut-fait', TG_OP, TG_TABLE_NAME, TG_NAME;
    end if;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


/* Crée le trigger qui déclenchera la fonction une fois qu'il sera appelé (Trigger) */

CREATE OR REPLACE TRIGGER
name_trigger
AFTER delete on participe
FOR EACH ROW
EXECUTE FUNCTION name_function();