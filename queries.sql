-- ѕервое задание

select sh.date_creation, sh.city
from shop as sh
where city = 'ƒубна'and date_creation > now()

-- ¬торое задание
select sched.start_work, sched.finish_work, sh.name
from schedule_works as sched, shop as sh, employee_shop as emps
where cast (sg.name AS varchar) like 'ќл€' and sg.id = emps.shop_id and sched.start_work is not null

-- “ретье задание
SELECT cl.id, cl.name, cl.surname, cl.middle_name, extract(month from age(act.date_buy)) as day
FROM client as cl

INNER JOIN product_accounting as pr ON cl.id=pr.client_id
INNER JOIN accounting as act ON pr.accounting_id=act.id
WHERE pr.receipt >= 10000 and age(act.date_buy, '1999-01-01') > age(now(), '1999-01-16')

ORDER BY cl.id, cl.name, cl.surname, cl.middle_name, extract(month from age(act.date_buy))

-- „етвертое задание
with funcOne as(select act.id, sum(act.amount*ac.price) as buy,count(*)::real as tmp
from accounting as act

where(now()::date-ac.date_buy::date)*24<=240
Group By act.id ), funcTwo as(select count(*)::real as tmp1 from accounting as act)

select funcOne.buy , client.name
from funcOne, client, funcTwo

where client.id = funcOne.id

order by funcOne.buy desc
limit (select count(*)/10 from client )

-- ѕ€тое задание
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

-- Ўестое задание
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



-- ¬осьмое задание
select emp.name, emp.surname, sched.start_work, sched.finish_work
from employee as emp, schedule_works as sсhed
where sched.id=emp.schedule_works_id and finish is not null

--ƒев€тое задание
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

-- ƒес€тое задание
select clt.id, clt.name, act.date_buy, EXTRACT(week FROM act.date_buy)
from client as clt, product_accounting as pr, accounting as act
where clt.id = pr.id and act.id = pr.id

--ќдиннадцатое задание
delete from only client where phone = '';     -- and where mail = У У;
delete from client where phone = '' ';    --  and  where mail = У У;

-- ƒвенадцатое задание
with funcOne as(select emp.id , emp.accepted
from employee as emp
where emp.accepted = (select max(accepted) from employee)),

funcTwo as(select sup.name as supplier,sh.name as shop, emp.id ,emp.surname as employee_surname
from supplier as sup, employee as emp, shop as sh
where emp.id = sup.employee_id and sup.shop_id = sh.id)

select *
from funcOne, funcTwo
where funcOne.id = funcTwo.id

-- “ринадцатое задание
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

-- ѕ€тнадцатое задание
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

