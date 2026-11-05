-- Deploy: schemas/shop/tables/customers/columns/marketing_opt_in/column
-- made with <3 @ constructive.io




ALTER TABLE shop.customers ADD COLUMN marketing_opt_in boolean DEFAULT false NOT NULL;

