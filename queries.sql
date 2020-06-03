-- Первое задание

select sh.date_creation, sh.city
from shop as sh
where city = 'Дубна'and date_creation > now()

-- Второе задание
select sched.start_work, sched.finish_work, sh.name
from schedule_works as sched, shop as sh, employee_shop as emps
where cast (sg.name AS varchar) like 'Оля' and sg.id = emps.shop_id and sched.start_work is not null

-- Третье задание
SELECT cl.id, cl.name, cl.surname, cl.middle_name, extract(month from age(act.date_buy)) as day
FROM client as cl

INNER JOIN product_accounting as pr ON cl.id=pr.client_id
INNER JOIN accounting as act ON pr.accounting_id=act.id
WHERE pr.receipt >= 10000 and age(act.date_buy, '1999-01-01') > age(now(), '1999-01-16')

ORDER BY cl.id, cl.name, cl.surname, cl.middle_name, extract(month from age(act.date_buy))

-- Четвертое задание
with funcOne as(select act.id, sum(act.amount*ac.price) as buy,count(*)::real as tmp
from accounting as act

where(now()::date-ac.date_buy::date)*24<=240
Group By act.id ), funcTwo as(select count(*)::real as tmp1 from accounting as act)

select funcOne.buy , client.name
from funcOne, client, funcTwo

where client.id = funcOne.id

order by funcOne.buy desc
limit (select count(*)/10 from client )

-- Пятое задание
with func as(SELECT clt.id, clt.name, clt.surname, clt.middle_name, MAX(pr.receipt) as receipt
FROM client as clt

INNER JOIN product_accounting as pr ON clt.id=pr.client_id
INNER JOIN accounting as act ON pr.accounting_id=act.id

WHERE (now()::date-ac.date_buy::date)*24<=240

GROUP BY clt.id, clt.name, clt.surname, clt.middle_name, pr.receipt
having pr.receipt = MAX(pr.receipt)
ORDER BY pr.receipt desc
LIMIT 1)

select avg(func.receipt)
from func

-- Шестое задание
SELECT pr.id, pr.attribute, One, Two, Three, Four
FROM product_attribute pr


LEFT JOIN (SELECT act.amount, pr.product_name_id as product_id
From accounting act
INNER JOIN product_accounting pr ON pr.accounting_id = act.id
WHERE act.date_buy> now()-interval '7 days') as One ON pr.id=One.product_id


LEFT JOIN (SELECT act.amount, pr.product_name_id as product_id
From accounting act
INNER JOIN product_accounting pr ON pr.accounting_id = act.id
WHERE act.date_buy> now()-interval '14 days' and act.date_buy < now()-interval '7 days') as Two ON pr.id=Two.product_id


LEFT JOIN (SELECT act.amount, pr.product_name_id as product_id
From accounting act
INNER JOIN product_accounting pr ON pr.accounting_id = act.id
WHERE act.date_buy> now()-interval '21 days' and act.date_buy < now()-interval '14 days') as Three ON pr.id=Three.product_id


LEFT JOIN (SELECT act.amount, pr.product_name_id as product_id
From accounting act
INNER JOIN product_accounting pr ON pr.accounting_id = act.id
WHERE act.date_buy> now()-interval '28 days' and act.date_buy < now()-interval '21 days') as Four ON pr.id=Four.product_id


ORDER BY pr.id

-- Седьмое задание
with a as(select distinct pr.product_name_id,

case
when act.date_buy < now() and act.date_buy > (now()::date - integer '7')
then (count(pr.*))
else 0
end as one,

case
when act.date_buy < now()::date - integer '7' and act.date_buy > now()::date - integer '14'
then count(pr.*)
else 0
end as two,

case
when act.date_buy < now()::date - integer '14' and act.date_buy > now()::date - integer '21'
then count(pr.*)
else 0
end as three,

case
when act.date_buy < now()::date - integer '21' and act.date_buy > now()::date - integer '28'
then count(pr.*)
else 0
end as four

from product_accounting pr, accounting act
where act.id = pr.accounting_id
group by pr.product_name_id, act.date_buy)


select product_name_id, (one + two + three + four) as sum,
pr.quantity_stock,

case
when (one + two + three + four) > pr.quantity_stock
then (one + two + three + four) - pr.quantity_stock
else 0
end

from a

inner join product_name pr on a.product_name_id = pr.id
group by product_name_id, sum, pr.quantity_stock

