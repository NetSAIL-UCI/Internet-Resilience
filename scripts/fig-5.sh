rm ../processedData/submarine-cable-lengths.txt
cat ../processedData/submarine-cable-repeaters.txt | awk '{print $2}' >> ../processedData/submarine-cable-lengths.txt
bash getCDF.sh ../processedData/ submarine-cable-lengths

rm ../processedData/intertubes-lengths.txt
cat ../processedData/intertubes-repeaters.txt  | awk '{print $3}' >> ../processedData/intertubes-lengths.txt
bash getCDF.sh ../processedData/ intertubes-lengths

gnuplot plot-fig-5.plt
