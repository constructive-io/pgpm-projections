-- Revert: schemas/inv/tables/item/table/alter


ALTER TABLE inv.item DROP CONSTRAINT item_warehouse_id_fkey RESTRICT;
ALTER TABLE inv.item DROP COLUMN warehouse_id RESTRICT;