-- Восьмое задание
select emp.name, emp.surname, sched.start_work, sched.finish_work
from employee as emp, schedule_works as sсhed
where sched.id=emp.schedule_works_id and finish is not null

--Девятое задание
SELECT two_last.two_last, one_last.one_last, now.now, one_next.one_next, two_next.two_next
FROM food as fd

LEFT JOIN (SELECT fd.id as id, ABS((ph.old_price-ph.new_price)*100)/ph.old_price::real as two_last
FROM food as fd
INNER JOIN price_history ph ON ph.product_id=fd.id
WHERE ph.date_changes > now() - interval '14 days' and ph.date_changes < now()-interval '7 days') as two_last ON two_last.id = fd.id

LEFT JOIN (SELECT fd.id as id, ABS((ph.old_price-ph.new_price)*100)/ph.old_price::real as one_last
FROM food as fd
INNER JOIN price_history ph ON ph.product_id=fd.id
WHERE ph.date_changes > now() - interval '7 days') as one_last ON one_last.id = fd.id

LEFT JOIN (SELECT fd.id as id, ph.new_price as now
FROM food as fd
INNER JOIN price_history ph ON ph.product_id=fd.id) as now ON now.id=fd.id

LEFT JOIN (SELECT fd.id as id, ABS((ph.new_price-ph.new_price)*100)/ph.new_price::real as one_next
FROM food as fd
INNER JOIN price_history ph ON ph.product_id=fd.id
WHERE ph.date_changes < now() + interval '7 days') as one_next ON one_next.id = fd.id

LEFT JOIN (SELECT fd.id as id, ABS((ph.new_price-ph.new_price)*100)/ph.new_price::real as two_next
FROM food as fd
INNER JOIN price_history ph ON ph.product_id=fd.id
WHERE ph.date_changes < now() + interval '14 days' and ph.date_changes > now()+interval '7 days') as two_next ON two_next.id = fd.id

-- Десятое задание
select clt.id, clt.name, act.date_buy, EXTRACT(week FROM act.date_buy)
from client as clt, product_accounting as pr, accounting as act
where clt.id = pr.id and act.id = pr.id

--Одиннадцатое задание
delete from only client where phone = '';     -- and where mail = “ “;
delete from client where phone = '' ';    --  and  where mail = “ “;

-- Двенадцатое задание
with funcOne as(select emp.id , emp.accepted
from employee as emp
where emp.accepted = (select max(accepted) from employee)),

funcTwo as(select sup.name as supplier,sh.name as shop, emp.id ,emp.surname as employee_surname
from supplier as sup, employee as emp, shop as sh
where emp.id = sup.employee_id and sup.shop_id = sh.id)

select *
from funcOne, funcTwo
where funcOne.id = funcTwo.id

-- Тринадцатое задание
with funcOne as
(select prs.id, prs.costs::real as price_product
from product_shop as prs ),

funcTwo as
(select shs.id, shs.price::real as price_supplier
from shop_supplier as shs )

select (funcOne.price_product-funcTwo.price_supplier)/funcTwo.price_supplier*100 as relative ,
funcOne.price_product-funcTwo.price_supplier as absolute
from funcOne, funcTwo
where funcOne.id = funcTwo.id

--Четырнадцатое задание
with clear_income as
(with outcome as (select shs.id, shs.price::real as outcome
from shop_supplier as shs),

income as (select prs.id, prs.costs::real as income
from product_shop as prs )

select outcome.id outcome_id, income.id as income_id, income.income-outcome.outcome as clear_income, outcome.outcome
from outcome, income
where outcome.id = income.id), shop as(select sh.id as shop_id from shop as sh)

select *
from clear_income, shop
where clear_income.income_id = shop.shop_id and clear_income.outcome_id = shop.shop_id

-- Пятнадцатое задание
ALTER TABLE employee ADD COLUMN salary integer ;

update employee set salary = 30000 where id = 11;
update employee set salary = 30000 where id = 12;
update employee set salary = 30000 where id = 13;
update employee set salary = 30000 where id = 14;
update employee set salary = 30000 where id = 15;
update employee set salary = 30000 where id = 16;
update employee set salary = 30000 where id = 17;
update employee set salary = 30000 where id = 18;
update employee set salary = 30000 where id = 19;
update employee set salary = 30000 where id = 20;

alter table employee alter column salary set not null;

