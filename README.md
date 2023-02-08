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
|**Тип**     |**Максимальное число символов**|
|:-----------|:------------------------------|
|CHAR/VARCHAR|255                            |
|Tinytext    |255                            |
|Text        |65 535                         |
|Mediumtext  |16 777 215                     |
|Longtext    |4 294 967 295                  |

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
### Регулярные выражения. `REGEXP`.
Объемный инструмент, для самостоятельного изучения если вдруг углублюсь в работу с БД. Но например поиск имен начинающихся с 'F' или 'G' в регулярных выражениях выглядит так:
```mysql
SELECT emp_id, fname, lname FROM employee
WHERE lname REGEXP'^[FG]';
```
Не все БД поддерживают регулярные выражения. Надо уточнять.

### NULL
При работе с NULL необходимо помнить:
* Выражение может быть нулевым (null), но оно никогда не может быть равным нулю. 	
* Два null никогда не равны друг другу. Проверить выражение на значение null можно с помощью оператора 	
`IS NULL`.	
Допустим в таблице есть числовые значения и значение NULLю Запрос типа ` WHERE superior_emp_id != 6;` не выдаст строки с значением NULL, хотя конечно должен был бы. Надо всегда проверять нет ли в столбце значения NULL и если есть устраивать дополнительные фильтры для этих строк.
```mysql
WHERE superior_emp_id != 6 or superior_emp_id IS NULL;
```
[Упражнения Главы 4](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_4.sql)

## Глава 5. Запрос к нескольким таблицам. 
### Декартово произведение.
```mysql
SELECT e.fname, e.lname, d.name 	
FROM employee e JOIN department d;
```
Если не указать связующий столбец для таблиц то получим *декартово произведение* То есть все возможные варианты перестановки. Сложный инструмент для осознаного применения. Вычеркиваем эту опцию.

### Внутренние соединения. `INNER JOIN`
В предидущий код нужно внести информацию о связующем столбце в блоке `ON`.
```mysql
SELECT e.fname, e.lname, d.name 	
FROM employee e JOIN department d;
ON e.dept_id = d.dept_id
```
Если определенное значение столбца dept_id присутствует в одной таблице, но его нет в другой, соединение строк не происходит, и они не включаются в результирующий набор.

Считается что указание типа соединения это верная привычка. Посему писать будем `INNER` 

А если имена столбцов в обеих таблицах совпадают то можем писать вместо блока `ON` - `USING(название столбца)`.
```mysql
SELECT e.fname, e.lname, d.name 	
FROM employee e INNER JOIN department d;
USING (dept_id);
```
### ANSI-синтаксис соединения.
Возможно где-то еще существует старый синтаксис в котором блок `ON` заменен равенством столбцов в блоке `WHERE`.
```mysql
SELECT e.fname, e.lname, d.name 	
FROM employee e, department d;
WHERE e.dept_id = d.dept_id;
```
Но в блоке `WHERE` так же будут прописыватьс условия фильтрации, и получиться что их тяжело отделить от условий соединения. Код становится сложнее, менее читабельным становится.

### Соединение трёх и более таблиц.
Просто добавляется еще один блок `FROM JOIN` а так же подблок `ON`.
```mysql
mysql> SELECT a.account_id, c.fed_id, e.fname, e.lname
    -> FROM account a INNER JOIN customer c
    -> USING(cust_id)
    -> INNER JOIN employee e /* добавляем третью таблицу */
    -> ON a.open_emp_id = e.emp_id /* стыкуем с одной из добавленных */
    -> WHERE c.cust_type_cd = 'B'; /* условия фильтрации */
```
```$
+------------+------------+---------+---------+
| account_id | fed_id     | fname   | lname   |
+------------+------------+---------+---------+
|         20 | 04-1111111 | Theresa | Markham |
|         21 | 04-1111111 | Theresa | Markham |
|         22 | 04-2222222 | Paula   | Roberts |
|         23 | 04-3333333 | Theresa | Markham |
|         24 | 04-4444444 | John    | Blake   |
+------------+------------+---------+---------+
```
### Применение подзапросов
Необходим выбор всех счетов, открытых опытными операционистами (устроились ранее 2003-01-01), в настоящее время работающими в отделении Woburn.
```mysql
SELECT a.account_id, a.cust_id, a.open_date, a.product_cd
FROM account a INNER JOIN
(SELECT emp_id, assigned_branch_id  /* вместо второй таблицы мы вставляем подзапрос */
FROM employee /* в котором отсеиваем не опытных операционисток */
WHERE start_date <= '2003 01 01'
AND (title = 'Teller' OR title = 'Head Teller')) e
ON a.open_emp_id = e.emp_id
INNER JOIN /* добавляем третью таблицу */
(SELECT branch_id /* но оказывается и это подзапрос*/ 
FROM branch
WHERE name = 'Woburn Branch') b /*в котором мы оставляем только отделение Woburn Branch*/
ON e.assigned_branch_id = b.branch_id;
```
### Повторное использование таблицы и Рекурсия.	

Бывают случаи когда одну таблицу приходиться присоединять несколько раз, тогда в каждом блоке `FROM` надо этой таблице присваивать разные псевдонимы.

