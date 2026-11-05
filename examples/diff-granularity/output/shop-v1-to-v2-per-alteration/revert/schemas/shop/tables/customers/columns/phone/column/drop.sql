-- Revert: schemas/shop/tables/customers/columns/phone/column/drop


ALTER TABLE shop.customers ADD COLUMN phone text;


