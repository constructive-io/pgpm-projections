-- Deploy: schemas/shop/tables/product_reviews/table
-- made with <3 @ constructive.io




CREATE TABLE shop.product_reviews (
  id uuid DEFAULT gen_random_uuid() NOT NULL,
  product_id uuid NOT NULL,
  customer_id uuid NOT NULL,
  rating int NOT NULL,
  body text,
  created_at timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT product_reviews_rating_check 
    CHECK (
    rating >= 1
      AND rating <= 5
  ),
  CONSTRAINT product_reviews_pkey PRIMARY KEY (id)
);

COMMENT ON TABLE shop.product_reviews IS 'Customer product reviews, 1-5 stars.';

ALTER TABLE ONLY shop.product_reviews 
  ADD CONSTRAINT product_reviews_customer_id_fkey
    FOREIGN KEY(customer_id)
    REFERENCES shop.customers (id);

ALTER TABLE ONLY shop.product_reviews 
  ADD CONSTRAINT product_reviews_product_id_fkey
    FOREIGN KEY(product_id)
    REFERENCES shop.products (id)
    ON DELETE CASCADE;

GRANT SELECT, INSERT ON shop.product_reviews TO app_user;

