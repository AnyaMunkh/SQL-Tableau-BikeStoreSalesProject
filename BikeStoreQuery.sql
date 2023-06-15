-- SQL query for extracting data from 8 different tables and putting them together in CTE table for the desired table format. 

WITH CTE_BikeStore AS (
SELECT ord.order_id,ord.order_date,concat(cus.first_name,' ',cus.last_name) AS Full_Name, 
cus.city, cus.state,cus.zip_code,
ite.product_id, pro.product_name,cat.category_name, bra.brand_name,ite.quantity, ite.list_price, ite.discount, 
SUM(ite.quantity*ite.list_price) -ite.discount as Revenue,
sta.staff_id, concat(sta.first_name,'',sta.last_name) as Staff_FullName,
sto.store_id, sto.store_name, sto.city AS StoreCity, sto.state AS StoreState, sto.zip_code AS StoreZip
FROM sales.orders ord
JOIN sales.order_items ite ON ord.order_id=ite.order_id
JOIN sales.customers cus ON ord.customer_id=cus.customer_id
JOIN production.products pro ON ite.product_id=pro.product_id
JOIN production.categories cat ON pro.category_id=cat.category_id
JOIN production.brands bra ON pro.brand_id=bra.brand_id
JOIN sales.staffs sta ON ord.staff_id=sta.staff_id
JOIN sales.stores sto ON ord.store_id=sto.store_id
GROUP BY ord.order_id, order_date, ite.product_id, ite.quantity, ite.list_price,ite.discount,
cus.city, cus.state,cus.zip_code,concat(cus.first_name,' ',cus.last_name), pro.product_name,cat.category_name,bra.brand_name,
sta.staff_id, concat(sta.first_name,'',sta.last_name) , sto.store_id, sto.store_name, sto.city, sto.state, sto.zip_code
)


SELECT*
FROM CTE_BikeStore 

