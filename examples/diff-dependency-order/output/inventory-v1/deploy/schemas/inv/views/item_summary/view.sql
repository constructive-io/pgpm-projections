-- Deploy: schemas/inv/views/item_summary/view
-- made with <3 @ constructive.io

-- requires: schemas/inv/schema
-- requires: schemas/inv/tables/item/table


CREATE VIEW inv.item_summary AS SELECT
  i.id,
  i.name,
  i.legacy_code
FROM inv.item AS i;

