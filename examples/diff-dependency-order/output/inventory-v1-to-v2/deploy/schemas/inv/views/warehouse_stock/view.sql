-- Deploy: schemas/inv/views/warehouse_stock/view
-- made with <3 @ constructive.io

-- requires: schemas/inv/tables/warehouse/table
-- requires: schemas/inv/tables/item/table/alter
-- requires: schemas/inv/tables/item/table/alter-2


CREATE VIEW inv.warehouse_stock AS SELECT
  w.code,
  sum(i.qty) AS qty
FROM inv.warehouse AS w
LEFT JOIN inv.item AS i ON i.warehouse_id = w.id
GROUP BY
  w.code;

