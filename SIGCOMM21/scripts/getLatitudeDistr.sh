filename=$1
totCount=$2
for lat in `seq 0 1 90`
do
    cat $filename | awk -v lat=$lat -v tot=$totCount '
    BEGIN{
    	sum=0
    }{
    	if (sqrt($2^2) >= lat) 
		sum+=1
    }
    END{
    	print lat, sum, sum / tot * 100
    }'
done
