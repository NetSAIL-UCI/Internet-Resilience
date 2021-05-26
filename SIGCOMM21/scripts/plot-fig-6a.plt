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

set output "../outputs/Fig-6a.pdf"
set ylabel "Cables failed (%)" font ",10" #offset -1
set xlabel "Probability of repeater failure" font ",10" #offset 2

#unset key
set key inside top left font ",10"
#set key above font ",9"
#set key inside top left reverse Left font ",9" # top outside
#set key samplen 1.1
#set key title "Over-allocation factor"
#set key inside top right font ",9" 
#set key above font ",7" horizontal
#set key spacing 0.5 samplen 0.5 height 0.7

set xtics font ",10"
set ytics font ",10" 20 #0,.1,0.5
set style line 1 lt 1 lw 0.5
set logscale x
set yrange[0:]

plot \
  "../processedData/submarineCables/submarine-uniform-stats-50.txt" using 2:(($3*100)):(($4*100)) with yerrorbars title "Submarine" lc rgb "#196F3D"  lt 2 pointtype 3, \
  "../processedData/submarineCables/submarine-uniform-stats-50.txt" using 2:(($3*100)) with lines notitle lc rgb "#196F3D"  lt 2, \
  "../processedData/intertubes/intertubes-uniform-stats-50.txt" using 2:(($3*100)):(($4*100)) with yerrorbars title "Intertubes" lc rgb "blue" lt 2 pointtype 1 , \
  "../processedData/intertubes/intertubes-uniform-stats-50.txt" using 2:(($3*100)) with lines notitle lc rgb "blue", \


