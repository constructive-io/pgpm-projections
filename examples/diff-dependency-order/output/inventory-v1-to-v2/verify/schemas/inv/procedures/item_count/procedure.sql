-- Verify: schemas/inv/procedures/item_count/procedure


SELECT 1 / (CASE WHEN to_regprocedure('inv.item_count()') IS NOT NULL THEN 1 ELSE 0 END);


