-- Deploy: schemas/shop/tables/orders/constraints/orders_status_check/constraint/drop
-- made with <3 @ constructive.io

-- requires: schemas/shop/tables/orders/indexes/idx_orders_placed_at/drop


ALTER TABLE shop.orders DROP CONSTRAINT orders_status_check RESTRICT;

