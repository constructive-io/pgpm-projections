-- Revert: schemas/inv/tables/warehouse/table


ALTER TABLE inv.warehouse DROP CONSTRAINT warehouse_main_item_fk RESTRICT;
DROP TABLE inv.warehouse;


