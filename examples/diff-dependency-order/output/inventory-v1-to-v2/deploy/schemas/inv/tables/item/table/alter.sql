-- Deploy: schemas/inv/tables/item/table/alter
-- made with <3 @ constructive.io

-- requires: schemas/inv/tables/warehouse/table


ALTER TABLE inv.item ADD COLUMN warehouse_id int;
ALTER TABLE inv.item ADD CONSTRAINT item_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES inv.warehouse (id);

