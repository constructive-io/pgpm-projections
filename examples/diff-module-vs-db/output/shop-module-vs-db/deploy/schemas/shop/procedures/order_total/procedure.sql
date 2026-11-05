-- Deploy: schemas/shop/procedures/order_total/procedure
-- made with <3 @ constructive.io




CREATE OR REPLACE FUNCTION shop.order_total(p_order_id uuid) RETURNS int LANGUAGE sql STABLE AS $$
  SELECT COALESCE(SUM(quantity * unit_price_cents), 0)::integer
  FROM shop.order_items
  WHERE order_id = p_order_id
    AND quantity > 0;
$$;

