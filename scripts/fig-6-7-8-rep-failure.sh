rm ../processedData/submarine-cable-repeaters.txt ../processedData/intertubes-repeaters.txt
python3 processSubmarineCableLengths.py >> ../processedData/submarine-cable-repeaters.txt
cat ../datasets/intertubes/intertubes-links.txt | awk '{print $0, int($3/50), int($3/100), int($3/150)}' >> ../processedData/intertubes-repeaters.txt

rm ../processedData/submarineCables/*
python3 analyzeNetworkSubmarine-uniform.py
python3 analyzeNetworkSubmarine-nonUniform.py 0.1 0.01 0.001
python3 analyzeNetworkSubmarine-nonUniform.py 1.0 0.1 0.01

rm ../processedData/intertubes/*
python3 analyzeNetworkIntertubes-uniform.py
python3 analyzeNetworkIntertubes-nonUniform.py 1.0 0.1 0.01
python3 analyzeNetworkIntertubes-nonUniform.py 0.1 0.01 0.001

gnuplot plot-fig-6a.plt
gnuplot plot-fig-6b.plt
gnuplot plot-fig-6c.plt

gnuplot plot-fig-7a.plt
gnuplot plot-fig-7b.plt
gnuplot plot-fig-7c.plt

rm ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats-50.txt >> ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats-100.txt >> ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats-150.txt >> ../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats-50.txt >> ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats-100.txt >> ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats-150.txt >> ../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt

rm ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats-50.txt >> ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats-100.txt >> ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats-150.txt >> ../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats-50.txt >> ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats-100.txt >> ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt
cat ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats-150.txt >> ../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt
