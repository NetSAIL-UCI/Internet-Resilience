for lat in `seq 0 1 90`
do
    cat ../caida/midar-iff.nodes.geo  | awk -v lat=$lat -F "\t" '
    	BEGIN{
		sum=0; 
		count=0;
	}
	{
		currLat=$6; 
		count+=1; 
		if (sqrt(currLat^2) >= lat) {
			sum+=1
		}
	}
	END{
		print lat, sum, sum / count * 100
	}'
done
