-- Verify: schemas/inv/views/item_summary/view


SELECT 1 / (CASE WHEN to_regclass('inv.item_summary') IS NOT NULL THEN 1 ELSE 0 END);


