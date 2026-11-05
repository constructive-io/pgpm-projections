-- Deploy: schemas/inv/tables/warehouse/table
-- made with <3 @ constructive.io




CREATE TABLE inv.warehouse (
  id int CONSTRAINT warehouse_pkey PRIMARY KEY,
  code text NOT NULL CONSTRAINT warehouse_code_key UNIQUE,
  main_item_id int
);

ALTER TABLE inv.warehouse 
  ADD CONSTRAINT warehouse_main_item_fk
    FOREIGN KEY(main_item_id)
    REFERENCES inv.item (id);

