/* Создаём вводные данные */
CREATE TABLE txn
(txn_id SMALLINT UNSIGNED AUTO_INCREMENT,
txn_date DATE,
accounr_id SMALLINT,
txn_type_cd VARCHAR(20),
amount FLOAT,
CONSTRAINT pk_tsn PRIMARY KEY (txn_id)
);

INSERT INTO txn
(txn_id, txn_date, accounr_id, txn_type_cd, amount)
VALUES 
(null, '2005-02-22', 101, 'CDT', 1000),
(null, '2005-02-23', 102, 'DBT', 525.75),
(null, '2005-02-24', 101, 'DBT', 100),
(null, '2005-02-24', 103, 'CDT', 55),
(null, '2005-02-25', 101, 'DBT', 50),
(null, '2005-02-25', 103, 'DBT', 25),
(null, '2005-02-25', 102, 'CDT', 125.37),
(null, '2005-02-26', 103, 'DBT', 10),
(null, '2005-02-27', 101, 'CDT', 75);

/* проверим */ 
SELECT * FROM txn;
/* RESULT
+--------+------------+------------+-------------+--------+
| txn_id | txn_date   | accounr_id | txn_type_cd | amount |
+--------+------------+------------+-------------+--------+
|      1 | 2005-02-22 |        101 | CDT         |   1000 |
|      2 | 2005-02-23 |        102 | DBT         | 525.75 |
|      3 | 2005-02-24 |        101 | DBT         |    100 |
|      4 | 2005-02-24 |        103 | CDT         |     55 |
|      5 | 2005-02-25 |        101 | DBT         |     50 |
|      6 | 2005-02-25 |        103 | DBT         |     25 |
|      7 | 2005-02-25 |        102 | CDT         | 125.37 |
|      8 | 2005-02-26 |        103 | DBT         |     10 |
|      9 | 2005-02-27 |        101 | CDT         |     75 |
+--------+------------+------------+-------------+--------+
*/
