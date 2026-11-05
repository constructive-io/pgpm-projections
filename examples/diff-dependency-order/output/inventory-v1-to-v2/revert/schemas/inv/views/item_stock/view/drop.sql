-- Revert: schemas/inv/views/item_stock/view/drop


CREATE VIEW inv.item_stock AS SELECT
  i.id,
  i.qty
FROM inv.item AS i;


