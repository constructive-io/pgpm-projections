-- Verify: schemas/inv/procedures/restock/procedure


SELECT 1 / (CASE WHEN to_regprocedure('inv.restock(int, int)') IS NOT NULL THEN 1 ELSE 0 END);


