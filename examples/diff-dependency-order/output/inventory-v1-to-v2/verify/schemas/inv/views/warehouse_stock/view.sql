-- Verify: schemas/inv/views/warehouse_stock/view


SELECT 1 / (CASE WHEN to_regclass('inv.warehouse_stock') IS NOT NULL THEN 1 ELSE 0 END);


