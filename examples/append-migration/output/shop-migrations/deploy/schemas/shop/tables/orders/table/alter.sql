-- Deploy: schemas/shop/tables/orders/table/alter
-- made with <3 @ constructive.io

-- requires: schemas/shop/tables/orders/indexes/idx_orders_placed_at/drop


ALTER TABLE shop.orders DROP CONSTRAINT orders_status_check RESTRICT;
ALTER TABLE shop.orders ADD CONSTRAINT orders_status_check CHECK (status IN ('pending', 'paid', 'shipped', 'cancelled', 'refunded'));

