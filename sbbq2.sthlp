{smcl}
{* *! 1.2 Christian Kontz 27may2019}
{cmd:help sbbq}
{hline}

{title:Title}

{phang}
{bf:sbbq} {hline 2} Identify turning points in time series
					using the BBQ algorithm (Harding and Pagan, 2002)

					
{title:Syntax}

{p 8 17 2}
{cmdab:sbbq}
[{varname}]
{ifin}
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt w:indow(#)}} window over which local minima and 
maxima are computed; default is {cmd:window(2)}{p_end}
{synopt:{opt p:hase(#)}} minimum phase
length; default is {cmd:phase(2)}{p_end}
{synopt:{opt c:ycle(#)}} minimum cycle
length; default is {cmd:cycle(5)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:by} is allowed; see {manhelp by D}.{p_end}


{title:Description}

{pstd}
{cmd:sbbq} generates a new variable "{it:varname}{cmd:_point}". 
Observation {it:j} of the new variable equals 1 if 
{it:varname}[{it:j}] is a peak, 
-1 if {it:varname}[{it:j}] is a trough, and
0 otherwise.

{pstd}
The algorithm identifies potential turning points as the
local minima and maxima in the series. Candidate points must then satisfy
two conditions: phases are at least {it:p} quarters long,
and complete cycles are at least {it:c} quarters long.


{title:Options}

{phang}
{opt window(#)} determines the number of observations #
on both sides over which
local minima and maxima are computed. 
Following Harding and Pagan (2002), the default is # = 2.

{pmore}
A candidate
peak is an observation {it:j} for which{break} 
{it:varname}[{it:j - #}], ..., {it:varname}[{it:j - 1}] <
{it:varname}[{it:j}] >{break}
{it:varname}[{it:j + 1}], ..., {it:varname}[{it:j + #}].

{pmore}
A candidate trough is an observation {it:k}
for which{break}
{it:varname}[{it:k - #}], ..., {it:varname}[{it:k - 1}] >
{it:varname}[{it:k}] <{break}
{it:varname}[{it:k + 1}], ..., {it:varname}[{it:k + #}].

{phang}
{opt phase(#)} imposes that every phase is at least # 
quarters long. In business cycle analysis, a phase is an expansion
or a contraction. The default is # = 2.

{phang}
{opt cycle(#)} imposes that every cycle is at least #
quarters long. A cycle is the period between two peaks or two
troughs. The default is # = 5.


{title:Remarks}

{pstd}
In their article, Harding and Pagan (2002) use the insights of Bry and Boschan (1971)
to produce a business cycle dating algorithm based on quarterly data. BBQ stands for "Bry and Boschan Quarterly". {break}
Nothing prevents the use of this program with monthly data, provided that the appropriate options (window, phase, and cycle) are specified.


{title:Example}

{phang}{cmd:. sysuse gnp96, clear}

{phang}{cmd:. generate lgnp = log(gnp96)}

{phang}{cmd:. sbbq lgnp, w(2) p(2)}

{phang}{cmd:. egen min_lgnp = min(lgnp)}

{phang}{cmd:. list date lgnp_point if inlist(lgnp_point,1,-1)}

{phang}{cmd:. tsline lgnp 										||}{break}
	   {cmd:  pcspike min_lgnp date lgnp date if lgnp_point==1 	||}{break}
	   {cmd:  pcspike min_lgnp date lgnp date if lgnp_point==-1,}{break}
		   {cmd:  lpattern(dash) leg(order(2 "Peaks" 3 "Troughs")) }{break}
		   {cmd:  ti("Turning Points in US LogGNP") }

		   
{title:Author}

{pstd} Philippe Bracke, London School of Economics, UK{break}
		p.bracke@lse.ac.uk
		
		
{title:References}

{phang} Bry, G., and C. Boschan (1971). 
Cyclical Analysis of Time Series: Selected Procedures and Computer Programs, NBER, New York.

{phang}Engel, James (2005). Business Cycle Dating Programs,
http://www.ncer.edu.au/data {p_end}

{phang}Harding, D. and A. Pagan (2002). 
"Dissecting the cycle: A methodological investigation," Journal of Monetary Economics, 49: 365�81.


{title:Acknowledgement}

{pstd} The GAUSS code made available by James Engel (2005) was essential in helping the author writing this program.{break}
John C. Bluedorn and Andrea Pescatori provided very useful suggestions to improve an earlier version of the code.
