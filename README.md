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