Например вот часть таблицы employee
```mysql
mysql> select emp_id, fname, lname, title, superior_emp_id from employee
```
```$
+--------+----------+-----------+--------------------+-----------------+
| emp_id | fname    | lname     | title              | superior_emp_id |
+--------+----------+-----------+--------------------+-----------------+
|      1 | Michael  | Smith     | President          |            NULL |
|      2 | Susan    | Barker    | Vice President     |               1 |
|      3 | Robert   | Tyler     | Treasurer          |               1 |
|      4 | Susan    | Hawthorne | Operations Manager |               3 |
|      5 | John     | Gooding   | Loan Manager       |               4 |
|      6 | Helen    | Fleming   | Head Teller        |               4 |
```
Но допустим мы бы хотели увидеть сразу имя фамилию руководителя и не его номер id, тогд мы соединяем таблицу саму с собой:
```mysql
SELECT e.emp_id, e.fname, e.lname, e.title, b.fname BOSS_fname, b.lname BOSS_lname
FROM employee e INNER JOIN employee b
ON e.superior_emp_id = b.emp_id;
```
```$
+--------+----------+-----------+--------------------+------------+------------+
| emp_id | fname    | lname     | title              | BOSS_fname | BOSS_lname |
+--------+----------+-----------+--------------------+------------+------------+
|      2 | Susan    | Barker    | Vice President     | Michael    | Smith      |
|      3 | Robert   | Tyler     | Treasurer          | Michael    | Smith      |
|      4 | Susan    | Hawthorne | Operations Manager | Robert     | Tyler      |
|      5 | John     | Gooding   | Loan Manager       | Susan      | Hawthorne  |
|      6 | Helen    | Fleming   | Head Teller        | Susan      | Hawthorne  |
|      7 | Chris    | Tucker    | Teller             | Helen      | Fleming    |
```
### Экви/неэквисоединения.
Эквисоелинение - когда для соединения двух таблиц значения ключевых столбцов должны совпадать. 

Но можно использовать и неэквисоединения! Например: найти всех сотрудников, принятых в банк в то время, когда предлагалась услуга беспроцентного текущего вклада. Таким образом, дата начала работы сотрудника должна находиться между датами начала и конца этой акции.
```mysql
SELECT e.emp_id, e.fname, e.lname, e.start_date 	
FROM employee e INNER JOIN product p 	
ON e.start_date >= p.date_offered 	
AND e.start_date <= p.date_retired 	
WHERE p.name = 'no-fee checking';	
```
Для соревнований по шахматам среди операционистов создадим турнирную таблицу:
```mysql
select e1.fname, e1.lname, 'VS' vs, e2.fname, e2.lname
from employee e1 INNER JOIN employee e2 
ON e1.emp_id < e2.emp_id
WHERE e1.title = 'Teller' AND e2.title = 'Teller';
```
[Упражнения Главы 5](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_5.sql)

## Глава 6. Работа с множествами.
**UNION** - объединение (для Python `|` )

**INTERSECTION** - пересечение (для Python `&` )

**EXPECT** - разность (для Python `difference` )

Создадим простой однострочный запрос и объединим его с таким же
```mysql
select 1 num, 'xyz' str
union
select 2 num, 'abc' str;
```
```$
+-----+-----+
| num | str |
+-----+-----+
|   1 | xyz |
|   2 | abc |
+-----+-----+
```
### `UNION` и `UNION ALL`
Оператор `UNION ALL` не удаляет повторы и дублирующиеся элементы в Отличае от `UNION`. 
### `INTERSECT`
К сожалению, MySQL версии 4.1 не реализует оператор intersect. А у меня блин именно такая мать ее версия.
### `EXCEPT`
К сожалению, MySQL версии 4.1 не реализует оператор except. А у меня бля именно такая мать ее версия.

Операция `EXCEPT` возвращает первую таблицу за вычетом всех перекрытий со второй таблицей.
```$
Множество А         Множество B    A ECXEPT B
+--------+          +--------+     +--------+
| emp_id |          | emp_id |     | emp_id |
+--------+  EXCEPT  +--------+  =  +--------+ 
|     10 |          |     10 |     |     11 |
|     11 |          |     10 |     |     12 |
|     12 |          +--------+     +--------+  
|     10 |           
|     10 |          
+--------+



Множество А             Множество B    A ECXEPT ALL B
+--------+              +--------+       +--------+
| emp_id |              | emp_id |       | emp_id |
+--------+  EXCEPT ALL  +--------+   =   +--------+ 
|     10 |              |     10 |       |     10 |
|     11 |              |     10 |       |     11 |
|     12 |              +--------+       |     12 |   
|     10 |                               +--------+ 
|     10 |          
+--------+           
```
`EXCEPT` удаляет все экземпляры дублирующихся данных из множества А, тогда как `EXCEPT ALL` удаляет из множества А только один экземпляр дубликата данных для каждого экземпляра дубликата данных множества В.

### Некоторые правила.
* Если есть состовной запрос и его рещультат нужно отсортировать, то в блоке `ORDER BY` должно быть название столбца из первого запроса. Иначе будет ошибка.
* порядок обработки операций СВЕРХУ ВНИЗ!

[Упражнения главы 6](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_6.sql)

## Глава 7. Создание, преобразование и работа с данными.

### Строковые данные.
Таблица была на 54 строке этого документа.

