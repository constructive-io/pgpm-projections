-- Deploy: schemas/inv/views/item_stock/view
-- made with <3 @ constructive.io

-- requires: schemas/inv/schema
-- requires: schemas/inv/tables/item/table


CREATE VIEW inv.item_stock AS SELECT
  i.id,
  i.qty
FROM inv.item AS i;

