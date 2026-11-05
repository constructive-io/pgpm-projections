-- Revert: schemas/shop/tables/product_reviews/table


REVOKE SELECT, INSERT ON shop.product_reviews FROM app_user RESTRICT;
ALTER TABLE ONLY shop.product_reviews DROP CONSTRAINT product_reviews_product_id_fkey RESTRICT;
ALTER TABLE ONLY shop.product_reviews DROP CONSTRAINT product_reviews_customer_id_fkey RESTRICT;
COMMENT ON TABLE shop.product_reviews IS NULL;
DROP TABLE shop.product_reviews;


