CREATE TABLE restaurants (
    r_id INT PRIMARY KEY,
    r_name VARCHAR(255),
    cuisine VARCHAR(50)
);

INSERT INTO restaurants (r_id, r_name, cuisine) VALUES
(1, 'Dominos', 'Italian'),
(2, 'KFC', 'American'),
(3, 'Box8', 'North Indian'),
(4, 'Dosa Plaza', 'South Indian'),
(5, 'China Town', 'Chinese');
