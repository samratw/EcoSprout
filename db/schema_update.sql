-- ============================================================
-- EcoSprout - schema update
-- Adds: delivery_location on orders, soft-delete flag on
-- products & orders, and a new reviews table.
-- Run once against the existing ecosprout database.
-- ============================================================

USE ecosprout;

-- Delivery address for each order
ALTER TABLE orders
    ADD COLUMN delivery_location VARCHAR(255) NULL AFTER total_price;

-- Soft-delete flags (no rows are physically removed)
ALTER TABLE orders
    ADD COLUMN is_deleted TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE products
    ADD COLUMN is_deleted TINYINT(1) NOT NULL DEFAULT 0;

-- Reviews + ratings table
CREATE TABLE IF NOT EXISTS reviews (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    product_id  INT NOT NULL,
    buyer_id    INT NOT NULL,
    rating      TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    is_deleted  TINYINT(1) NOT NULL DEFAULT 0,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_reviews_buyer   FOREIGN KEY (buyer_id)   REFERENCES users(id),
    INDEX idx_reviews_product (product_id),
    INDEX idx_reviews_buyer   (buyer_id)
);
