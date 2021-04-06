set terminal png
set output "Ncircle.png"
set xlabel "N"
set ylabel "Error Value"
set title "Error values of N triangles"
set key right box
plot "errors.txt" with lines