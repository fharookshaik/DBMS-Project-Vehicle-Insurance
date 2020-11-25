/*Query1*/
SELECT c.*,v.* FROM
g2customer AS c,g2vehicle AS v,g2claim AS r WHERE r.Claim_Status='pending'AND r.Cust_Id=c.Cust_Id AND c.Cust_Id=v.Cust_Id;



/*Query2*/
select c.* from g2customer as c,g2premium_payment as p where p.Cust_Id=c.Cust_Id and p.Premium_Payment_Amount>(select
sum(c.Cust_ID) from g2customer as c);



/*Query3*/
SELECT i.* FROM g2insurance_company AS i JOIN  g2product as p
on p.Company_Name=i.Company_Name group by p.Company_Name having count(*)>
ALL(select count(d.Department_Name) from g2insurance_company as r join g2department as d on r.Company_Name=d.Company_Name  group by 
d.Department_Name having count(d.Department_Name)and count(r.Company_Location)>1);



/*Query4*/
SELECT c.* FROM g2customer as c JOIN g2vehicle AS v ON c.Cust_Id=v.Cust_Id JOIN g2premium_payment AS g
ON g.Cust_Id =v.Cust_Id JOIN g2incident_report AS i ON i.Cust_Id=g.Cust_Id AND g.Premium_Payment_Amount=0 AND i.Incident_Type='accident'
 GROUP BY i.Cust_Id HAVING count(i.Cust_Id)>1;
 
 
 
 /*Query5*/
 SELECT v.* FROM g2vehicle AS v,g2premium_payment AS p 
	where v.Cust_Id=p.Cust_Id and p.Premium_Payment_Amount>v.Vehicle_Number order by Vehicle_Id asc;
/*Query6*/



SELECT c.* FROM g2customer AS c INNER JOIN  g2claim_settlement  AS s ON s.Cust_Id=c.Cust_Id
INNER JOIN g2claim AS r ON (r.Claim_Id=s.Claim_Id)INNER JOIN g2coverage AS l ON (l.Coverage_Id=s.Coverage_Id AND 
r.Claim_Amount<l.Coverage_Amount AND r.Claim_Amount>(s.Claim_Settlement_Id+s.Vehicle_Id+s.Claim_Id+s.Cust_Id));

