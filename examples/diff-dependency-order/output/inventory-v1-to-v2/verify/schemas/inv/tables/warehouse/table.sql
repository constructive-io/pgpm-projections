-- Verify: schemas/inv/tables/warehouse/table


SELECT 1 / (CASE WHEN to_regclass('inv.warehouse') IS NOT NULL THEN 1 ELSE 0 END);

SELECT 1 / (CASE WHEN EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name = 'warehouse' AND constraint_name = 'warehouse_main_item_fk' AND table_schema = 'inv') THEN 1 ELSE 0 END);


