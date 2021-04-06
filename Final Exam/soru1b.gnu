set terminal png
set output "soru1b.png"
set xlabel "N"
set ylabel "Error Value"
set title "Error values for N values"
set key right box
plot "gnudata.txt" with lines