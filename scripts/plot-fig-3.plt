
# NOTE: Gill Sans is available only on OSX.
set terminal pdfcairo transparent enhanced font "Gill Sans, 18" linewidth 2 rounded dashed

# NOTE: Clear Sans is a free font, and is a good alternative to the above.
# set terminal pdfcairo transparent enhanced font "Clear Sans, 16" linewidth 2 rounded dashed

set style line 80 lt rgb "#808080"
#set style line 81 lt 0  # dashed
set style line 81 lt 0 lc rgb "#808080"  # grey

#set style line 80 lc rgb "#404040" lt 1 lw 1
set border ls 80

#set style line 81 lc rgb "#909090" lt 0 lw 0.4
#set style line 82 lc rgb "#a4a4a4" lt 0 lw 0.2

# NOTE: Grid lines can be distracting on a map.
# set grid back xtics ytics ls 81, ls 82
set grid back ls 81

set tics in
set xtics nomirror
set ytics nomirror

# Colors chosen from colorbrewer; print- and photocopy-friendly.
set style line 1 lt 1 lc rgb "#20808080"   lw 0.5 pt  6 ps 0.5
set style line 2 lt 1 lc rgb "#99cc0000"   lw 0.1 pt  5 ps 0.3

set key bottom right opaque

#set tmargin 1
#set rmargin 1
#set bmargin 1
#set lmargin 1

#unset xlabel
#unset xtics
set xrange [0:10]
set xtics

set ylabel "Latitude" font ",18"
set xlabel "PDF (%)" font ",18" #offset 2

set ytics (-90, -45, 0, 45, 90)
#set y2tics (-40, 40)
set arrow 1 from 0,0 to 10,0 nohead dt "-" lc rgb "#808080"
set arrow 2 from 0,45 to 10,45 nohead dt ". " lc rgb "#808080"
set arrow 3 from 0,-45 to 10,-45 nohead dt ". " lc rgb "#808080"
set arrow 4 from 0,40 to 10,40 nohead dt "--" lc rgb "red"
set arrow 5 from 0,-40 to 10,-40 nohead dt "--" lc rgb "red"

#set logscale x2
set label "40 N" at 9.2,34 textcolor rgb "red" font ",16" front 
set label "40 S" at 9.2,-34 textcolor rgb "red" font ",16" front

set output '../outputs/Fig-3.pdf'

plot '../datasets/world-map/world-50m.txt' not w l ls 1 lc rgb "#A9A9A9" axes x2y1, \
    '../processedData/pop-data-per-lat.txt' using 3:1 title "Population" w l lw 1.5 dashtype "." lc rgb "blue" axes x1y1 , \
    '../processedData/submarine-endPts-per-lat.txt' using 3:1 title "Submarine endpoints" w l lw 1.5 lc rgb "#bc3908" axes x1y1 
#     'lat-lng-data.txt' u 3:2 not w p ls 2
unset output
