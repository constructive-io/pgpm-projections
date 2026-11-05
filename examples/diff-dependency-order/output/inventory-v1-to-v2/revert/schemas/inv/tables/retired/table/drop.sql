-- Revert: schemas/inv/tables/retired/table/drop


CREATE TABLE inv.retired (
  id int PRIMARY KEY,
  item_id int REFERENCES inv.item (id)
);


