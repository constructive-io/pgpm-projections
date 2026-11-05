DROP INDEX shop.idx_orders_placed_at;

ALTER TABLE shop.customers 
  DROP COLUMN phone RESTRICT;

ALTER TABLE shop.customers 
  ADD COLUMN marketing_opt_in boolean
    DEFAULT false
    NOT NULL;

ALTER TABLE shop.orders 
  DROP CONSTRAINT orders_status_check RESTRICT;

ALTER TABLE shop.orders 
  ADD CONSTRAINT orders_status_check 
    CHECK (status IN ('pending', 'paid', 'shipped', 'cancelled', 'refunded'));

CREATE OR REPLACE FUNCTION shop.order_total(
  p_order_id uuid
) RETURNS int LANGUAGE sql STABLE AS $EOFCODE$
  SELECT COALESCE(SUM(quantity * unit_price_cents), 0)::integer
  FROM shop.order_items
  WHERE order_id = p_order_id
    AND quantity > 0;
$EOFCODE$;

COMMENT ON FUNCTION shop.order_total(p_order_id uuid) IS 'Sum of line totals for an order, in cents.';

CREATE TABLE shop.product_reviews (
  id uuid DEFAULT gen_random_uuid() NOT NULL,
  product_id uuid NOT NULL,
  customer_id uuid NOT NULL,
  rating int NOT NULL,
  body text,
  created_at timestamptz DEFAULT now() NOT NULL,
  CONSTRAINT product_reviews_pkey PRIMARY KEY (id),
  CONSTRAINT product_reviews_rating_check 
    CHECK (
    rating >= 1
      AND rating <= 5
  )
);

ALTER TABLE ONLY shop.product_reviews 
  ADD CONSTRAINT product_reviews_product_id_fkey
    FOREIGN KEY(product_id)
    REFERENCES shop.products (id)
    ON DELETE CASCADE;

ALTER TABLE ONLY shop.product_reviews 
  ADD CONSTRAINT product_reviews_customer_id_fkey
    FOREIGN KEY(customer_id)
    REFERENCES shop.customers (id);

COMMENT ON TABLE shop.product_reviews IS 'Customer product reviews, 1-5 stars.';

GRANT SELECT, INSERT ON shop.product_reviews TO app_user;

CREATE INDEX idx_product_reviews_product_id ON shop.product_reviews (product_id);

CREATE POLICY orders_insert_own
  ON shop.orders
  AS PERMISSIVE
  FOR INSERT
  TO PUBLIC
  WITH CHECK (
    customer_id = (current_setting('app.current_customer_id', true))::uuid
  );
