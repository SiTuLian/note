
use subjectSQL

--答案仅供参考！！！！！

--1. 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

select A.*,B.C#,B.score from (select * from SC where C#='01') as A
left join(select * from SC where C#='02') as B 
on A.S#=B.S#
where A.score>B.score

--1.1. 查询同时存在" 01 "课程和" 02 "课程的情况
select * from (SELECT * FROM SC WHERE C#='01') as A
inner join (select * from SC where C#='02') as B
on A.S#=B.S#

--1.2. 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )
select * from (SELECT * FROM SC WHERE C#='01') as A
left join (select * from SC where C#='02') as B
on A.S#=B.S#

--1.3. 询不存在" 01 "课程但存在" 02 "课程的情况
select * from (SELECT * FROM SC WHERE C#='01') as A
right join (select * from SC where C#='02') as B
on A.S#=B.S#
where A.C# is null

--2. 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
select A.S#, B.Sname, A.平均值  from(select S#, AVG(score) as 平均值 from SC group by S#) as A
inner join Student as B 
on A.S# = B.S#
where A.平均值>=60

--3. 查询在 SC 表存在成绩的学生信息
SELECT distinct Student.* FROM (select * from SC WHERE score is not null) as A
 inner join Student
ON Student.S# = A.S#

select * from Student where S# in (select distinct S# from SC)

--4. 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )
select B.S#, B.Sname, A.选课总数, A.总成绩 from 
(select S#, COUNT(C#) as 选课总数, SUM(score) as 总成绩 from SC group by S#) as A
right join Student as B
on A.S# = B.S#

--4.1. 查有成绩的学生信息
select * from Student where S# in (select S# FROM SC)

--5. 查询「李」姓老师的数量
select COUNT(Tname) as 数量 from Teacher where Tname like '李%'

--6. 查询学过「张三」老师授课的同学的信息
select D.* from (select T# from Teacher where Tname='张三') as A
inner join (select C#, T# from Course) as B
on A.T# = B.T#
inner join (select C#, S# from SC) as C
on B.C# = C.C#
inner join Student as D
on C.S# = D.S#

--7. 查询没有学全所有课程的同学的信息
select Student.* from (select S#, COUNT(C#) as 数量 from SC group by S# having COUNT(C#)<3) as A
inner join Student
on A.S# = Student.S#

--8. 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息
select distinct Student.* from (select C# from SC where S#='01') as A
LEFT join (select S#, C# from SC where S# != '01') as B
on A.C# = B.C#
inner join Student
on B.S# = Student.S#


--9. 查询和" 01 "号的同学学习的课程完全相同的其他同学的信息
select Student.* from (select B.S#, COUNT(B.C#) as BCount from (select C# from SC where S#='01') as A
inner join (select S#, C# from SC where S# != '01') as B
on A.C# = B.C#
group by B.S#) AS AA
inner join (Select COUNT(C#) as CCount from SC WHERE S#='01' group by S#) AS C
on AA.BCount=C.CCount
inner join Student
on AA.S#=Student.S#

--10. 查询没学过"张三"老师讲授的任一门课程的学生姓名
select Student.* from Student where S#
NOT IN(select C.S# from (select T# from Teacher where Tname = '张三') as A
inner join (select C#, T# from Course) as B
on A.T# = b.T#
inner join (select S#, C# from SC) as C
on B.C#=C.C#)

--11. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
SELECT Student.S#, Student.Sname, A.平均值 from 
(select S#, COUNT(C#) as 数量, AVG(score) as 平均值 from SC 
WHERE score<60 
group by S# 
having COUNT(C#)>=2
) as A
inner join Student
on A.S#=Student.S#

--12. 检索" 01 "课程分数小于 60，按分数降序排列的学生信息

select Student.* from (select S#, score from SC where C#='01' and score<60) AS A
INNER JOIN Student
on A.S# = Student.S#
order by A.score desc

--13. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩

select S#,max(case C# when '01' then score else 0 end)'01',
max(case C# when '02' then score else 0 end)'02',
MAX(case C# when '03' then score else 0 end)'03',AVG(score)平均分 from SC
group by S# order by 平均分 desc

/*
14. 查询各科成绩最高分、最低分和平均分：

    以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
    及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
    要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
*/

select distinct A.C#,Cname,最高分,最低分,平均分,及格率,中等率,优良率,优秀率 from SC A
left join Course on A.C#=Course.C#
left join (select C#,MAX(score)最高分,MIN(score)最低分,AVG(score)平均分 from SC group by C#)B on A.C#=B.C#
left join (select C#,(convert(decimal(5,2),(sum(case when score>=60 then 1 else 0 end)*1.00)/COUNT(*))*100)及格率 from SC group by C#)C on A.C#=C.C#
left join (select C#,(convert(decimal(5,2),(sum(case when score >=70 and score<80 then 1 else 0 end)*1.00)/COUNT(*))*100)中等率 from SC group by C#)D on A.C#=D.C#
left join (select C#,(convert(decimal(5,2),(sum(case when score >=80 and score<90 then 1 else 0 end)*1.00)/COUNT(*))*100)优良率 from SC group by C#)E on A.C#=E.C#
left join (select C#,(convert(decimal(5,2),(sum(case when score >=90 then 1 else 0 end)*1.00)/COUNT(*))*100)优秀率 
from SC group by C#)F on A.C#=F.C#

--15. 按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺

select *,RANK()over(order by score desc)排名 from SC 

--15.1. 按各科成绩进行排序，并显示排名， Score 重复时合并名次
	select *,DENSE_RANK()over(order by score desc)排名 from SC 

--16. 查询学生的总成绩，并进行排名，总分重复时保留名次空缺
select S#, sum(score) as 总成绩, RANK()over(order by sum(score) desc) as 名次
 from SC group by S#

--16.1. 查询学生的总成绩，并进行排名，总分重复时不保留名次空缺
select S#, sum(score) as 总成绩, DENSE_RANK()over(order by sum(score) desc) as 名次
 from SC group by S#

--17. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比

select distinct A.C#,Cname,[100-85],[85-70],[70-60],[60-0] from SC as A
inner join Course on A.C#=Course.C#
inner join (select C#, (CONVERT(decimal(5,2),(sum(case when score>85 and score<=100 then 1 else 0 end)*1.00)/COUNT(*))*100) as [100-85] from SC group by C#) AS B
on B.C#=A.C#
inner join (select C#, (CONVERT(decimal(5,2),(sum(case when score>70 and score<=85 then 1 else 0 end)*1.00)/COUNT(*))*100) as [85-70] from SC group by C#) AS C
on C.C#=A.C#
inner join (select C#, (CONVERT(decimal(5,2),(sum(case when score>70 and score<=60 then 1 else 0 end)*1.00)/COUNT(*))*100) as [70-60] from SC group by C#) AS D
on D.C#=A.C#
inner join (select C#, (CONVERT(decimal(5,2),(sum(case when score>60 and score<=0 then 1 else 0 end)*1.00)/COUNT(*))*100) as [60-0] from SC group by C#) as E
on E.C#=A.C#

--18. 查询各科成绩前三名的记录
select * from(select *,rank()over (partition by C# order by score desc)A from SC)B where B.A<=3

--19. 查询每门课程被选修的学生数
SELECT C#,COUNT(C#) AS 学生数 FROM SC
group by C#

--20. 查询出只选修两门课程的学生学号和姓名
SELECT A.S#, Student.Sname from (SELECT S#,COUNT(S#) AS 学生数 FROM SC
group by S#
HAVING COUNT(S#)=2) AS A
inner join Student
on A.S#=Student.S#

--21. 查询男生、女生人数
SELECT SUM(case Ssex when '男' then 1 else 0 end) as 男生人数,
SUM(case Ssex when '女' then 1 else 0 end) as 女生人数
 from Student
 
 --22. 查询名字中含有「风」字的学生信息
 select * from Student where Sname like '%风%'
 
 --23. 查询同名同性学生名单，并统计同名人数
select distinct COUNT(A.S#) as 同名人数 FROM (SELECT S#, Sname from Student) as A
inner join (SELECT S#, Sname from Student) as B
on A.Sname=B.Sname

--24. 查询 1990 年出生的学生名单
select * from Student where Sage between '1990-01-01' and '1990-12-31'

--25. 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select C#, AVG(score) as 平均成绩 from SC group by C#
ORDER BY 平均成绩 DESC, C#

--26. 查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩
SELECT Student.S#, Student.Sname, A.平均成绩
	FROM (select S#, AVG(Sc.score) as 平均成绩 from SC 
		GROUP BY S# HAVING  AVG(Sc.score)>=85) as A
	inner join Student
	on Student.S#=A.S#
	
--27. 查询课程名称为「数学」，且分数低于 60 的学生姓名和分数
select A.Sname, B.score from (select C# from Course where Cname='数学') as C
inner join (select * from SC where score<60) as B
on C.C#=B.C#
inner join Student AS A
ON A.S#=B.S#

--28. 查询所有学生的课程及分数情况（存在学生没成绩，没选课的情况）
select C.S#, C.Sname, A.Cname, B.score from (select * from Student) as C
LEFT JOIN (SELECT * FROM SC) AS B
ON C.S#=B.S#
LEFT JOIN Course AS A
ON A.C#=B.C#

--29. 查询任何一门课程成绩在 70 分以上的姓名、课程名称和分数
select A.Sname, B.Cname, C.score from (select * from SC WHERE score>70) as C
inner join Student as A
on A.S#=C.S#
inner join Course as B
on b.C#=c.C#

--30. 查询不及格的课程
select * from SC WHERE score<60

--31. 查询课程编号为 01 且课程成绩在 80 分以上的学生的学号和姓名
select A.S#, A.Sname from (select * from SC where C#='01' and score>=80) as B
inner join Student as A
on A.S#=B.S#

--32. 求每门课程的学生人数
select C#, COUNT(S#) as 学生人数 FROM SC GROUP BY C#

--33. 成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩
SELECT TOP 1 A.*, B.score from (select T# FROM Teacher WHERE Tname='张三') as C
INNER JOIN Course AS D
on C.T#=D.T#
INNER JOIN SC AS B
ON D.C#=B.C#
INNER JOIN Student AS A
ON A.S#=B.S#
ORDER BY B.score DESC

--34. 成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩
SELECT TOP 1 A.*, B.score from (select T# FROM Teacher WHERE Tname='张三') as C
INNER JOIN Course AS D
on C.T#=D.T#
INNER JOIN SC AS B
ON D.C#=B.C#
INNER JOIN Student AS A
ON A.S#=B.S#
ORDER BY B.score DESC


--35. 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩
select distinct B.* from (select * from SC) AS A
INNER JOIN (SELECT * FROM SC) AS B
on A.C#!=B.C# and A.score=B.score


--36. 查询每门功成绩最好的前两名
select * from(select *,rank()over (partition by C# order by score desc)A from SC)B where B.A<=2

--37. 统计每门课程的学生选修人数（超过 5 人的课程才统计）
select C#, COUNT(S#) AS 学生选修人数 from SC GROUP BY C#
HAVING COUNT(S#)>5

--38. 检索至少选修两门课程的学生学号
select S#, COUNT(S#) AS 学生选修人数 from SC GROUP BY S#
HAVING COUNT(S#)>=2

--39. 查询选修了全部课程的学生信息
SELECT Student.* FROM (select S#, COUNT(S#) AS 学生选修人数 from SC GROUP BY S#
HAVING COUNT(S#)=3) AS A
inner join Student
on Student.S#=A.S#

--40. 查询各学生的年龄，只按年份来算
select S#, 2018-CAST(year(Sage) as int) as 学生年龄 from Student

--41. 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一

select *,(case when convert(int,'1'+substring(CONVERT(varchar(10),Sage,112),5,8))
<convert(int,'1'+substring(CONVERT(varchar(10),GETDATE(),112/*112是将格式转化为yymmdd*/),5,8)) 
then datediff(yy,Sage,GETDATE()) 
else datediff(yy,Sage,GETDATE())-1 
end)age 
from Student

--42. 查询本周过生日的学生

select *,(case when datename(wk,convert(datetime,(convert(varchar(10),year(GETDATE()))+substring(convert(varchar(10),Sage,112),5,8))))=DATENAME(WK,GETDATE()) 
then 1 else 0 end)生日提醒
from Student

--43. 查询下周过生日的学生

select *,(case when datename(wk,convert(datetime,(convert(varchar(10),year(GETDATE()))+
substring(convert(varchar(10),Sage,112),5,8))))=DATENAME(WK,GETDATE())+1 
then 1 else 0 end)生日提醒
from Student

--44. 查询本月过生日的学生

select *,(case when month(convert(datetime,(convert(varchar(10),year(GETDATE()))+substring(convert(varchar(10),Sage,112),5,8))))=month(GETDATE())
then 1 else 0 end)生日提醒
from Student

--45. 查询下月过生日的学生

select *,(case when month(convert(datetime,(convert(varchar(10),year(GETDATE()))+substring(convert(varchar(10),Sage,112),5,8))))=month(GETDATE())+1
then 1 else 0 end)生日提醒
from Student
