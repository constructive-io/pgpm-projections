-- Deploy: schemas/inv/tables/item/table
-- made with <3 @ constructive.io

-- requires: schemas/inv/schema


CREATE TABLE inv.item (
  id int PRIMARY KEY,
  name text NOT NULL,
  qty int NOT NULL DEFAULT 0,
  legacy_code text
);