Создадим табличку string_tbl
```mysql
CREATE TABLE string_tbl
(char_fld CHAR(30),
vchar_fld VARCHAR(30),
text_fld TEXT);
```
Наполним ее
```mysql
INSERT INTO string_tbl (
char_fld, vchar_fld, text_fld)
VALUES (
'This is char data', 'This is varchar data', 'This is text data');
```
```$
+-------------------+----------------------+-------------------+
| char_fld          | vchar_fld            | text_fld          |
+-------------------+----------------------+-------------------+
| This is char data | This is varchar data | This is text data |
+-------------------+----------------------+-------------------+
```
Попробуем внести в ячейку с разрешенной длиной 30 текст большей длины.
```mysql
mysql> UPDATE string_tbl
    -> SET vchar_fld = 'This is a piece of extremely long varchar data';
Query OK, 1 row affected, 1 warning (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 1
mysql> UPDATE string_tbl
    -> SET vchar_fld = 'This is a piece of extremely long varchar data';
Query OK, 1 row affected, 1 warning (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 1

mysql> SHOW WARNINGS;
+---------+------+------------------------------------------------+
| Level   | Code | Message                                        |
+---------+------+------------------------------------------------+
| Warning | 1265 | Data truncated for column 'vchar_fld' at row 1 |
+---------+------+------------------------------------------------+
1 row in set (0.00 sec)

mysql> select * from string_tbl;
+-------------------+--------------------------------+-------------------+
| char_fld          | vchar_fld                      | text_fld          |
+-------------------+--------------------------------+-------------------+
| This is char data | This is a piece of extremely l | This is text data |
+-------------------+--------------------------------+-------------------+
1 row in set (0.00 sec)
```
В столбце vchar_fld размещены только первые 30 символов, остальное БД просто усекает.

Нужно быть внимательным с кавычками, если по тексту использовать и двойные и одинарные либо знак экранирования '\'
Для извлечения текста с кавычками можно использовать **функцию `QUOTE`**, она автоматически дополнит извлекаемую строку знаками экранирования перед каждой кавычкой или апострофом.
```mysql
mysql> SELECT vchar_fld from string_tbl;
+--------------------------+
| vchar_fld                |
+--------------------------+
| This string doesn't work |
+--------------------------+
1 row in set (0.00 sec)

mysql> SELECT QUOTE(vchar_fld) from string_tbl;
+-----------------------------+
| QUOTE(vchar_fld)            |
+-----------------------------+
| 'This string doesn\'t work' |
+-----------------------------+
```
**Функция `CHAR()`** принимает аргументом число, а вернёт символ из таблицы символов соответсвующий числу в аргументе. Соответствует функции `chr()` в Python. Вот только не понятно как задать используемую таблицу символов.

**Функция `ASCII()`** обратная для функции `CHAR()`, соответсвует `ord()` в Python.

**Функция `CONCAT()`** - конкатинация, принимает строковые аргументы и соединяет их. Числа при этом автоматически преобразуются в строки.
```$
mysql> SELECT CONCAT('some', 1, 'else');
+---------------------------+
| CONCAT('some', 1, 'else') |
+---------------------------+
| some1else                 |
+---------------------------+
```
Дополнение строк конкатинацией:
```mysql
UPDATE string_tbl
SET text_fld = CONCAT(text_fld, ',but now it is longer') /* равносильно += в Python */
```
Составление списка строк конкатенацией
```mysql
SELECT CONCAT(fname, ' ', lname, ' ', 'has been a ',
title, 'since ', start_date) Concat_str
FROM employee
WHERE title = 'Teller' OR title = 'Head Teller';
/* RESULT
+--------------------------------------------------------+
| Concat_str                                             |
+--------------------------------------------------------+
| Helen Fleming has been a Head Tellersince 2004-03-17   |
| Chris Tucker has been a Tellersince 2004-09-15         |
| Sarah Parker has been a Tellersince 2002-12-02         |
| Jane Grossman has been a Tellersince 2002-05-03        |
| Paula Roberts has been a Head Tellersince 2002-07-27   |
| Thomas Ziegler has been a Tellersince 2000-10-23       |
| Samantha Jameson has been a Tellersince 2003-01-08     |
| John Blake has been a Head Tellersince 2000-05-11      |
| Cindy Mason has been a Tellersince 2002-08-09          |
| Frank Portman has been a Tellersince 2003-04-01        |
| Theresa Markham has been a Head Tellersince 2001-03-15 |
| Beth Fowler has been a Tellersince 2002-06-29          |
| Rick Tulman has been a Tellersince 2002-12-12          |
+--------------------------------------------------------+
*/
```
Вернем таблицу в исходный вид
```mysql
DELETE FROM string_tbl; /*без агрументов удаляет все данные из таблицы*/

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters', 'This string is 28 characters', 
'This string is 28 characters');
```
**Функция `LENGTH()`** соответсвует функции `len()` в Python. Интересно, что если применить к CHAR(30), то функция автоматически уберет пробелы которыми дополняется строка и выдаст реальное количес вто символов.
```mysql
SELECT LENGTH(char_fld) FROM string_tbl;
```
```$
+------------------+
| LENGTH(char_fld) |
+------------------+
|               28 |
+------------------+
```
**Функция `POSITION('some text' IN column_name)`** соответсвует `index()` в Python. В качестве аргументов принимает строку и название столбца возвращает число - индекс, порядковый номер символа строки с которого начинается подстрока.
```mysql
SELECT POSITION('characters' IN char_fld) FROM string_tbl;
+------------------------------------+
| POSITION('characters' IN char_fld) |
+------------------------------------+
|                                 19 |
+------------------------------------+
```
**!!!** Нумерация в БД начинается не с 0 а с 1. Если подстрока не найдена `POSITION()` вернет 0

