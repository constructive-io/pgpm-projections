-- Deploy: schemas/inv/procedures/item_count/procedure
-- made with <3 @ constructive.io

-- requires: schemas/inv/schema


CREATE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $$
  SELECT count(*) FROM inv.item
$$;

