-- ������������ ������� ���� ����������, ����������, ���������� � �����������

-- 1) ����� � ������� users ���� created_at � updated_at ��������� ��������������.
-- ��������� �� �������� ����� � ��������.

INSERT INTO users (created_at, updated_at) VALUES (NOW(), NOW());

-- 2) ������� users ���� �������� ��������������. 
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� 
-- � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, 
-- �������� �������� ����� ��������

UPDATE users set created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;

-- 3) � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
-- 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
-- ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

select value from (select value, IF(value=0, ~0, value) as zeroes  from storehouses_products ORDER BY zeroes) as agg;

-- ������������ ������� ���� ���������� �������

-- 1) ����������� ������� ������� ������������� � ������� users

SELECT AVG(age) FROM (SELECT YEAR(CURRENT_TIMESTAMP) - YEAR(birthday) as age FROM profiles) AS Avg_age;

-- 2) ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
-- ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������

SELECT COUNT(*) as stats from (SELECT DAYOFWEEK(CONCAT(YEAR(NOW()),'-',MONTH(birthday),'-',DAYOFMONTH(birthday))) as date from profiles) as stats where date=1;
-- ��� date=1 ��� ������������, date=2 ��� �������� � �.�
