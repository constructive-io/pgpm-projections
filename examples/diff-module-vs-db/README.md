# diff-module-vs-db — mixed sides (a module vs a live database)

**Input:** [the v1 pgpm module](../import-dump/output/shop) vs a **live database** loaded from [`shop.v2.sql`](../diff-migration/input/shop.v2.sql).

**Output:** [`output/shop-module-vs-db/`](output/shop-module-vs-db) — the same 7-change delta as the module-vs-module diff in [diff-migration](../diff-migration), change for change.

```sh
psql -c 'CREATE DATABASE live_v2' && psql -d live_v2 -f examples/diff-migration/input/shop.v2.sql
pgpm diff examples/import-dump/output/shop db:live_v2 \
  --emit-migration examples/diff-module-vs-db/output --pkg shop-module-vs-db --allow-data-loss --verify
```

Both sides normalize to the same identity-keyed model regardless of where they came from: type spellings (`integer`/`int4`, `timestamp with time zone`/`timestamptz`), the casts pg_dump adds to defaults (`'x'::text`, `nextval('s'::regclass)`), the column attributes it emits as separate `ALTER TABLE` commands (`SET DEFAULT`, `SET NOT NULL`, `ADD GENERATED .. AS IDENTITY`), restated sequence defaults, `WITH NO DATA` and `FOR ROLE <current role>` are representation, not semantics. `--allow-data-loss` is required because v2 drops `shop.customers.phone`; `--verify` deploys v1 plus the delta and replays the live database's dump into scratch databases and compares the catalogs.

Known remaining asymmetry: `serial` columns (the module has no sequence object where the catalog has one) and `SELECT *` views (the catalog stores the expanded column list).
