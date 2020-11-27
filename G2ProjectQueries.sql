/*Query1
Question: Retrieve Customer and Vehicle details who has been involved in an incident and claim status
is pending.

ASSUMPTION: The claim status = 'pending' indireclty mean that the particular vehicle is met with any incident.
*/
SELECT c.*,v.* FROM
G2customer AS c,G2vehicle AS v,G2claim AS r WHERE r.G2Claim_Status='pending'AND r.G2Cust_Id=c.G2Cust_Id AND c.G2Cust_Id=v.G2Cust_Id;



/*Query2
Question: Retrieve customer details who has premium payment amount greater than the sum of all the customerIds in the database.


*/
select c.* from g2customer as c,g2premium_payment as p where p.G2Cust_Id=c.G2Cust_Id and p.G2Premium_Payment_Amount>(select
sum(c.G2Cust_ID) from g2customer as c);


/*Query3
Question: Retrieve Company details whose number of products is greater than departments, where the departments are located in more than one location

*/
SELECT i.* FROM g2insurance_company AS i JOIN  g2product as p
on p.G2Company_Name=i.G2Company_Name group by p.G2Company_Name having count(*)>
ALL(select count(d.G2Department_Name) from g2insurance_company as r join g2department as d on r.G2Company_Name=d.G2Company_Name  group by 
d.G2Department_Name having count(d.G2Department_Name)and count(r.G2Company_Location)>1);



/*
Query4
Question: Select Customers who have more than one Vehicle, where the premium for one of the Vehicles is not paid and it is involved in accident

ASSUMPTION: In G2Premium_Payment table, if the reciept id is null, then it means that the reciept isn't yet generated.
So, the premium for one of the vehicle is not paid.
*/


SELECT C.*
FROM G2CUSTOMER AS C
WHERE C.G2Cust_Id IN(
	SELECT IR.G2Cust_Id from g2incident_report AS IR
    WHERE IR.G2Incident_Type = 'accident' and IR.G2Cust_Id in (
		select P.G2Cust_Id from g2premium_payment as P
			where P.G2Receipt_Id = 'null' and P.G2Cust_Id in (
				select V.G2Cust_Id from G2VEHICLE AS V
					group by V.G2Cust_Id
					having count(V.G2Cust_Id) > 1
		)
    )  
);

 
 
 
 /*Query5
 Question: Select all vehicles which have premium more than its vehicle number.
 */
SELECT v.* FROM g2vehicle AS v,g2premium_payment AS p 
	where v.G2Cust_Id=p.G2Cust_Id and p.G2Premium_Payment_Amount>v.G2Vehicle_Number order by G2Vehicle_Id asc;
 
 
 
/*Query6
Question: Retrieve Customer details whose Claim Amount is less than Coverage Amount and Claim Amount is greater than Sum of (CLAIM_SETTLEMENT_ID, VEHICLE_ID, CLAIM_ID, CUST_ID )
*/

SELECT c.* FROM g2customer AS c INNER JOIN  g2claim_settlement  AS s ON s.G2Cust_Id=c.G2Cust_Id
INNER JOIN g2claim AS r ON (r.G2Claim_Id=s.G2Claim_Id)INNER JOIN g2coverage AS l ON (l.G2Coverage_Id=s.G2Coverage_Id AND 
r.G2Claim_Amount<l.G2Coverage_Amount AND r.G2Claim_Amount>(s.G2Claim_Settlement_Id+s.G2Vehicle_Id+s.G2Claim_Id+s.G2Cust_Id));
    
