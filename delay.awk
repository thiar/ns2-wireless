BEGIN  {
	seqno=-1;
	dp=0;
	rp=0;
	cnt=0;
}

{
if($4=="AGT" && $1=="s" && seqno<$6)
{
	seqno=$6;
}
else if(($4=="AGT") && ($1=="r"))
{
	rp++;
}
else if($1=="D" && $7=="tcp")
{
	dp++;
}
#end_end delay
if($4=="AGT" && $1=="s")
{
	start_time[$6]=$2;
}
else if(($4=="AGT") && ($1=="r"))
{
	end_time[$6]=$2;
}
else if($1=="D" && $7="tcp")
{
	end_time[$6]=-1;
}
}

END{
	for(i=0;i<=seqno;i++)
	{
		if(end_time[i]>0)
		{
			delay[i]=end_time[i]-start_time[i];
			cnt++;
			printf( "%.2f %.2f\n",start_time[i], delay[i]*1000);
		}
		else
		{
			delay[i]=-1;
		}
	}
	for(i=0;i<=seqno;i++)
	{
		if(delay[i]>0)
		{
			ssdelay=ssdelay+delay[i];
		}
	}
	#ssdelay=ssdelay/(cnt+1);
	#printf( "average ssdelay= %.2f" ,ssdelay*1000);
	#print "\n";
}