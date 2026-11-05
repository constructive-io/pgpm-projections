-- Revert: schemas/inv/tables/item/table/alter-2


ALTER TABLE inv.item ALTER COLUMN qty TYPE int USING qty::int;
ALTER TABLE inv.item ADD COLUMN legacy_code text;


