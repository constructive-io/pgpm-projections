-- Deploy: schemas/inv/tables/item/table/alter-2
-- made with <3 @ constructive.io

-- requires: schemas/inv/views/item_summary/view
-- requires: schemas/inv/views/item_stock/view/drop


ALTER TABLE inv.item DROP COLUMN legacy_code RESTRICT;
ALTER TABLE inv.item ALTER COLUMN qty TYPE bigint USING CAST(qty AS bigint);

