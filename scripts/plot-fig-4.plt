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

set output "../outputs/Fig-4.pdf"
set ylabel "Percentage above threshold" font ",10" 
set xlabel "|Latitude| threshold" font ",10" #offset 2

#unset key
set key inside top left reverse Left font ",9" # top outside
set key samplen 1.1
#set key title "Over-allocation factor"
#set key inside top right font ",9" 
#set key above font ",7" horizontal
#set key spacing 0.5 samplen 0.5 height 0.7

set xtics font ",10"
set ytics font ",10" #0,.1,0.5
set style line 1 lt 1 lw 0.5
set xrange [90:0]
#set logscale x
#set yrange[0:]
#set xrange[-30:30]
set yrange[0:100]

set arrow 1 from 40,0 to 40,100 nohead dt "--" lc rgb "red"

plot \
  "../processedData/submarine-lats-all.txt" using 1:5 title "Submarine endpoints" with lines lc rgb "blue" lw 2 lt 2 dashtype "..", \
  "../processedData/submarine-lats-all.txt" using 1:3 title "One-hop endpoints" with lines lc rgb "#5DA9E9" lw 2 lt 2 dashtype "-.", \
  "../processedData/intertubes-lats.txt" using 1:3 title "Intertubes endpoints" with line lc rgb "#FF7F11" lw 2 dashtype "--", \
  "../processedData/pop-data-lat.txt" using 1:(($3*100)) title "Population" with lines lc rgb "#196F3D" lw 2