**Функция `LOCATE()`** то же что и `POSITION()`, но может принимать третий необязательный аргумент, которй указывает стартовую позицию для поиска `SELECT LOCATE('is' IN char_fld, 5) FROM string_tbl;`

**Функция `LIKE`** если использовать ее в блоке `SELECT` (до этого мы использовали ее в блоке филтрации `WHERE`)
вернет 1 либо 0 в случае выполнения или не выполнения условия `LIKE`. Внимание на синтаксис, у этой функции не ставятся скобки.
```mysql
SELECT name, name LIKE '%ns'
FROM department;
```
```$
+----------------+-----------------+
| name           | name LIKE '%ns' |
+----------------+-----------------+
| Operations     |               1 |
| Loans          |               1 |
| Administration |               0 |
+----------------+-----------------+
```
**Функция `REGEXP()`** более сложный вариант `LIKE()`. Но тем не менее пример:
```mysql
SELECT cust_id, cust_type_cd, fed_id,
fed_id REGEXP '.{3}-.{2}-.{4}' column_name
FROM customer;
/*
+---------+--------------+-------------+-------------+
| cust_id | cust_type_cd | fed_id      | column_name |
+---------+--------------+-------------+-------------+
|       1 | I            | 111-11-1111 |           1 |
|       2 | I            | 222-22-2222 |           1 |
|       3 | I            | 333-33-3333 |           1 |
|       4 | I            | 444-44-4444 |           1 |
|       5 | I            | 555-55-5555 |           1 |
|       6 | I            | 666-66-6666 |           1 |
|       7 | I            | 777-77-7777 |           1 |
|       8 | I            | 888-88-8888 |           1 |
|       9 | I            | 999-99-9999 |           1 |
|      10 | B            | 04-1111111  |           0 |
|      11 | B            | 04-2222222  |           0 |
|      12 | B            | 04-3333333  |           0 |
|      13 | B            | 04-4444444  |           0 |
+---------+--------------+-------------+-------------+
*/
```
**Функция `INSERT()`**  которая принимает четыре аргумента: исходную строку, начальное положение, число символов, требующих замены, и замещающую строку. В зависимости от значения третьего аргумента функция выполняет вставку либо замену символов строки. Если третий аргумент равен нулю, то замещающая строка вставляется со сдвигом всех последующих символов вправо, например:
```mysql
 SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;	
/*RESULT
+---------------------+
| string              |
+---------------------+
| goodbye cruel world |
+---------------------+
*/
```
```mysql
SELECT INSERT('goodbye world', 1, 7, 'hello') string;
/* RESULT
+-------------+
| string      |
+-------------+
| hello world |
+-------------+
*/
```
**Функция `SUBSTRIN()`** принимает 3 аргумента, первый исходная строка, второй это страртовый номер для извлечения подстроки и третий это количество извлекаемых символов.
```mysql
SELECT SUBSTRING('goodbay cluel world', 9, 5);
/* RESULT
+----------------------------------------+
| SUBSTRING('goodbay cluel world', 9, 5) |
+----------------------------------------+
| cluel                                  |
+----------------------------------------+
*/
```
### Числовые данные.
БД можно использовать как неудобный калькулятор, допустимы '+', '-', '\*', '/', '()'.
```mysql
SELECT (37*15/(533-(23*3)))
/*RESULT
+----------------------+
| (37*15/(533-(23*3))) |
+----------------------+
|                 1.20 |
+----------------------+
```
**Арифметические операции**
|**Функция**  |**Описание**             |**Комментарий**                |
|:------------|:------------------------|:------------------------------|
| SIN(x)      | Синус х                 |                               |
| COS(x)      | Косинус х               |                               |
| TAN(x)      | Тангенс х               |                               |
| COT(x)      | Котангенс х             |                               |
| ACOS(x)     | Арккосинус х            |                               |
| ASIN(x)     | Арксинус х              |                               |
| ATAN(x)     | Арктангенс х            |                               |
| EXP(x)      | е в степени х           |                               |
| LN(x)       | Натуральный логарифм х  |                               |
| SQRT(x)     | Квадратный корень из х  |                               |
| MOD(x, y)   | Возвращает остаток от деления х на у  | MOD(10,4) = 2   |
| POW(x, y)   | х в степени у           |                               |
| CEIL(x)     | Округляет x вверх       | CEIL(74.335) = 75             |
| FLOOR(x)    | Округляет x ввниз       | FLOOR(74.7) = 74              |
| ROUND(x, y) | Округляет x до у количества знаков после запятой   | ROUND(4.7) = 5, ROUND(3.5) = 4, ROUND(3.5337323, 3) = 3.534|
| FLOOR(x)    | Округляет x ввниз       | FLOOR(74.7) = 74              |
| SIGN(x)     | Возвращает -1 если х<0,  0 если х=0, 1 если x>1 |       |
| ABS(x)      | Модуль х                |                               |

### Временные данные.

Обязательное форматирование при описании временных данных
|**Тип**   |**Формат по умолчанию**|
|:---------|:----------------------|
| Date     | YYYY-MM-DD            |
| DAtetime | YYYY-MM-DD HH:MI:SS   |
| Timestamp| YYYY-MM-DD HH:MI:SS   |
| Time     | HHH:MI:SS             |

