CREATE TABLE foods (
    f_id INT PRIMARY KEY,
    f_name VARCHAR(255),
    type VARCHAR(50)
);

INSERT INTO foods (f_id, f_name, type) VALUES
(1, 'Non-veg Pizza', 'Non-veg'),
(2, 'Veg Pizza', 'Veg'),
(3, 'Choco Lava cake', 'Veg'),
(4, 'Chicken Wings', 'Non-veg'),
(5, 'Chicken Popcorn', 'Non-veg'),
(6, 'Rice Meal', 'Veg'),
(7, 'Roti meal', 'Veg'),
(8, 'Masala Dosa', 'Veg'),
(9, 'Rava Idli', 'Veg'),
(10, 'Schezwan Noodles', 'Veg'),
(11, 'Veg Manchurian', 'Veg');
