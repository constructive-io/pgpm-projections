-- Verify: schemas/inv/tables/retired/table


SELECT 1/(CASE WHEN to_regclass('inv.retired') IS NOT NULL THEN 1 ELSE 0 END);


