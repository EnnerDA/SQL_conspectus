# ***   SQL Conspectus   ***
## Начало работы.
`$ mysql -u root -p` ввел без пароля,

Затем создаю нового пользоватля `ennerda` с паролем 123456
```mysql
GRANT ALL PRIVILEGES ON *.* TO ennerda@localhost
->     IDENTIFIED BY '123456' WITH GRANT OPTION;					
```
Затем выхожу из сеанса командой `quit`. И заново захожу но уже как пользователь ennerda
```$
$ mysql-u ennerda -p
```
Создадим БД с названием "probabase".
```mysql
create database probabase;
```
Теперь выбираем нашу БД
```mysql
use probabase;
```
Подгрузим тестовые данные. 
```mysql
source C:\Users\1\LearningSQLExample.sql
```

Теперь при входе мы можем не только выбирать пользователя, но и сразу указывать какую БД мы планируем использовать.
```
$ mysql -u ennerda -p probabase
```
Для просмотра всех созданных пользователей вводим
```mysql
 mysql> SELECT user FROM mysql. user;
 ```
 Для просмотра всех созданных баз
```mysql
 mysql> SHOW databases;
 ```
 После выбора базы можем посмотреть все таблицы в ней
```mysql
mysql> SHOW tables;
 ```
 
## Типы данных MySQL.
### Символьные данные.

Строки фиксированной длины дополняются справа пробелами, строки переменной длины - нет.
```mysql
CHAR(20) /* строка фиксированной длины */ 	
VARCHAR(20) /* строка переменной длины */
```
Команда `SHOW CHARACTER SET;` покажет поддерживаемые таблицы символов (кодировки), если что наша *cp866 DOS Russian*.

Текстовые типы данных в MySQL
|**Тип**   |**Максимальное число символов**|
|:---------|:------------------------------|
|Tinytext  |255                            |
|Text      |65 535                         |
|Mediumtext|16 777 215                     |
|Longtext  |4 294 967 295                  |

Если размер данных, загружаемых в текстовый столбец, превышает максимальный размер для этого типа, непоместившиеся данные отсекаются.

В отличие от столбца типа varchar, при загрузке данных в такой столбец пробелы в конце строки не удаляются.

### Числовые данные.

Целые типы данных  MySQL
|**Тип**   |**Диапазон значений со знаком**|**Диапазон значений без знака**|
|:---------|:------------------------------|:------------------------------|
|Tinyint   |от -128 до 127                 |от 0 до 255                    |
|Smallint  |от -32 768 до 32 767           |от 0 до 65 535                 |
|Mediumint |от -8 388 608 до 8 388 607     |от 0 до 16 777 215             |
|int       |умножь предыдущее на 256       |от 0 до ты знаешь что делать   |
|Bigint    |огроменное число               | 18 квинтиллионов (10\*\*18)   |

Типы данных с плавающей точкой  MySQL
|**Тип**    |**Числовой диапазон**
|:----------|:------------------------------|
|Float(p,s) |от 3,4E+38 до -1,7E-38         |
|Double(p,s)|от 1,7E+308 до -2,2E-308       |

Точность (precision) (общее допустимое число разрядов, как справа, так и слева от десятичной точки) и масштаб (scale) (допустимое число разрядов справа от десятичной точки), но эти параметры не являются обязательными.
 
float(4,2), будет сохранять всего четыре разряда, два слева и два справа от десятичной точки. ПНапример 27,44 и 8,19, а вот число 17,8675 будет округлено до 17,87, а число 178,5 будет округлено (грубо) до 99,99 – самое 	
большое число, которое может быть сохранено в этом столбце.

### Временны́е данные (temporal).	

|**Тип**   |**Формат по умолчанию**        |**Допустимые значения**                      |
|:---------|:------------------------------|:--------------------------------------------|
|Date      |YYYY-MM-DD                     |от 1000-01-01 до 9999-12-31                  |
|Datetime  |YYYY-MM-DDHH:MI:SS             |от 1000-01-01 00:00:00 до 9999-12-31 23:59:59|
|Timestamp |YYYY-MM-DDHH:MI:SS             |от 1000-01-01 00:00:00 до 9999-12-31 23:59:59|
|Year      |YYYY                           |от 1901 до 2155                              |
|Time      |HHH:MI:SS                      |от -838:59:59 до 838:59:59                   |

