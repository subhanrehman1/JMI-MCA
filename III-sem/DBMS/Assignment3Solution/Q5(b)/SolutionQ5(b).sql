select * from salesmen;
select * from customers;
select * from orders;

-- 1)
select c.cname as "Customer", s.sname as "Salesmen" from customers c, salesmen s where c.snum = s.snum;

-- 2)
select c.cname "Customer", s.sname "Salesmen", s.city "City" from customers c, salesmen s where c.city = s.city order by s.city;

-- 3)
select o.onum "Orders", c.cname "Customers", s.sname "Salesmen" from orders o, customers c, salesmen s where o.cnum = c.cnum and o.snum = s.snum;

-- 4)
select * from orders where (cnum, snum) in (select c.cnum, s.snum from customers c, salesmen s where c.snum = s.snum and c.city <> s.city);

-- 5)
select cname from customers where snum in (select snum from salesmen where commission > 12)

-- 6)
select  o.onum "Order No", o.snum "Salesmen ID", o.amount "Order Amount", s.commission "Commission Rate", ((o.amount * s.commission)/100) "Salesmen Commission" from orders o, salesmen s where o.snum = s.snum and o.snum in (select distinct snum from customers where rating > 100)

-- 7)
#######################
select distinct cname "Customers" , rating "Ratings" from customers order by rating;

select rating , count(*) from customers group by rating

-- 8)
select cname "Customers", city "City" from customers where city in (select city from customers where snum = (select snum from salesmen where sname='Sejal'));

-- 9)
select c.cname "Customers", c.snum "Salesmen ID", s.sname "Salesmen Name" from customers c, salesmen s where c.snum in (select snum from customers group by snum having count(*) = 1) and c.snum = s.snum;

-- 10)
####################
select distinct cname "Customers", city "City" from customers;

-- 11)
select o.onum "Order No." , c.cname from orders o, customers c where o.cnum = c.cnum;

--12)
select cname "Customers", city "City" from Customers where rating = (select rating from customers where cname = 'Harsh') and cname <> 'Harsh';

-- 13)
select onum "Orders" from orders where snum = (select snum from salesmen where sname = 'Miti');

--14)
select onum "Orders" from orders where snum in (select snum from salesmen where city = 'Baroda');

-- 15)
select * from orders where snum in (select snum from orders where cnum = (select cnum from customers where cname = 'Harsh'))--more than one salesmen may have serviced harsh

-- 16)
##################
select * from orders where amount > (select avg(amount) from orders where odate = '04-Oct-1997')

-- 17)
select avg(commission) || ' %' "Average Commission" from salesmen where city = 'London';

-- 18)
select * from orders where snum in (select snum from salesmen where city = 'London'); -- sub Query Method

select * from orders o, customers c where ;
-- 19)
select s.sname, s.commission, c.cname, c.city from salesmen s, customers c where s.snum = c.snum  and c.city = 'London';

-- 20)
select * from customers where cnum > 1000 + (select snum from salesmen where sname = 'Sejal');

-- 21)
select count(*) "Total" from customers where rating  > (select avg(rating) from customers);

-- 22)
select * from orders where cnum = (select cnum from customers where cname = 'Chirag');
-- 23)

-- 24)
select count(*),sum(amount), snum from orders group by snum having sum(amount) > (select max(amount) from orders);

-- 25)
select sname, snum from salesmen where snum in (select snum from customers group by snum having count(*) > 1);

-- 26)
select * from orders where amount >= (select avg(amount) from orders)

-- 27)
$$$$$$$$$$$$$$$$$$4
select odate, count(*),sum(amount) from orders group by odate;

-- 28)
select s.sname "Salesmen", s.snum "Salesmen ID", c.cname "Customer", s.city "City" from salesmen s, customers c where c.city = s.city and c.snum <> s.snum order by s.sname;

-- 29)

                        --Without using Exist
select count(*) "Total" from (select snum, count(*) from customers group by snum having count(*) > 1);

-- 30)

-- 31)
select sname, snum from salesmen where snum in (select snum from customers group by snum having count(*) = 1);

-- 32)
select sname from salesmen where snum in (select snum from orders group by (snum, odate) having count(*) > 1)


-- 33)
select * from customers where exists(select * from customers where city ='Surat')

-- 34)
select snum, sname salesmen from salesmen where snum in (select distinct snum from orders where cnum in (select cnum from orders group by cnum having count(*) > 1))

-- 35)
   
-- 36)
select * from orders where amount < (select max(amount) from orders where cnum in (select cnum from customers where city = 'London'));

-- 37)
select * from customers where rating > (select max(rating) from customers where city = 'Rome') and city <> 'Rome';

-- 38)
select cname "Customers" , Rating "Ratings" from customers where rating not in (select distinct rating from customers where city = 'Surat')

-- 39)
select cname, cname, rating from customers where rating >= (select min(rating) from customers where snum = (select snum from salesmen where sname ='Sejal'))

-- 40)
                            --CTM : A customer may be from london but without any order, so fetch data from orders table instead of customers table
select * from orders where amount > (select  min(o.amount) from orders o, customers c where o.cnum = c.cnum and c.city = 'London');

-- 41)
select sname "Names" from salesmen where city = 'London' union select cname from customers where city = 'London'

-- 42)
                         --largest order on each data
select snum "Salesmen ID", odate "Date" from orders where (odate, amount) in (select odate, max(amount) from orders group by odate);
                         --smallest order on each data
select snum "Salesmen ID", odate "Date" from orders where (odate, amount) in (select odate, min(amount) from orders group by odate);
