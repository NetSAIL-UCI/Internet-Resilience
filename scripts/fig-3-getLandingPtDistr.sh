######## Get Landing Points Distribution ###########3
rm ../processedData/submarine-landingPts.txt
python processSubmarineLandingPts.py | sort -nrk2 >> ../processedData/submarine-landingPts.txt
totCables=`wc -l < ../processedData/submarine-landingPts.txt`

## Get PDF distribution 
rm ../processedData/submarine-endPts-per-lat.txt
cat ../processedData/submarine-landingPts.txt | awk -v totCables=$totCables '
	BEGIN{
		for(i = -45; i < 46; i++){
			a[i]=0;
		}
	} {
		indx = int($2/2); 
		if($2 < 0){
			indx = indx-1;
		} 
		a[indx] += 1;
	} 
	END{
		for(i =- 45; i < 46; i++){
			print i*2, a[i], a[i] * 100 / totCables;
		}
	}' >> ../processedData/submarine-endPts-per-lat.txt


######## Get Population Distribution #########

#Get total population for computing PDF
totPopulation=`cat ../datasets/population-data/gpw-v4-population-count-rev11_2020_1_deg_asc/gpw_v4_population_count_rev11_2020_1_deg.asc | \
	awk -v OFMT='%i' '{
		if(NR > 5){
			for(i = 1; i <= NF; i++){
				if($i != -9999){
					totPop+=$i;
				}
			}
		}
	}END{print totPop}'`

# Using total population and latitude interval of 2 degree compute PDF and save to file
rm ../processedData/pop-data-per-lat.txt
cat ../datasets/population-data/gpw-v4-population-count-rev11_2020_1_deg_asc/gpw_v4_population_count_rev11_2020_1_deg.asc | \
        awk -v OFMT='%0.8f' -v totPop=$totPopulation '{
                if(NR > 5){
			latitude = 96 - NR;
                        for(i = 1; i <= NF; i++){
                                if($i != -9999){
                                        pop+=$i;
                                }
                        }
			if (latitude % 2 == 0) {
				print latitude, pop, pop * 100 / totPop;
				pop = 0;
			}
                }
        }' >> ../processedData/pop-data-per-lat.txt

gnuplot plot-fig-3.plt


