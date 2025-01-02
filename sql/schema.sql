-- Схема базы данных

-- Таблица для хранения метаданных медиафайлов
CREATE TABLE IF NOT EXISTS media_metadata
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    link VARCHAR UNIQUE NOT NULL
);

-- Таблица для хранения информации о маркетплейсах
CREATE TABLE IF NOT EXISTS marketplaces
(
    id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name    VARCHAR UNIQUE NOT NULL,
    link    VARCHAR UNIQUE NOT NULL,
    logo_id BIGINT REFERENCES media_metadata (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Таблица для хранения информации о товарах
CREATE TABLE IF NOT EXISTS products
(
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    marketplace_id BIGINT REFERENCES marketplaces (id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    name           VARCHAR,
    is_adult_only  BOOLEAN,
    link           VARCHAR UNIQUE                                                          NOT NULL,
    image_id       BIGINT REFERENCES media_metadata (id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Таблица для хранения истории цен
CREATE TABLE IF NOT EXISTS prices_history
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id BIGINT REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    price      DECIMAL(12, 2)                                                      NOT NULL,
    date       TIMESTAMP WITH TIME ZONE                                            NOT NULL
);

-- Таблица для хранения информации о пользователях
CREATE TABLE IF NOT EXISTS users
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR        NOT NULL,
    last_name  VARCHAR        NOT NULL,
    email      VARCHAR UNIQUE NOT NULL
);

-- Таблица для хранения товаров пользователей
CREATE TABLE IF NOT EXISTS users_products
(
    user_id    BIGINT REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id BIGINT REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE,

    PRIMARY KEY (user_id, product_id)
);
