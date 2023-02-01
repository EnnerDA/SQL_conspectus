/* Создаём вводные данные */
/* Создаём таблицу */
CREATE TABLE txn
(txn_id SMALLINT UNSIGNED AUTO_INCREMENT,
txn_date DATE,
account_id SMALLINT,
txn_type_cd VARCHAR(20),
amount FLOAT,
CONSTRAINT pk_tsn PRIMARY KEY (txn_id)
);
/* Заполняем таблицу */
INSERT INTO txn
(txn_id, txn_date, account_id, txn_type_cd, amount)
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
| txn_id | txn_date   | account_id | txn_type_cd | amount |
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

/* 4.1 Какие ID транзакций возвращают следующие условия фильтрации? 	
txn_date < '2005-02-26' AND (txn_type_cd = 'DBT' OR amount > 100)	*/

/* На взгляд ответ: 1,2,3,5,6,7 . Проверим: */
SELECT txn_id from txn 
WHERE txn_date < '2005-02-26' AND (txn_type_cd = 'DBT' OR amount > 100); 
/* RESULT
mysql> SELECT txn_id from txn
    -> WHERE txn_date < '2005-02-26' AND (txn_type_cd = 'DBT' OR amount > 100);
+--------+
| txn_id |
+--------+
|      1 |
|      2 |
|      3 |
|      5 |
|      6 |
|      7 |
+--------+
6 rows in set (0.00 sec)
*/

/* 4.2 Какие ID транзакций возвращают следующие условия фильтрации? 
account_id IN (101,103) AND NOT (txn_type_cd = 'DBT' OR amount > 100) */

/* На взгляд я не хочу смотреть ибо могу проверить кодом: */

SELECT txn_id from txn 
WHERE account_id IN (101,103) AND NOT (txn_type_cd = 'DBT' OR amount > 100); 

/* RESULT
mysql> SELECT txn_id from txn
    -> WHERE account_id IN (101,103) AND NOT (txn_type_cd = 'DBT' OR amount > 100);
+--------+
| txn_id |
+--------+
|      4 |
|      9 |
+--------+
2 rows in set (0.00 sec)
*/

/* Далее используем database bank*/
/* 4.3 Создайте запрос, выбирающий все счета, открытые в 2002 году */
SELECT account_id, open_date
FROM account
WHERE open_date >= '2002-01-01' and open_date <'2003-01-01';
/*RESULT
+------------+------------+
| account_id | open_date  |
+------------+------------+
|          6 | 2002-11-23 |
|          7 | 2002-12-15 |
|         12 | 2002-08-24 |
|         20 | 2002-09-30 |
|         21 | 2002-10-01 |
+------------+------------+
5 rows in set (0.00 sec)
*/

/* 4.4 Создайте запрос, выбирающий всех клиентов физических лиц, второй буквой фамилии которых является буква 'a' и есть 'e' в любой позиции после 'a'. */

SELECT c.cust_id, c.cust_type_cd, i.fname, i.lname
FROM customer c INNER JOIN individual i
ON c.cust_id = i.cust_id
WHERE i.lname LIKE '_a%e%';
/* RESULT 
+---------+--------------+---------+--------+
| cust_id | cust_type_cd | fname   | lname  |
+---------+--------------+---------+--------+
|       1 | I            | James   | Hadley |
|       9 | I            | Richard | Farley |
+---------+--------------+---------+--------+
*/




