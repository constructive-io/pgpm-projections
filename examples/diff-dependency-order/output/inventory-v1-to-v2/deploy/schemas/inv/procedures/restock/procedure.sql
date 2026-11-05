-- Deploy: schemas/inv/procedures/restock/procedure
-- made with <3 @ constructive.io




CREATE FUNCTION inv.restock(
  item_id int,
  amount int
) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  UPDATE inv.item SET qty = qty + amount WHERE id = item_id;
END
$$;

