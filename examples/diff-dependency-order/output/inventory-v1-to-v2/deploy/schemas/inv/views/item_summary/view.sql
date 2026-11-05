-- Deploy: schemas/inv/views/item_summary/view
-- made with <3 @ constructive.io

-- requires: schemas/inv/tables/item/table/alter


DROP VIEW inv.item_summary;
CREATE VIEW inv.item_summary AS SELECT
  i.id,
  i.name,
  i.warehouse_id
FROM inv.item AS i;

