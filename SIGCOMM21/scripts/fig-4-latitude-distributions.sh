## Get Latitude Distribution of Submarine Cable Endpoints
rm ../processedData/submarine-lats-all.txt
python3 processSubmarineLatDistr.py >> ../processedData/submarine-lats-all.txt

## Get Latitude Distribution of Intertubes Dataset
rm ../processedData/intertubes-lats.txt
for lat in `seq 0 1 90`
do
    cat ../datasets/intertubes/intertubes-nodes-latlong.txt  | awk -v lat=$lat '
    BEGIN{
    	sum=0; 
	count=0;
    }
    {
	currLat=$2; 
	count+=1; 
	if (sqrt(currLat^2) >= lat) {
		sum+=1
	}
    } END{
    	print lat, sum, sum/count*100
    }' >> ../processedData/intertubes-lats.txt
done


## Get Latitude Distribution of DNS Root servers
rm ../processedData/dns-list.txt ../processedData/dnsDistr-lat.txt
python3 processDNSlocations.py >>  ../processedData/dnsDistr-lat.txt 

## Get Latitude Distribution of IXPs
rm ../processedData/ixp-list.txt ../processedData/ixpDistr-lat.txt
python processIXPdataset.py >> ../processedData/ixp-list.txt
ixpCount=`wc -l < ../processedData/ixp-list.txt`
bash getLatitudeDistr.sh ../processedData/ixp-list.txt $ixpCount >> ../processedData/ixpDistr-lat.txt

## Get Population Distribution 
rm ../processedData/pop-list.txt ../processedData/pop-data-lat.txt
cat ../datasets/population-data/gpw-v4-population-count-rev11_2020_1_deg_asc/gpw_v4_population_count_rev11_2020_1_deg.asc | \
        awk -v OFMT='%i' '{
                if(NR > 5){
                        latitude = 96 - NR;
                        for(i = 1; i <= NF; i++){
                                if($i != -9999){
                                        pop+=$i;
                                }
                        }
                        print latitude, pop;
                        pop = 0;
                }
        }' >> ../processedData/pop-list.txt

totalPop=`cat ../processedData/pop-list.txt | awk '{sum+=$2}END{print sum}'`

for lat in {90..0}
do
    cat ../processedData/pop-list.txt | awk -v lat=$lat -v tot=$totalPop '
    {
	    if ($1 >= lat || $1 <= -lat) {
		    sum += $2;
	    }
    }
    END{
    	print lat, sum, sum / tot;
    }' >> ../processedData/pop-data-lat.txt
done

gnuplot plot-fig-4.plt
gnuplot plot-fig-4-b.plt
