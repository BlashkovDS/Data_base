-- ѕрактическое задание теме Уќператоры, фильтраци€, сортировка и ограничениеФ

-- 1) ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными.
-- «аполните их текущими датой и временем.

INSERT INTO users (created_at, updated_at) VALUES (NOW(), NOW());

-- 2) “аблица users была неудачно спроектирована. 
-- «аписи created_at и updated_at были заданы типом VARCHAR и в них долгое врем€ помещались значени€ 
-- в формате "20.10.2017 8:10". Ќеобходимо преобразовать пол€ к типу DATETIME, 
-- сохранив введеные ранее значени€

UPDATE users set created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;

-- 3) ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры:
-- 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. 
-- Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value.
-- ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.

select value from (select value, IF(value=0, ~0, value) as zeroes  from storehouses_products ORDER BY zeroes) as agg;

-- ѕрактическое задание теме Ујгрегаци€ данныхФ

-- 1) ѕодсчитайте средний возраст пользователей в таблице users

SELECT AVG(age) FROM (SELECT YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) as age FROM profiles) AS Avg_age;

-- 2) ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. 
-- —ледует учесть, что необходимы дни недели текущего года, а не года рождени€

SELECT COUNT(*) as stats from (SELECT DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birthday),'-',DAYOFMONTH(birthday))) as date from profiles) as stats where date=1;
-- где date=1 дл€ понедельника, date=2 дл€ вторника и т.д