|**Функция**             |**Описание**                            |**Комментарий**  |
|:-----------------------|:---------------------------------------|:----------------|
| CAST(x AS y)           | Преобразует данные х в у формат        | СМ. пояснение ниже таблицы|
| STR_TO_DATE()          | Преобразует строку определенного формата в дату | STR_TO_DATE('March 27, 2005', '%M %d, %Y') см. следующую таблицу аргументов для функции |
| CURRENT_DATE()         | Возвращает текущую дату                |                 |
| CURRENT_TIME()         | Возвращает текущее время               |                 |
| CURRENT_TIMESTAMP()    | Возвращает текущий таимштамп, см формат|                 |
| CURRENT_TIME()         | Возвращает текущее время               |                 |
| DATE_ADD(x INTERVAL y) | Добавляет к х интервал y               | DATE_ADD(CURRENT_DATE(  ), INTERVAL 5 DAY), см. следующую таблицу аргументов для функции |
| LAST_DAY(х)            | Возвращает DATE со значением последнего дня месяца указанного в аргументе х |  LAST_DAY('2005 03 25') =  2005 03 31 |
| CONVERT_TZ(x, y, z)	   | Преобразует дату x из часового пояса у в часовой пояс z |  CONVERT_TZ(CURRENT_TIMESTAMP(  ), 'US/Eastern', 'UTC') |
| DAYNAME(x)             | Принимает DATE возвращает строку с названием дня недели |  DAYNAME('2005 03 22')	= Tuesday |
| EXTRACT(x FROM y)| Извлекает x (см. ниже таблицу аргументов) из  y| EXTRACT(YEAR FROM '2005 03 22 22:19:05')	 = 2005 |
|  DATEDIFF(x, y)        | Возвращает количество полных дней между двумя датами x и y |  DATEDIFF('2005 09 05', '2005 06 22') = 75|

Функция `CAST()` при преобразовании строки в число преобразует всю строку слева напарво  до первого нечислового символа.
```mysql
 SELECT CAST('999ABC111' AS UNSIGNED INTEGER);
/*RESULT
+---------------------------------------+
| CAST('999ABC111' AS UNSIGNED INTEGER) |
+---------------------------------------+
|                                   999 |
+---------------------------------------+
*/
```
*Аргументы для функции `STR_TO_DATE`*
|**Компоненты форматирования** | **Описание**                             |
|:---------------------------- |:---------------------------------------- |
| %M                           | Название месяца (от January до December) |
| %m                           | Номер месяца (от 01 до 12)               |
| %d                           | Число (от 01 до 31)                      |
| %j                           | День года (от 001 до 366)                |
| %W                           | Дни недели (от Sunday до Saturday)       |
| %Y                           | Год четырёхзначное число                 |
| %y                           | Год двузначное число                     |
| %H                           | Час (от 00 до 23)                        |
| %h                           | Час (от 01 до 12)                        |
| %h                           | Час (от 01 до 12)                        |
| %i                           | Минуты (от 00 до 59)                     |
| %s                           | Секунды (от 00 до 59)                    |
| %f                           | Микросекунды (от 000000 до 999999)       |
| %p                           | A.M. или P.M.                            |

*Аргументы для функции `ADD_DATE()` и `EXTRACT()`*
|**Интервал**   | **Описание**         |
|:--------------|:---------------------|
| SECOND        | Количество секунд    |
| MINUTE        | Количество минут     |
| HOUR          | Количество часов     |
| DAY           | Количество дней      |
| MONTH         | Количество месяцев   |
| YEAR          | Количество лет       |
| MINUTE_SECOND | Количество минут и секунд, разделенные двоеточием |
| HOUR_SECOND   | Количество часов, минут и секунд, разделенные двоеточием |
| YEAR_MONTH    | Количество лет и месяцев, разделенных дефисом |

[Упражнения Главы 7](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_7.sql)

## Глава 8. Группировка и агрегаты.
Блок GROUP BY позволяет избежать повторов в значениях столбцов по которому мы группируем. Похоже он оставляет только первую строку где упоминается новое значение.
```mysql
SELECT open_emp_id FROM account
GROUP BY open_emp_id;
/* RESULT
+-------------+
| open_emp_id |
+-------------+
|           1 |
|          10 |
|          13 |
|          16 |
+-------------+*/
```
Для подсчета количества строчек с одинаковым значением можно использовать *агрегатную функцию* - `COUNT(*)`.
```mysql
SELECT open_emp_id, COUNT(*) how_many  FROM account
GROUP BY open_emp_id;
/* RESULT
+-------------+----------+
| open_emp_id | how_many |
+-------------+----------+
|           1 |        8 |
|          10 |        7 |
|          13 |        3 |
|          16 |        6 |
+-------------+----------+
*/
```
Блок `GROUP BY` выполняется после вычисления блока `WHRERE` поэтому условияфильтрации нельзя добавить в блок `WHERE`. Таким обзразом если мы создалим например такой фильтр `WHERE COUNT(*) > 4` получим ошибку. Так как `COUNT(*)` пока что не существует. В этом случае условия фильтрации нужно ставить в блок `HAVING` после блока `GROUP BY`.
```mysql
SELECT open_emp_id, COUNT(*)
FROM account
GROUP BY open_emp_id
HAVING COUNT(*) > 4;
/*RESULT
+-------------+----------+
| open_emp_id | COUNT(*) |
+-------------+----------+
|           1 |        8 |
|          10 |        7 |
|          16 |        6 |
+-------------+----------+
*/
```
**Агрегатные функции** - функции, которые выполняют операции над всеми строками группы. 

