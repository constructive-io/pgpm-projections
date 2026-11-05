DROP VIEW inv.item_stock;

DROP TABLE inv.retired;

CREATE OR REPLACE FUNCTION inv.item_count() RETURNS bigint LANGUAGE sql STABLE AS $EOFCODE$
  SELECT count(1) FROM inv.item
$EOFCODE$;

CREATE TABLE inv.warehouse (
  id int CONSTRAINT warehouse_pkey PRIMARY KEY,
  code text NOT NULL CONSTRAINT warehouse_code_key UNIQUE,
  main_item_id int
);

ALTER TABLE inv.warehouse 
  ADD CONSTRAINT warehouse_main_item_fk
    FOREIGN KEY(main_item_id)
    REFERENCES inv.item (id);

ALTER TABLE inv.item 
  ADD COLUMN warehouse_id int;

ALTER TABLE inv.item 
  ADD CONSTRAINT item_warehouse_id_fkey
    FOREIGN KEY(warehouse_id)
    REFERENCES inv.warehouse (id);

DROP VIEW inv.item_summary;

CREATE VIEW inv.item_summary AS SELECT
  i.id,
  i.name,
  i.warehouse_id
FROM inv.item AS i;

ALTER TABLE inv.item 
  DROP COLUMN legacy_code RESTRICT;

ALTER TABLE inv.item 
  ALTER COLUMN qty TYPE bigint USING CAST(qty AS bigint);

CREATE VIEW inv.item_stock AS SELECT
  i.id,
  i.qty
FROM inv.item AS i;

CREATE INDEX item_warehouse_idx ON inv.item (warehouse_id);

CREATE VIEW inv.warehouse_stock AS SELECT
  w.code,
  sum(i.qty) AS qty
FROM inv.warehouse AS w
LEFT JOIN inv.item AS i ON i.warehouse_id = w.id
GROUP BY
  w.code;

CREATE FUNCTION inv.restock(
  item_id int,
  amount int
) RETURNS void LANGUAGE plpgsql AS $EOFCODE$
BEGIN
  UPDATE inv.item SET qty = qty + amount WHERE id = item_id;
END
$EOFCODE$;
