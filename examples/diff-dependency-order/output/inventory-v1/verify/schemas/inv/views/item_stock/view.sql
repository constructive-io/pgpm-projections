-- Verify: schemas/inv/views/item_stock/view


SELECT 1/(CASE WHEN to_regclass('inv.item_stock') IS NOT NULL THEN 1 ELSE 0 END);


