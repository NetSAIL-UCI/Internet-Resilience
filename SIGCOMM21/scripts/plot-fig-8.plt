# Note you need gnuplot 4.4 for the pdfcairo terminal.
#set terminal pdfcairo font "Helvetica,8" linewidth 4 rounded
#set size ratio 0.6
#set terminal postscript monochrome font "Helvetica, 22" linewidth 4 rounded 
set terminal pdfcairo dashed font "Gill Sans,10" linewidth 2 rounded fontscale 1.0

# Line style for axes
set style line 80 lt rgb "#808080"

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey
# set missing "?"

set grid back linestyle 81
set border 3 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
                          # to see plotted lines near the border.
                              # Also, put it in grey; no need for so much emphasis on a border.
                              set xtics nomirror
                              set ytics nomirror

set output "../outputs/Fig-8.pdf"
set ylabel "Cables failed or \n Nodes unreachable (%)" font ",10" offset -1
set xlabel "Inter-repeater distance (km)" font ",10" 

#unset key
set key above font ",9"
#set key inside top left reverse Left font ",9" # top outside
#set key samplen 1.1
#set key title "Over-allocation factor"
#set key inside top right font ",9" 
#set key above font ",7" horizontal
#set key spacing 0.5 samplen 0.5 height 0.7

set xtics font ",10" 
set xtics ("50" 50, "100" 100, "150" 150, "50" 350, "100" 400, "150" 450)
set ytics font ",10" 5 #0,.1,0.5
set style line 1 lt 1 lw 0.5
set xrange [0:500]
#set logscale y
#set yrange[0:]
#set xrange[-30:30]
set yrange[0:55]

LABEL="S_1 (High failure)"
set obj 10 rect at 100,50 lw -1 size char strlen(LABEL)-4, char 1 fc rgb "cyan" fs solid noborder 
set label 10 LABEL at 100,50 front center

LABEL="S_2 (Low failure)"
set obj 11 rect at 400,50 lw 0 size char strlen(LABEL)-4, char 1 fc rgb "cyan" fs solid noborder
set label 11 LABEL at 400,50 front center

#set label "High P_{fail}" at 70, 40 front
#set label "Low P_{fail}" at 370, 40 front

plot \
  "../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt" using 1:(($3*100)):(($4*100)) with yerrorbars notitle  lc rgb "#196F3D" pointtype 3 ps 1, \
  "../processedData/submarineCables/submarine-nonUniform-1.0-0.1-0.01-stats.txt" using 1:(($5*100)):(($6*100)) with yerrorbars notitle  lc rgb "#7D3C98" pointtype 4 ps 1, \
  "../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt" using 1:(($3*100)):(($4*100)) with yerrorbars notitle lc rgb "blue"  pointtype 1 ps 1 , \
  "../processedData/intertubes/intertubes-nonUniform-1.0-0.1-0.01-stats.txt" using 1:(($5*100)):(($6*100)) with yerrorbars notitle lc rgb "red"  pointtype 2 ps 1 , \
  "../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt" using (($1+300)):(($3*100)):(($4*100)) with yerrorbars title "Submarine Cables" lc rgb "#196F3D" pointtype 3 ps 1, \
  "../processedData/submarineCables/submarine-nonUniform-0.1-0.01-0.001-stats.txt" using (($1+300)):(($5*100)):(($6*100)) with yerrorbars title "Submarine Nodes" lc rgb "#7D3C98" pointtype 4 ps 1, \
  "../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt" using (($1+300)):(($3*100)):(($4*100)) with yerrorbars title "Intertubes Cables" lc rgb "blue" pointtype 1 ps 1, \
  "../processedData/intertubes/intertubes-nonUniform-0.1-0.01-0.001-stats.txt" using (($1+300)):(($5*100)):(($6*100)) with yerrorbars title "Intertubes Nodes" lc rgb "red"  pointtype 2 ps 1 , \