|**Агрегатная функция** | **Значение**                               |
|:----------------------|:-------------------------------------------|
| MAX()                 | Возвращает максимальное значение набора    |
| MIN()                 | Возвращает минимальное значение набора     |
| AVG()                 | Возвращает среднее значение набора         |
| SUM()                 | Возвращает сумму значений набора           |
| COUNT()               | Возвращает количество значений набора      |

Применим агрегатные функции. В таблице account оставим только строки со значением `product_cd = 'CHK'`, посчитаем количесвто таких строк и применим ко всему списку несколько агрегатных функций.
```mesql
SELECT MAX(avail_balance),
MIN(avail_balance),
AVG(avail_balance),
SUM(avail_balance),
COUNT(*)
FROM account
WHERE product_cd = 'CHK';
/* RESULT
+--------------------+--------------------+--------------------+--------------------+----------+
| MAX(avail_balance) | MIN(avail_balance) | AVG(avail_balance) | SUM(avail_balance) | COUNT(*) |
+--------------------+--------------------+--------------------+--------------------+----------+
|           50000.00 |               0.00 |        7114.769138 |          170754.46 |       24 |
+--------------------+--------------------+--------------------+--------------------+----------+
*/
```
А если мы захотели посмотреть значение агрегатных функций для других типов счетов и сравнить их:
```mysql
SELECT product_cd,
MAX(avail_balance),
MIN(avail_balance),
AVG(avail_balance),
SUM(avail_balance),
COUNT(*)
FROM account
GROUP BY product_cd;
/* RESULT
+------------+--------------------+--------------------+--------------------+--------------------+----------+
| product_cd | MAX(avail_balance) | MIN(avail_balance) | AVG(avail_balance) | SUM(avail_balance) | COUNT(*) |
+------------+--------------------+--------------------+--------------------+--------------------+----------+
| BUS        |            9345.55 |               0.00 |        4672.774902 |            9345.55 |        2 |
| CD         |           10000.00 |            1500.00 |        4875.000000 |           19500.00 |        4 |
| CHK        |           38552.05 |             122.37 |        7300.800985 |           73008.01 |       10 |
| MM         |            9345.55 |            2212.50 |        5681.713216 |           17045.14 |        3 |
| SAV        |             767.77 |             200.00 |         463.940002 |            1855.76 |        4 |
| SBL        |           50000.00 |           50000.00 |       50000.000000 |           50000.00 |        1 |
+------------+--------------------+--------------------+--------------------+--------------------+----------+*/
```

Запрос `SELECT COUNT(*) FROM account;` покажет количество строк в таблице account. 

Запрос `SELECT COUNT(open_emp_id) FROM account;` покажет количество строк в столбце open_emp_id в  таблице account.

Запрос `SELECT COUNT(DISTINCT open_emp_id) FROM account;` покажет количество уникальных строк в столбце open_emp_id в  таблице account.

Ф качестве аргументов агрегатных функций можем использовать выражения:
```mysql
SELECT MAX(pending_balance-avail_balance), AVG(pending_balance-avail_balance)
FROM account;
/*RESULT
+------------------------------------+------------------------------------+
| MAX(pending_balance-avail_balance) | AVG(pending_balance-avail_balance) |
+------------------------------------+------------------------------------+
|                                660 |                    48.333333333333 |
+------------------------------------+------------------------------------+
НЕКРАИСВО!
*/
SELECT MAX(pending_balance-avail_balance), ROUND(AVG(pending_balance-avail_balance), 3)
FROM account;
/*RESULT
+------------------------------------+----------------------------------------------+
| MAX(pending_balance-avail_balance) | ROUND(AVG(pending_balance-avail_balance), 3) |
+------------------------------------+----------------------------------------------+
|                                660 |                                       48.333 |
+------------------------------------+----------------------------------------------+
ТЕПЕРЬ КРАСИВО*/
```
Функции `MAX()`, `MIN()`, `AVG()` игнорируют значения NULL, так будто такой строки не сущесвтует.

Группировка по нескольким столбац производиться в порядке перечисления этих столбцов в запросе. Наприер нам надо понять сколько типов продуктов (`product_cd`) было открыто в каждом отделении. Первично ТИП ПРОДУКТА, ВТОРИЧНО отделение, поехали:
```mysql
SELECT product_cd, open_branch_id, count(*)
FROM account
GROUP BY product_cd, open_branch_id;
```
 Запрос группирует сотрудников по году начала их работы в банке:	
```mysql
SELECT EXTRACT(YEAR FROM start_date) YEAR, COUNT(*)
FROM employee
GROUP BY EXTRACT(YEAR FROM start_date);
/* RESULT
+------+----------+
| YEAR | COUNT(*) |
+------+----------+
| 2000 |        3 |
| 2001 |        2 |
| 2002 |        8 |
| 2003 |        3 |
| 2004 |        2 |
+------+----------+ */
```
### Обобщения. `WHITH ROLLUP`.
Нужно вывести сумарный баланс по типам продукта каждом отделении а так же указать суммарный баланс продукта по всем отделениям. Первую часть мы уже выполняли
```mysql
SELECT product_cd, open_branch_id,  SUM(avail_balance)
FROM account
GROUP BY product_cd, open_branch_id WHITH ROLLUP;
``` 
Вторая часть выполняется следующей логикой, "с обобщением по столбцу open_branch_id".

