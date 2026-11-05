-- Deploy: schemas/shop/tables/order_items/constraints/order_items_product_id_fkey
-- made with <3 @ constructive.io

-- requires: schemas/shop/schema
-- requires: schemas/shop/tables/products/table
-- requires: schemas/shop/tables/order_items/table
-- requires: schemas/shop/tables/order_items/columns/product_id


ALTER TABLE ONLY shop.order_items 
  ADD CONSTRAINT order_items_product_id_fkey
    FOREIGN KEY(product_id)
    REFERENCES shop.products (id);

GRANT SELECT, INSERT ON shop.order_items TO app_user;

