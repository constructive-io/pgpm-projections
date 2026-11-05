-- Revert: schemas/inv/procedures/item_count/procedure


CREATE OR REPLACE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $$
  SELECT count(*) FROM inv.item
$$;