Для фильтрации сгруппированных рузельтатов применяем блок `HAVING`

[Упражнения Главы 8](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_8.sql)

## Глава 9. Подзапросы.

В условиях `WHERE` используются подзапросы.
```mysql
SELECT account_id, product_cd, cust_id, avail_balance 
FROM account
WHERE account_id = (SELECT MAX(account_id) FROM account);
/*RESULT
+------------+------------+---------+---------------+
| account_id | product_cd | cust_id | avail_balance |
+------------+------------+---------+---------------+
|         24 | SBL        |      13 |      50000.00 |
+------------+------------+---------+---------------+*/
```
Подзапрос `(SELECT MAX(account_id) FROM account)` возвращает один столбец и одну строку и воспринимается как число 24. Это называется *скалярный подзапрос* к нему можно применять арифметические условия =, <, >, <=, >=, !=. Пример сложного скалярного подзапроса.
```mysql
SELECT account_id, product_cd, cust_id, avail_balance 
FROM account
WHERE open_emp_id != (SELECT e.emp_id 
FROM employee e INNER JOIN branch b
ON e.assigned_branch_id = b.branch_id
WHERE e.title = 'Head Teller' AND b.city = 'Woburn');
```
В этом случае подзапрос, несмотря на сложность, является скалярным и просто возвращает одну строку и один столбец со значением 10.

Если подзапрос не скалярный то блок `WHERE` можно оформить с помощью оператора `IN` и `NOT IN`.
Например нам надо вывести список руководителей
```mysql
SELECT emp_id, fname, lname, title FROM employee
WHERE emp_id IN (select superior_emp_id from employee);
/*RESULT 
+--------+---------+-----------+--------------------+
| emp_id | fname   | lname     | title              |
+--------+---------+-----------+--------------------+
|      1 | Michael | Smith     | President          |
|      3 | Robert  | Tyler     | Treasurer          |
|      4 | Susan   | Hawthorne | Operations Manager |
|      6 | Helen   | Fleming   | Head Teller        |
|     10 | Paula   | Roberts   | Head Teller        |
|     13 | John    | Blake     | Head Teller        |
|     16 | Theresa | Markham   | Head Teller        |
+--------+---------+-----------+--------------------+*/
```
### Оператор `ALL`

Позволяет производить сравнение одиночного значения с каждым значением набора.
Например запрос выдающий ID всех сотрудников если их нет в списке руководителей
```mysql
SELECT  emp_id FROM employee
WHERE emp_id != ALL (
SELECT superior_emp_id FROM employee
WHERE superior_emp_id IS NOT NULL /* почему то это важно */
);
```
Сравнивать значения с набором значений с помощью операторов `not in` или `!= all` нужно аккуратно, убедившись, что в наборе нет значения NULL. Сервер приравнивает значение из левой части выражения к каждому члену набора, и любая попытка приравнять значение к NULL дает в результате unknown и следовательно Empty set.	

### Оператор `ANY`
Такйо же оператор как и `ALL`, по смыслу схожи с `AND` и `OR`.

Требуется найти все счета, доступный остаток которых больше, чем на любом из счетов Фрэнка Такера:	
```mysql
SELECT account_id, avail_balance
FROM account
WHERE avail_balance > ANY (
SELECT a.avail_balance /* Внимание подзапрос */
FROM account a INNER JOIN individual i
ON a.cust_id = i.cust_id
WHERE  i.fname = 'Frank' AND i.lname = 'Tucker')
ORDER BY avail_balance DESC;
```
### Подзапросы возвращающие несколько столбцов.
Допустим в блоке `WHERE` требуется выполнитть два условия:
1. ID отделения должно быть в одном списке
2. ID сотрудника должен быть в другом списке
Мы реализуем это так:
```mysql
WHERE (id_отделения, id_сотрудника) IN (SELECT нужные_ID_отделений, нужные_ID_сотрудников...
```
Важно в условии фильтрации указать в круглых скобках имена требуемых столбцов таблицы в том же порядке, в каком они возвращаются подзапросом.

### Связанные подзапросы.
Требуется определить всех клиентов у которых ровно 2 счета. Вот запрос здорового человека:
```mysql
SELECT cust_id, city
FROM customer
WHERE cust_id IN (
 SELECT cust_id FROM account /* этот подзапрос независимый */
 GROUP BY cust_id
 HAVING COUNT(*) = 2
);
```
А вот зависимый запрос
```mysql
SELECT c.cust_id, c.city
FROM customer c
WHERE 2 = (
SELECT COUNT(*)
FROM account a
WHERE c.cust_id = a.cust_id /* вот зависимая часть запроса, некое ощущение цикла */
);
```
### Оператор `EXIST`
Оператор exists применяется, если требуется показать, что связь есть, а количество связей при этом не имеет значения.
```mysql
SELECT some_data
FROM table
WHERE EXISTS (SELECT 1
зависимый подзапрос');
```
Не важно что вернет условие подзапроса, главное, что либо что то вернется либо нет. То есть `EXIST` как будто проверяет на True False.

