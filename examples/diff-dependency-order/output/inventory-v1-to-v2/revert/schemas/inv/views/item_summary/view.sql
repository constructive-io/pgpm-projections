-- Revert: schemas/inv/views/item_summary/view


DROP VIEW inv.item_summary;
CREATE VIEW inv.item_summary AS SELECT
  i.id,
  i.name,
  i.legacy_code
FROM inv.item AS i;


