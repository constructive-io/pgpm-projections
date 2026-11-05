-- Verify: schemas/inv/tables/item/table/alter


SELECT 1 / (CASE WHEN EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'item' AND column_name = 'warehouse_id' AND table_schema = 'inv') THEN 1 ELSE 0 END);

SELECT 1 / (CASE WHEN EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name = 'item' AND constraint_name = 'item_warehouse_id_fkey' AND table_schema = 'inv') THEN 1 ELSE 0 END);


