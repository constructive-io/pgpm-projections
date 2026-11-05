-- Deploy: schemas/inv/tables/item/indexes/item_warehouse_idx
-- made with <3 @ constructive.io

-- requires: schemas/inv/tables/item/table/alter


CREATE INDEX item_warehouse_idx ON inv.item (warehouse_id);

