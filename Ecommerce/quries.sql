/*
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
-----------------------------------------------------------------
*/
SELECT *
FROM product JOIN order1 ON product.CAT_ID = order1.CUS_ID
JOIN customer ON order1.CUS_ID = customer.CUS_ID;