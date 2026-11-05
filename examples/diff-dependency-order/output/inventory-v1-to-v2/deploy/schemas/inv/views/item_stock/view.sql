-- Deploy: schemas/inv/views/item_stock/view
-- made with <3 @ constructive.io

-- requires: schemas/inv/tables/item/table/alter-2
-- requires: schemas/inv/views/item_stock/view/drop


CREATE VIEW inv.item_stock AS SELECT
  i.id,
  i.qty
FROM inv.item AS i;

