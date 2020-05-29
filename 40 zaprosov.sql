--1 Задание
select st.name, st.surname, h.name as hobby
From students st
Inner join students_hobbies sh on st.id=sh.student_id
Inner join hobbies h on h.id=sh.hobby_id
Group by st.name, st.surname, h.name
--2 Задание
select st.name, st.surname, st.n_group, st.phone, st.city, st.score, st.birth_date, h.name as hobby, h.risk, age(now(), sh.date_start)
From students st
Inner join students_hobbies sh on st.id=sh.student_id
Inner join hobbies h ON h.id=sh.hobby_id
Group by st.name, st.surname, st.n_group, st.phone, st.city, st.score, st.birth_date, h.name, h.risk, age(now(), sh.date_start)
Order by Max(age(now(), sh.date_start)) desc
limit 1

--3 Задание
Select st.name,st.surname,st.score, avg(st.score),sum(h.risk)
from students st
inner join students_hobbies sh
on st.id=sh.student_id
inner join hobbies h
on h.id=sh.hobby_id
group by st.name,st.surname,st.score
having sum(h.risk)>0.9 and st.score>
(Select avg(score)
from students st)
--4 Задание

select st.name, st.surname, st.birth_date, h.name as hobby, h.risk, extract(month from age(sh.date_finish, sh.date_start)) + extract (year from age (sh.date_finish, sh.date_start)*12)
From students st
Inner join students_hobbies sh on st.id=sh.student_id
Inner join hobbies h on h.id=sh.hobby_id
where sh.date_finish is not null
--5 Задание

Select s.*
From students s
Inner join(
Select sh.student_id
From students_hobbies sh
Where sh.date_finish is null
Group by sh.student_id
Having count(*)>1) t
on s.id = t.student_id
Where extract(year from age(now(),birth_date))>20
--6 Задание

select s1.n_group, avg (s2.score)
from students as s1 join (
	select distinct s.id as id, s.score as score
	from students_hobbies as sh join students as s on s.id = sh.student_id
	where not sh.date_finish is NULL
) as s2 on s1.id = s2.id
group by s1.n_group

--7 Задание

select h.name, h.risk, s.n_group, age(sh.date_start, now())
from students as s join students_hobbies as sh on s.id = sh.student_id join hobbies as h on h.id = sh.hobby_id
where sh.date_finish is null
order by sh.date_start
limit 1

--8 Задание

select h.*
from students as s join students_hobbies as sh on s.id = sh.student_id join hobbies as h on h.id = sh.hobby_id
where s.score = (select max(score) from students)

--9 Задание

select h.*
from students as s join students_hobbies as sh on s.id = sh.student_id join hobbies as h on h.id = sh.hobby_id
where s.score >= 3 and s.score < 4

--10 Задание
with all_students as (
	select substr(st.n_group::varchar,1,1) as course,
	count (*)::real as c
	from students st
	group by substr(st.n_group::varchar,1,1)
	), students_with_hobbies as(
	select substr(st.n_group::varchar,1,1) as course,
	count(distinct st.id)::real as c
	from students st
	inner join students_hobbies sh on st.id =sh.student_id
	where sh.date_finish is null
	group by substr(st.n_group::varchar,1,1)
	)
select swh.c/a_s.c
from all_students a_s
inner join students_with_hobbies swh on a_s.course = swh.course
where swh.c/a_s.c  >0.3
-- 11 Задание

select *
from (Select substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_group
From students st
Group by substr(st.n_group::varchar, 1,4)) as st_all
Inner join (
Select substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_good
From students st
where st.score>=4
Group by substr(st.n_group::varchar, 1,4)
Having count (*)>1) as st_gd
ON st_all.NGROUP = st_gd.NGROUP
WHERE st_all.NGROUP::integer/st_gd.NGROUP::integer>=0.6

--12 Задание

Select substr(st.n_group::varchar, 1,1) as course, count(*) as c_dh
From students st
Inner join students_hobbies sh ON st.id=sh.student_id
Inner join hobbies h ON h.id=sh.hobby_id
Where sh.date_finish is null
Group by substr(st.n_group::varchar, 1,1)
Having count (*)>1

--13 Заданеи

select s.surname, s.name, s.birth_date, s2.course
from students as s join (select substr(s1.n_group::varchar, 1, 1) as course, s1.id from students as s1) as s2 on s.id = s2.id
where not s.id in (select student_id from students_hobbies) and s.score = 5
order by s2.course, birth_date

--14 Задание
select s.*
from students s
inner join students_hobbies sh on s.id=sh.student_id
where sh.date_finish is null
and extract (year from age(now(),sh.date_start))>=5

--15 задание

select h.id, count(sh.id)
from hobbies as h join students_hobbies as sh on h.id = sh.hobby_id
where sh.date_finish is null
group by h.id

--16 задание
select id
from (select h.id as id, count(sh.id) as count_student
	from hobbies as h join students_hobbies as sh on h.id = sh.hobby_id
	group by h.id
	order by count_student desc
	limit 1) as foo

--17 задание

select s.*
from ((select h.id as id, count(sh.id) as count_student
	from hobbies as h join students_hobbies as sh on h.id = sh.hobby_id
	group by h.id
	order by count_student desc
	limit 1) as foo join students_hobbies as sh1 on foo.id = sh1.hobby_id) join students as s on s.id = sh1.student_id

--18 Задание

select id
from hobbies
order by risk
limit 3

-- 19 Задание
  select *
from students s
inner join students_hobbies sh on s.id=sh.student_id
where sh.date_finish is null
order by sh.date_start
limit 10
--20 Задание

select distinct n_group
from (
	select s.*
	from students as s join students_hobbies as sh on s.id = sh.student_id
	where sh.date_finish is null
	order by sh.date_start
	limit 10
	)  as foo

--21 Задание



--22 Задание

With c_hobbies AS(
        Select substr(st.n_group::varchar,1,1) as course,sh.hobby_id, count(*) as c
        from students st
        Inner join students_hobbies sh on st.id = sh.student_id
        Group by substr(st.n_group::varchar,1,1), sh.hobby_id
),max_for_course AS (
        Select c_h.course, max(c) as max_c
	from c_hobbies c_h
	Group by c_h.course
	)
Select c_h.course, c_h.hobby_id
From c_hobbies c_h
Inner join max_for_course mfc On c_h.course = mfc.course and c_h.c=mfc.max_c



-- 26 задание
CREATE OR REPLACE VIEW public.active_hobbies AS
select sh.student_id
   from students_hobbies sh
  where sh.date_finish IS NULL
  Group by sh.student_id
 having count(*) > 1;



--30 Задание
Select substr(st.name, 1, 1), max(h.risk), min(h.risk)
From students st
Inner join students_hobbies sh ON st.id = sh.student_id
Inner join hobbies h on h.id = sh.hobby_id
Group by substr(st.name, 1 , 1)


--32 Задание

Select contact ('Имя: ', st.name, ' ' , 'Фамилия: ', st.surname, ' ' , 'Группа: ', st.n_group)
From students st
Inner join students_hobbies sh on st.id=sh.student_id

--33 Задание

Select st.surname,
Case when position('ов' in st.surname )=0 then 'не найдено'
else position('ов' in st.surname )::varchar End as position
From students st

--34 Задание

Select RPAD(st.surname,10,'#')
From students st

--35 Задание

Select TRIM(trailing'#'from RPAD(st.surname,10,'#'))
From students st


