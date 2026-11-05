CREATE SCHEMA inv;

CREATE TABLE inv.item (
  id int PRIMARY KEY,
  name text NOT NULL,
  qty int NOT NULL DEFAULT 0,
  legacy_code text
);

CREATE TABLE inv.retired (
  id int PRIMARY KEY,
  item_id int REFERENCES inv.item (id)
);

CREATE VIEW inv.item_summary AS
  SELECT i.id, i.name, i.legacy_code FROM inv.item i;

CREATE VIEW inv.item_stock AS
  SELECT i.id, i.qty FROM inv.item i;

CREATE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $$
  SELECT count(*) FROM inv.item
$$;