Например поиск клиентов чей ID не вхож в список ID в таблице business
 ```mysql
 SELECT a.account_id, a.product_cd, a.cust_id
FROM account a
WHERE NOT EXISTS (SELECT 1
FROM business b
WHERE b.cust_id = a.cust_id);
```
Связанные подзапросы можно применять и для обновления ячеек. Например можем обновить данные о последней транзакции. 
```mysql
UPDATE account a
SET a.last_activity_date = (
    SELECT MAX(t.txn_date)
    FROM transaction t
    WHERE t.account_id = a.account_id)
WHERE EXISTS ( 
    SELECT 1
    FROM transaction t
    WHERE t.account_id = a.account_id);
```
Если мы не напишем последний блок `WHERE` c `EXISTS` то по аккаунтам 21, 22 и 24 например в таблице transaction нет записей, и в таблице account они обновят своё значение на NULL, этот сценарий нам не нужен.

### Оператор `UNION ALL`
Сводит в один результирующий набор результаты нескольких выводов.
Например вывод 
```mysql
SELECT 'Small Fry' name, 0 Low_Limit, 4999.99 High_limit;
/*Result
+-----------+-----------+------------+
| name      | Low_Limit | High_limit |
+-----------+-----------+------------+
| Small Fry |         0 |    4999.99 |
+-----------+-----------+------------+*/
```
Объеденим
```mysql
SELECT 'Small Fry' name, 0 Low_Limit, 4999.99 High_limit
UNION ALL
SELECT 'Average Joes' name, 5000 Low_Limit, 9999.99 High_limit
UNION ALL
SELECT 'Heavy Hitters' name, 10000 Low_Limit, 9999999.99 High_limit;
/*Result 
+---------------+-----------+------------+
| name          | Low_Limit | High_limit |
+---------------+-----------+------------+
| Small Fry     |         0 |    4999.99 |
| Average Joes  |      5000 |    9999.99 |
| Heavy Hitters |     10000 | 9999999.99 |
+---------------+-----------+------------+*/
```
```mysql
SELECT tabl2.name, COUNT(*) num_customrs
FROM
/* tabl1 */
    (SELECT SUM(a.avail_balance) cust_balance, a.cust_id
    FROM account a INNER JOIN product p
    ON a.product_cd = p.product_cd
    WHERE p.product_type_cd = 'ACCOUNT'
    GROUP BY a.cust_id) tabl1
INNER JOIN
/* tabl2 */
   (SELECT 'Small Fry' name, 0 Low_Limit, 4999.99 High_limit
    UNION ALL
    SELECT 'Average Joes' name, 5000 Low_Limit, 9999.99 High_limit
    UNION ALL
    SELECT 'Heavy Hitters' name, 10000 Low_Limit, 9999999.99 High_limit) tabl2
ON tabl1.cust_balance BETWEEN tabl2.Low_Limit AND tabl2.High_limit
GROUP BY tabl2.name;

/* RESULT
+---------------+--------------+
| name          | num_customrs |
+---------------+--------------+
| Average Joes  |            2 |
| Heavy Hitters |            4 |
| Small Fry     |            5 |
+---------------+--------------+ */
```
Какйо сотрудник открыл больше всех счетов
```mysql
SELECT e.emp_id ID, CONCAT(e.fname, ' ', e.lname) employee, a.sum Sum
FROM employee e INNER JOIN (
SELECT open_emp_id, COUNT(*) sum
FROM account
GROUP BY open_emp_id) a
ON e.emp_id = a.open_emp_id
HAVING a.sum = max(a.sum);
/*RESULT
+----+---------------+-----+
| ID | employee      | Sum |
+----+---------------+-----+
|  1 | Michael Smith |   8 |
+----+---------------+-----+*/
```
[Упражнения Главы 9](https://github.com/EnnerDA/SQL_conspectus/blob/main/%D0%A3%D0%BF%D1%80%D0%B0%D0%B6%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F%203/exercises_9.sql)

## Глава 10. И снова соединения.
При соединении таблицы account и business по столбцу cust_id, результат будет содержать 5 строк. так как для части значений cust_id таблицы account нет никакого совпадения в таблице business. 

Можно сделать так чтоб итоговый результат содержал абсолютно все строки, просто в тех где нет совпадения были NULL. Для этого применим **ВНЕШНЕЕ СОЕДИНЕНИЕ (OUTER JOIN)**.

Внешнее соединение включает все строки одной таблицы и вводит данные второй таблицы только в случае обнаружения соответствующих строк.
```mysql
SELECT a.account_id, b.cust_id, b.name
FROM account a LEFT OUTER JOIN business b
USING(cust_id);
```
Такой запрос возьмет из таблицы слева (т.к. указано `LEFT`) весь столбец account_id достроит к нему 2 столбца справа cust_id, name из таблицы business. Если есть соответствие в cust_id то столбцы cust_id, name будут заполнены данными из business если нет то NULL.

Если мы применим `RIGHT OUTER`, то получим 4 строки (как в business). Хотя получается что получили 5 строк. Пока не разобрался что не так.

Рекурсивный вызов во внешнем соединении
```mysql
SELECT e1.emp_id, e1.fname, e1.lname, e1.title,
CONCAT( e2.fname, ' ', e2.lname, ' ', e2.title) superior
FROM employee e1 LEFT OUTER JOIN employee e2
ON e1.superior_emp_id = e2.emp_id;
```







