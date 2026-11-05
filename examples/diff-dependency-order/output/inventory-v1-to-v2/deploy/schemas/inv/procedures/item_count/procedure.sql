-- Deploy: schemas/inv/procedures/item_count/procedure
-- made with <3 @ constructive.io




CREATE OR REPLACE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $$
  SELECT count(1) FROM inv.item
$$;