## Создание таблиц.
Хотим создать в MySQL таблицу *Person*.
|**Столбец**|**Тип**            |**Допустимые значения**|
|:----------|:------------------|:----------------------|
|Person_id  |Smallint (unsigned)|                       |
|First_name |Varchar(20)        |                       |
|Last_name  |Varchar(20)        |                       |
|Gender     |Char(1)            |M, F                   |
|Birth_date |Date               |                       |
|Street     |Varchar(30)        |                       |
|City       |Varchar(20)        |                       |
|State      |Varchar(20)        |                       |
|Country    |Varchar(20)        |                       |
|Postal-code|Varchar(20)        |                       |

и таблицу *Favorite_food*
|**Столбец**|**Тип**            |
|:----------|:------------------|
|Person_id  |Smallint (unsigned)|
|Food       |Varchar(20)        |


Пишем SQL-выражение
```mysql
mysql> CREATE TABLE person
    -> (person_id SMALLINT UNSIGNED,
    -> fname VARCHAR(20),
    -> lname VARCHAR(20),
    -> gender CHAR(1),
    -> birth_date DATE,
    -> address VARCHAR(30),
    -> city VARCHAR(20),
    -> state VARCHAR(20),
    -> country VARCHAR(20),
    -> postal_code VARCHAR(20),
    -> CONSTRAINT pk_person PRIMARY KEY (person_id)
    -> );
Query OK, 0 rows affected (0.01 sec)
```
Что бы убедиться что таблица создалась введем `DESC person;`.

