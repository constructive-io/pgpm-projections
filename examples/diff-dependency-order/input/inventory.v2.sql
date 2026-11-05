CREATE SCHEMA inv;

CREATE TABLE inv.warehouse (
  id int PRIMARY KEY,
  code text NOT NULL UNIQUE,
  main_item_id int
);

CREATE TABLE inv.item (
  id int PRIMARY KEY,
  name text NOT NULL,
  qty bigint NOT NULL DEFAULT 0,
  warehouse_id int REFERENCES inv.warehouse (id)
);

ALTER TABLE inv.warehouse
  ADD CONSTRAINT warehouse_main_item_fk FOREIGN KEY (main_item_id) REFERENCES inv.item (id);

CREATE INDEX item_warehouse_idx ON inv.item (warehouse_id);

CREATE VIEW inv.item_summary AS
  SELECT i.id, i.name, i.warehouse_id FROM inv.item i;

CREATE VIEW inv.item_stock AS
  SELECT i.id, i.qty FROM inv.item i;

CREATE VIEW inv.warehouse_stock AS
  SELECT w.code, sum(i.qty) AS qty
  FROM inv.warehouse w
  LEFT JOIN inv.item i ON i.warehouse_id = w.id
  GROUP BY w.code;

CREATE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $$
  SELECT count(1) FROM inv.item
$$;

CREATE FUNCTION inv.restock(item_id int, amount int) RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  UPDATE inv.item SET qty = qty + amount WHERE id = item_id;
END
$$;
