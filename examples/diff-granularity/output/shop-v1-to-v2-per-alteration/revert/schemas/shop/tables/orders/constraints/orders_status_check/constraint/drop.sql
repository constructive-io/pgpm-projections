-- Revert: schemas/shop/tables/orders/constraints/orders_status_check/constraint/drop


ALTER TABLE shop.orders ADD CONSTRAINT orders_status_check CHECK (status IN ('pending', 'paid', 'shipped', 'cancelled'));


