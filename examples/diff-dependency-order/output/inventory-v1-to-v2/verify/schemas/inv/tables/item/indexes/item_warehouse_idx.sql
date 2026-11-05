-- Verify: schemas/inv/tables/item/indexes/item_warehouse_idx


SELECT 1 / (CASE WHEN to_regclass('inv.item_warehouse_idx') IS NOT NULL THEN 1 ELSE 0 END);


