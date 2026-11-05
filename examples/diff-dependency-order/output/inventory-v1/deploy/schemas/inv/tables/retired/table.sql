-- Deploy: schemas/inv/tables/retired/table
-- made with <3 @ constructive.io

-- requires: schemas/inv/schema
-- requires: schemas/inv/tables/item/table


CREATE TABLE inv.retired (
  id int PRIMARY KEY,
  item_id int REFERENCES inv.item (id)
);

