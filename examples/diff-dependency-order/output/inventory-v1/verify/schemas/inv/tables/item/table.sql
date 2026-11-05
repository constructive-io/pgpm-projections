-- Verify: schemas/inv/tables/item/table


SELECT 1/(CASE WHEN to_regclass('inv.item') IS NOT NULL THEN 1 ELSE 0 END);


