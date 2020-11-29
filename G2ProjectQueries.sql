/*Query1*/
SELECT c.*,v.* 
	FROM G2customer AS c,
		 G2vehicle AS v,
		 G2claim AS r 
			WHERE r.G2Claim_Status='pending' AND 
				  r.G2Cust_Id=c.G2Cust_Id AND 
                  c.G2Cust_Id=v.G2Cust_Id;



/*Query2*/
select c.* 
	from g2customer as c,
		 g2premium_payment as p 
			where p.G2Cust_Id=c.G2Cust_Id and 
				  p.G2Premium_Payment_Amount > 
					(select sum(c.G2Cust_ID) 
							from g2customer as c);


/*Query3*/


select i.* from G2Insurance_Company as i 
	where i.G2Company_Name in 
		(select o.G2Company_Name 
			from G2Office as o 
				group by o.G2Company_Name 
                having count(distinct(o.G2address))>1 and 
					o.G2Company_Name in (select p.G2Company_Name 
												from G2Product as p 
                                                join G2Department as d on d.G2Company_Name=p.G2Company_Name 
													group by d.G2Company_Name 
                                                    having Count(distinct(G2Product_Type)) > Count(distinct(G2Department_Name))));




/*
Query4
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

 
 
 
 /*Query5*/
SELECT v.* 
	FROM g2vehicle AS v,
		 g2premium_payment AS p 
			where v.G2Cust_Id=p.G2Cust_Id and 
				p.G2Premium_Payment_Amount>v.G2Vehicle_Number 
				order by G2Vehicle_Id asc;    

/*Query6*/



SELECT c.* 
	FROM g2customer AS c 
		INNER JOIN  g2claim_settlement  AS s ON s.G2Cust_Id=c.G2Cust_Id
			INNER JOIN g2claim AS r ON (r.G2Claim_Id=s.G2Claim_Id)
				INNER JOIN g2coverage AS l ON (l.G2Coverage_Id=s.G2Coverage_Id AND 
					r.G2Claim_Amount < l.G2Coverage_Amount AND 
                    r.G2Claim_Amount > 
						(s.G2Claim_Settlement_Id + s.G2Vehicle_Id + s.G2Claim_Id + s.G2Cust_Id));
    