![изображение](https://user-images.githubusercontent.com/116806816/215477756-619b6190-512b-4755-ba03-bac8e5f02888.png)

```mysql
CREATE TABLE favorite_food
(person_id SMALLINT UNSIGNED,
food VARCHAR(20),
CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES person (person_id)
);
```
В конструкторе таблиц стоит обратить внимание на последние строчки 
```mysql
CONSTRAINT pk_person PRIMARY KEY (person_id)
``` 
и
```musql
CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES person (person_id)
```
**CONSTRAINT** - это *ограничение*. Бывают нескольких типов:
* **CONSTRAINT PRIMARY KEY** - *ограничение первичного ключа* накладывается на столбец (`person_id`) и получает имя *pk_person*. Автор советует в случае ограничения первичного ключа давать имя pk (primary key) нижнее подчеркивание и имя таблицы. 
* **CONSTRAINT FOREIGN KEY** - *ограничение внешнего ключа*, ограничивает значения столбца *person_id* таблицы *favorite_food* позволяя ему включать только те значения, которые есть в в столбце *person_id* таблицs *person*. Еще раз синтаксис:
```mysql
CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES person (person_id)
```
Оператор **`alter table`** - позволяет внести извенения в таблицу после ее создания. Пример видимо будет позже.

## Заполнение и изменение таблиц.
Будут изучены основные SQL-выражения для работы: **`insert`**, **`update`**, **`delete`**, **`select`**.
### Вставка данных. `isnert`
Для начала внесём изменения в столбец *`person_id`* таблицы *`person`* 
```MYSQL
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
```
`ALTER TABLE` - оператор сообщающий, что мы вносим изменение в таблицу.

`MODIFY` - сообщает, что меняет уже существующие столбцы таблицы.

`AUTO_INCREMENT` - автоматическое приращение. Доступно в MySQL. 

Таким образом мы задали алогритм для автоматического заполнения первичного ключа, теперь можно перейти к наполнению таблицы.

Создадим господина William Turner.
```mysql
mysql> INSERT INTO person
    -> (person_id, fname, lname, gender, birth_date)
    -> VALUES (null, 'William', 'Turner', 'M', '1972-05-27');
    -> Query OK, 1 row affected (0.01 sec)	
Query OK, 1 row affected (0.01 sec)
```
Проверим добавленные данные
```mysql
SELECT person_id, fname, lname, gender, birth_date
FROM person;
```
![изображение](https://user-images.githubusercontent.com/116806816/215682327-da944dd2-2433-49d6-b829-7eaee5883c23.png)

Если потребуется извлечь не все строки таблицы то внесем уточнение
```mysql
SELECT person_id, fname, lname, gender, birth_date
FROM person;
WHERE person_id = 1;
```
Добавим любимые блюда Вильяма
```mesql
mysql> INSERT INTO favorite_food (person_id, food)
    -> VALUES(1, 'pizza');
Query OK, 1 row affected (0.03 sec)
mysql> INSERT INTO favorite_food (person_id, food)
    -> VALUES(1, 'cookies');
Query OK, 1 row affected (0.01 sec)   
mysql> INSERT INTO favorite_food (person_id, food)
    -> VALUES(1, 'nachos');
Query OK, 1 row affected (0.00 sec)
```
Посмотрим результаты
```mysql
SELECT food FROM favorite_food
WHERE person_id = 1
ORDER BY food;
```
`ORDER BY` - сортировать по...

Добавили еще данных

![изображение](https://user-images.githubusercontent.com/116806816/215688480-85bb2ea5-ede8-4a42-a50c-c71bc2d2c6a0.png)

### Обновление данных. `UPDATE` `SET`.
```mysql
UPDATE person
SET address = '1225 Tremont St.',
city = 'Boston',
state = 'MA',
country = 'USA',
postal_code = '02138'
WHERE person_id = 1;
```

### Удаление данных. `DELETE`.
```mysql
DELETE FROM person
WHERE person_id = 2;
```
Далее работает с базой из приложения к учебнику

![изображение](https://user-images.githubusercontent.com/116806816/215732967-9ea157d9-989b-4000-bf16-277e2331884f.png)

## Азбука запросов.
Выражения SELECT может состоять из нескольких блоков из 6 доступных.
| **Блок** |**Назначение**                                                     |
|:---------|:------------------------------------------------------------------|
| SELECT   |Определяет столбцы для включения в результирующий набор            |
| FROM     |указывает таблицы из которых берем данные                          |
| WHERE    |Ограничивает число строк в окончательном наборе                    |
| GROUP BY |Используется для группировки строк по одинаковым значениям столбцов|
| HAVING   |Ограничивает число строк в окончательном результирующем наборе с помощью группировки данных|
| ORDER BY |Сортирует окончательный набор по выбранным столбцам                |

**Блок `SELECT`** помимо названия столбцов может содержать:
* Литералыб например числа или строки
* Выражения, например transaction.amount*-1
* Вызовы встроенных функций, например ROUND(transaction.amount, 2)
```mysql
mysql> SELECT name,
    -> 'active',   /* литералы  */
    -> dept_id*7,  /* выражения */
    -> UPPER(name) /* функции   */
    -> FROM department;
```
```$
+----------------+--------+-----------+----------------+
| name           | active | dept_id*7 | upper(name)    |
+----------------+--------+-----------+----------------+
| Operations     | active |         7 | OPERATIONS     |
| Loans          | active |        14 | LOANS          |
| Administration | active |        21 | ADMINISTRATION |
+----------------+--------+-----------+----------------+
3 rows in set (0.00 sec)
```
Добавим свои нащзвания к столбцам итгового набора
```mysql
mysql> SELECT name,
    -> 'active' status,
    -> dept_id*7 enyname,
    -> UPPER(name) uppername 
    -> FROM department;
```
```$
+----------------+--------+---------+----------------+
| name           | status | enyname | uppername      |
+----------------+--------+---------+----------------+
| Operations     | ACTIVE |       7 | OPERATIONS     |
| Loans          | ACTIVE |      14 | LOANS          |
| Administration | ACTIVE |      21 | ADMINISTRATION |
+----------------+--------+---------+----------------+
3 rows in set (0.00 sec)
```
Если необходимо исключить повторяющиеся зеначения, то вводим ключенвое слово *`DISTNCT` (отличный от остальных)* после `SELECT`.
```mysql
SELECT DISTINCT cust_id
FROM account;
```

**Блок `FROM`**
Блок from определяет таблицы, используемые запросом, а также ***средства связывания таблиц.***
Таблицы бывают трех видов:
1. Постоянные таблицы (т.е. созданные с помощью выражения `create table`)
2. Временные таблицы (т.е. строки возвращенные подзапросом)
```mysql
mysql> SELECT e.emp_id, e.fname, e.lname /* основный запрос (containing query) */
    -> FROM (SELECT emp_id, fname, lname, start_date, title /* из подзапроса (subquery) */
    -> FROM employee) e;	/* e - псевдоним подзапроса */
```
3. Виртуальные таблицы (представления) (т.е. созданные с помощью выражения `create view`)
не поддерживаются MySQL до 5.0.1. Но отличная статья [тут](https://habr.com/ru/post/47031/)

**Связи таблиц**
```mysql
mysql> SELECT employee.emp_id, employee.fname, /* имена столбцов указываются с приставкой имени таблицы */
    -> employee.lname, department.name dept_name /* столбец department.name будет под псевдонимом dept_name*/
    -> FROM employee INNER JOIN department /* JOIN связывает таблицы */
    -> ON employee.dept_id = department.dept_id; /* подблок ON определяет условия связывания */
```

`employee.emp_id` и `employee.fname` это полные имена (с приставкой), но можно их указывать иначе, через псевдонимы определяемые в блоке `FROM`.
Попробуем применить это посмотрев кадровую структуру нашего банка:
```mysql
mysql> SELECT DISTINCT e.title Post,d.name Name /* напомню DISTINCT убирает повторы */
    -> FROM employee e INNER JOIN department d
    -> ON e.dept_id = d.dept_id;
```
```$
+--------------------+----------------+
| Post               | Name           |
+--------------------+----------------+
| Operations Manager | Operations     |
| Head Teller        | Operations     |
| Teller             | Operations     |
| Loan Manager       | Loans          |
| President          | Administration |
| Vice President     | Administration |
| Treasurer          | Administration |
+--------------------+----------------+
7 rows in set (0.00 sec)
```
**Блок `WHERE`**

Блок `WGERE` – это механизм отсеивания нежелательных строк из результирующего набора.
Задача такова: в результирующий набор должны попасть только те сотрудники, которые являются старшими операционистами (Head Teller) и начали работать в компании позже 1 января 2002 года, или простые операционисты (Teller), начавшие работать после 1 января 2003 года:	
```mysql
mysql> SELECT emp_id, fname, lname, start_date, title
    -> FROM employee
    -> WHERE (title = 'Head Teller' AND start_date > '2002-01-01') /* применяетм операторы AND, OR и NOT*/
    -> OR (title = 'Teller' AND start_date > '2003-01-01'); /*условия группируются круглыми скобками*/
```
```$
+--------+----------+---------+------------+-------------+
| emp_id | fname    | lname   | start_date | title       |
+--------+----------+---------+------------+-------------+
|      6 | Helen    | Fleming | 2004-03-17 | Head Teller |
|      7 | Chris    | Tucker  | 2004-09-15 | Teller      |
|     10 | Paula    | Roberts | 2002-07-27 | Head Teller |
|     12 | Samantha | Jameson | 2003-01-08 | Teller      |
|     15 | Frank    | Portman | 2003-04-01 | Teller      |
+--------+----------+---------+------------+-------------+
```
**Блоки `GROUP BY` и `HAVING`**

будут попожее, типа сложные.

**Блок `ORDER BY`**

Блок ORDER BY – это механизм сортировки результирующего набора на основе данных столбцов, или выражений, использующих данные столбцов. 

Блок мождет содержить иерархию по которой стоит проводить сортировку.
```mysql
mysql> SELECT open_emp_id, product_cd
    -> FROM account
    -> ORDER BY open_emp_id, product_cd;
```
Результат будеьт отсортирован сначала по `open_emp_id` а внутри их одинаковых значений сортируется дополнительно по `product_cd`. Идеальный порядочек!

При сортировке можно задать порядок по возрастанию (*ascending*) или по убыванию (*descending*) с помощью ключевых слов `ASC` и `DESC`. 
По умолчанию выполняется сортировка по возрастанию, поэтому добавлять придется только ключевое слово `DESC` – если требуется сортировка по убыванию.	
```mysql
mysql> SELECT account_id, product_cd, open_date, avail_balance
    -> FROM account
    -> ORDER BY avail_balance DESC, open_date
    -> LIMIT 5;
```
```$
+------------+------------+------------+---------------+
| account_id | product_cd | open_date  | avail_balance |
+------------+------------+------------+---------------+
|         24 | SBL        | 2004-02-22 |      50000.00 |
|         23 | CHK        | 2003-07-30 |      38552.05 |
|         20 | CHK        | 2002-09-30 |      23575.12 |
|         13 | CD         | 2004-12-28 |      10000.00 |
|         22 | BUS        | 2004-03-22 |       9345.55 |
+------------+------------+------------+---------------+
```
**Сортировка с помощью выражений**
Например, требуется сортировать данные клиентов по последним трем разрядам их федерального ID (столбец fed_id в таблице  customer).
```mysql
mysql> SELECT cust_id, city, state, fed_id
    -> FROM customer
    -> ORDER BY RIGHT(fed_id, 3);
```
```$
+---------+------------+-------+-------------+
| cust_id | city       | state | fed_id      |
+---------+------------+-------+-------------+
|       1 | Lynnfield  | MA    | 111-11-1111 |
|      10 | Salem      | NH    | 04-1111111  |
|       2 | Woburn     | MA    | 222-22-2222 |
|      11 | Wilmington | MA    | 04-2222222  |
|       3 | Quincy     | MA    | 333-33-3333 |
|      12 | Salem      | NH    | 04-3333333  |
|      13 | Quincy     | MA    | 04-4444444  |
|       4 | Waltham    | MA    | 444-44-4444 |
|       5 | Salem      | NH    | 555-55-5555 |
|       6 | Waltham    | MA    | 666-66-6666 |
|       7 | Wilmington | MA    | 777-77-7777 |
|       8 | Salem      | NH    | 888-88-8888 |
|       9 | Newton     | MA    | 999-99-9999 |
+---------+------------+-------+-------------+
```
Используется функция `RIGHT()`, которая извлекает последние 3 символа значения столбца `fed_id` итоговый вывод сортируется на основании результата функции `RIGHT()`.

**Сортировка с помощью числовых заместителей**
При сортировке с использованием столбцов, перечисленных в блоке `SELECT`, можно ссылаться на столбцы не по имени, а по их порядковому номеру. Например, если требуется выполнить сортировку по второму или пятому столбцу, возвращаемому запросом, можно сделать следующее:
```mysql
mysql> SELECT emp_id, title, start_date, fname, lname 	
     > FROM employee 	
     > ORDER BY 2, 5;
```
Но будем чеснтны способ сомнительный. Не стоит так делать ибо не явно!

[Упражнения главы 3](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises.sql)

## Глава 4. Фильтрация.
Пример применения состовной фильтрации с оператором IN и NOT
```mysql
WHERE end_date IS NULL
AND NOT (title = 'Teller' OR start_date < '2003-01-01')
```
Запись равносильна следующей (внимание на синтаксис)
```mysql
WHERE end_date IS NULL
AND title != 'Teller' OR start_date >= '2003-01-01')
```
Второй вариант предпочтительней так как каждое условие полностью описано входящими в него литералами и не требуется возвращаться в начало строки за уточнениями логических условий.

В числе операторов сравнения есть: `=`, `!=`, `<`, `>`, `<>`, `LIKE`, `IN` и `BETWEEN`:
А качестве условий равенства могут быть выражение:
```mysql
WHERE dept_id = (SELECT dept_id FROM department WHERE name = 'Loans')	
```
### `<>`
Похоже `<>` соответствует `!=`
### `BEETWEN`
`BEETWEN` используют для оценки диапазона
``` mysql
WHERE start_date < '2003-01-01' 	
AND start_date >= '2001-01-01';	
```
Можно записать
```mysql
WHERE start_date BEETWEN '2001-01-01' AND '2003-01-01'
```
Важно помнить, что при использовании `BETWEEN` сначала указывается нижний предел а после оператора `AND` верхний. И обе две границы всегда включаются в диапазон. Запись неявная литералы >,<,= как то поприятнее.

Диапазоны могут быть и строковыми!
### `IN`
`IN` для оценки вхождения значения в список. Например нам нужны все счета с кодами: 'CHK', 'SAV', 'CD' или 'MM'. Можем записать условие через три оператора `OR`:
```mysql
WHERE product_cd = 'CHK' OR product_cd = 'SAV' OR product_cd = 'CD' OR product_cd = 'MM';
```
Либо можем записать через вхождение в перечень и оператор `IN`:
```mysql
WHERE product_cd IN ('CHK', 'SAV', 'CD', 'MM');
```
Можем поместить `IN` в подзапрос
```mysql
WHERE product_cd IN (SELECT product_cd from product
    WHERE product_type_cd = 'ACCOUNT')
 ```
НУ можем и отсутсвие вхождение в перечень посмотреть используя `NOT IN`

### `LIKE`. Символы маски.
При поиске частичных соответствий строк интерес могут вызвать:
* Строки, начинающиеся/заканчивающиеся определенным символом 	
* Строки, начинающиеся/заканчивающиеся подстрокой 	
* Строки, содержащие определенный символ в любом месте строки 	
* Строки, содержащие подстроку в любом месте строки 	
* Строки определенного формата, независимо от входящих в них от	дельных символов

Можем построить выражение для поиска с помощью символов маски:
|**Символ маски**         |**Соответствие**|
|:------------------------|:---------------|
| _ (нижнее подчеркивание)| Точно один символ|
|%                        |Любое число символов (в том числе и ни одного)|

Примеры:
```mysql
/*вторая буква 'a' и дальше есть 'e' */
SELECT lname FROM employee
WHERE lname LIKE '_a%e%';

/* ну или соответсвует формату */
SELECT cust_id, fed_id FROM customer
WHERE fed_id LIKE '___-__-____';

/* начинается либо с 'F' либо с 'G' */
SELECT emp_id, fname, lname FROM employee
WHERE lname LIKE 'F%' OR lname LIKE 'G%';
```





