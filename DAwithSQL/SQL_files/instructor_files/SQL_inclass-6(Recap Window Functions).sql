--  10 Oktober course scipts

-- Just recap the last session

-- compute the cumulative distribution on the height. 
select p.FIRSTNAME,p.HEIGHT,
	    CUME_DIST() over (order by p.HEIGHT) [cume dist height]
from [dbo].[PERSON] p
order by p.HEIGHT
/*
FIRSTNAME	HEIGHT	CUMDIST_HEIGHT
------------------------------------------------------------------------------
ROSEMARY	35		0,142857142857143 <==1/7  35 ve 35 den kucuk olan kac tane
ALBERT		45		0,428571428571429 <==3/7  45 ve 45 den kucuk olan kac tane
BUDDY		45		0,428571428571429 <==3/7  45 ve 45 den kucuk olan kac tane
LAUREN		54		0,571428571428571 <==4/7  54 ve 54 den kucuk olan kac tane
FARQUAR		76		0,714285714285714 <==5/7  76 ve 76 den kucuk olan kac tane
TOMMY		78		0,857142857142857 <==6/7  78 ve 78 den kucuk olan kac tane
SIMON		87		1				  <==7/7		 
----------------------------------------------------------------------------
PERCENT_RANK() computes the rank, using RANK() on the column, subtracts 1
and then divides by the number of rows minus 1
Returns the cumulative distribution value from 0 to 1
Repeated column values receive the same PERCENT_RANK() value
Formula: (rank -1) / (total_rows - 1)
*/

--Compute the percent rank on the height
select p.FIRSTNAME,p.HEIGHT,
       rank() over (order by p.HEIGHT) [rank height],
	   PERCENT_RANK() over (order by p.HEIGHT) [prcnt rnk height]
from [dbo].[PERSON] p
order by p.HEIGHT
/*
Formula: (rank -1) / (total_rows -1)
------------------------------------------------------------------------
FIRSTNAME	HEIGHT	[rank height] [prcnt rnk height]
ROSEMARY	35			1				0		<== (1-1)/(7-1)=0
ALBERT		45			2				0,1667	<== (2-1)/(7-1)=1/6
BUDDY		45			2				0,1667	<== (2-1)/(7-1)=1/6
LAUREN		54			4				0,5		<== (4-1)/(7-1)=3/6
FARQUAR		76			5				0,6667	<== (5-1)/(7-1)=4/6
TOMMY		78			6				0,8333	<== (6-1)/(7-1)=5/6
SIMON		87			7				1		<== (7-1)/(7-1)=6/6
--------------------------------------------------------------------------
PERCENTILE_DISC() function
Inverse of CUME_DIST()
Syntax:
PERCENTILE_DISC(percentile)
WITHIN GROUP (ORDER BY col1,col2,…) OVER ( … )
*/
-- Compute the height associated with the percentiles .50 and .72 ?
select p.FIRSTNAME,p.HEIGHT,
		CUME_DIST() over (order by p.HEIGHT) [cume dist height]
		,PERCENTILE_DISC(.25) WITHIN GROUP  (order by p.HEIGHT) over () [25]
		,PERCENTILE_DISC(.50) WITHIN GROUP  (order by p.HEIGHT) over () [50]
	    ,PERCENTILE_DISC(.75) WITHIN GROUP  (order by p.HEIGHT) over () [75]
from [dbo].[PERSON] p
order by p.HEIGHT
/*
FIRSTNAME                                          HEIGHT cume dist height       percnt dist 20 percnt dist 75
-------------------------------------------------- ------ ---------------------- -------------- ------------------------------
ROSEMARY                                           35     0,1428						54             78
ALBERT                                             45     0,4285						54             78
BUDDY                                              45     0,4285						54             78
LAUREN                  next highest value of 0.5=>54     0,5714						54             78
FARQUAR               next highest value of 0.58=> 76     0,7142						54             78
TOMMY                                              78     0,8571						54             78 next highest value of 0.72
SIMON                                              87     1								54             78
------------------------------------------------------------------------------------------------------------------------------*/