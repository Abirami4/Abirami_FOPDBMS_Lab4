/* Ques 4 */
Select count(T2.CUS_GENDER) AS No_of_Customer, T2.CUS_GENDER as Gender from 
(
select T1.CUS_ID, T1.CUS_GENDER,T1.ORD_AMOUNT, T1.ORD_ID from
(
select ord.*, cus.CUS_NAME, cus.CUS_GENDER from order1 as ord Inner join customer as cus on cus.CUS_ID = ord.CUS_ID 
having ord.ORD_AMOUNT >= '3000'
) 
AS T1
)
AS T2 group by T2.CUS_GENDER;

#-----------------------------------------------------------------

/* Ques 5 */ 
Select Q.* , product.PRO_NAME from 
(
    select cus.CUS_ID, cus.CUS_NAME, p.ORD_ID, p.ORD_AMOUNT, p.PRO_ID  from 
    (
      SELECT ord.*, sup.PRO_ID FROM order1 as ord inner join supplier_pricing as sup ON ord.PRICING_ID = sup.PRICING_ID
	)
	  AS P INNER JOIN customer as cus ON p.CUS_ID = cus.CUS_ID having CUS_ID = '2'
) as Q INNER JOIN product on  Q.PRO_ID = product.PRO_ID;

#--------------------------------------------------------------
# Ques 6  Suppliear details more than 1 product

select sup.* from supplier as sup where  sup.SUPP_ID IN
(
select sp.SUPP_ID from supplier_pricing as sp group by sp.SUPP_ID having count(sp.SUPP_ID)>3
);

#------------------------------------------------------------------
# Ques 7 Find the least expensive product from each category and print the table with category id, name, product name and price of the product

select c.CAT_ID, c.CAT_NAME, min(t3.min_price) as Min_Price from category as c
Inner join
(
select p.CAT_ID, p.PRO_NAME ,  t2.* from product as p
inner join
(
select PRO_ID, min(SUPP_PRICE) as Min_Price from supplier_pricing group by PRO_ID
) as t2 on t2.PRO_ID = p.PRO_ID
) as t3 on t3.CAT_ID = c.CAT_ID group by t3.CAT_ID ;

#------------------------------------------------------------------
# Ques 8 Display the Id and Name of the Product ordered after “2021-10-05”.
Select prod.pro_id, prod.pro_name, ord.ORD_DATE from Product as prod CROSS JOIN order1 as ord having ord.ORD_DATE = '2021-10-05';
#------------------------------------------------------------------
# Ques 9 Display customer name and gender whose names start or end with character 'A'.
select CUS_NAME, CUS_GENDER from customer where CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A' ;
#------------------------------------------------------------------
#Ques 10 Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and 
#Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average 
#Service” else print “Poor Service”. Note that there should be one rating per supplier.
##select * from supplier;
#select * from rating;
#select * from products;
#select * from customer;
#Find Rating
Select report.SUPP_ID, report.average,
case
when report.Average = 5 then 'Excellent'
when report.Average  >4 then 'Good Service'
when report.Average > 2 then 'Average'
else 'poor service'
End as Type_of_Service 

 from
(
select t2.supp_id, avg(RAT_RATSTARS) as Average from
(
select sp.SUPP_ID, t1.ord_id, t1.RAT_RATSTARS  from supplier_pricing as sp
Inner join
(
select o.PRICING_ID, r.ORD_ID, r.RAT_RATSTARS from order1 as o Inner join rating as r on o.ORD_ID = r.ORD_ID
) as t1 on sp.PRICING_ID = t1.PRICING_ID
)as t2 group by t2.supp_id
) as report;










 
 
 
 
 
 
 
 