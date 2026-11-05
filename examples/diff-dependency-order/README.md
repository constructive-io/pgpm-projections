# diff-dependency-order — every undeployed change in real dependency order

**Input:** [`output/inventory-v1/`](output/inventory-v1) ([`inventory.v1.sql`](input/inventory.v1.sql) imported as a module) vs [`input/inventory.v2.sql`](input/inventory.v2.sql). The v2 delta touches an existing table and everything around it at once:

- `inv.item` gains `warehouse_id` (FK to the **new** `inv.warehouse`), loses `legacy_code`, and `qty` changes type `int → bigint`
- `inv.warehouse` is new and points back at `inv.item` (FK cycle between a new table and an existing table's new column)
- new view `warehouse_stock` and index `item_warehouse_idx` use the new column
- `item_summary` is replaced (it stops using `legacy_code`); `item_stock` is unchanged but reads the retyped `qty`
- `item_count()` changes body only; `restock()` is new PL/pgSQL whose body references `inv.item`
- `inv.retired` is dropped

**Output:** [`output/inventory-v1-to-v2/`](output/inventory-v1-to-v2) (the delta as a migration module) and [`output/inventory.v1-to-v2.sql`](output/inventory.v1-to-v2.sql) (the same delta as linear SQL).

```sh
pgpm import examples/diff-dependency-order/input/inventory.v1.sql --pkg inventory-v1 --out examples/diff-dependency-order/output
pgpm import examples/diff-dependency-order/input/inventory.v2.sql --pkg inventory-v2 --out /tmp/ddo
pgpm diff examples/diff-dependency-order/output/inventory-v1 /tmp/ddo/inventory-v2 \
  --emit-migration examples/diff-dependency-order/output --pkg inventory-v1-to-v2 \
  --emit-sql examples/diff-dependency-order/output/inventory.v1-to-v2.sql --verify
```

Drops, `ALTER TABLE` steps, replacements and creates are nodes of one dependency graph; the plan is its topological order and each change's `requires` are its real edges:

```
item_stock/view/drop                       (reads qty, which changes type)
retired/table/drop
item_count/procedure                       CREATE OR REPLACE: same signature, body only
warehouse/table                            new table, FK back to the existing item
item/table/alter      [warehouse/table]    ADD COLUMN warehouse_id + its FK to the new table
item_summary/view     [item/table/alter]   replaced view now reads warehouse_id
item/table/alter-2    [item_stock/view/drop item_summary/view]
                                           DROP COLUMN legacy_code, ALTER qty TYPE: only after
                                           the views that read them are gone
item_stock/view       [item_stock/view/drop item/table/alter-2]
                                           unchanged view, recreated after the type change
item_warehouse_idx    [item/table/alter]
warehouse_stock/view  [warehouse/table item/table/alter item/table/alter-2]
restock/procedure                          PL/pgSQL body references never constrain order
```

The table's alteration is split in two only because an outside change (the view replacement) must sit between its steps. `--verify` deploys v1 plus this migration and v2 fresh into scratch databases and compares the catalogs.

Importing `inventory.v2.sql` shows the same rule on a raw file: `item` references `warehouse` inline and `warehouse` references `item` via `ALTER TABLE ... ADD CONSTRAINT`; the constraint becomes its own change (`warehouse/constraints/warehouse_main_item_fk/constraint`) so both tables order.
