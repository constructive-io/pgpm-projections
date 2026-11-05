-- Revert: schemas/shop/tables/customers/columns/marketing_opt_in/column


ALTER TABLE shop.customers DROP COLUMN marketing_opt_in RESTRICT;


