# Burak ÇAKAN - 702201003

grep "DOCKED: USER    Estimated Free Energy of Binding" "31137588.dlg" > step1.txt
filename="step1.txt"
nl $filename > step2.txt
awk '{print $1 "\t" $10}' step2.txt > step3.txt
sort -t$'\t' -k2 -n step3.txt > sortedstep.txt
awk '{print $2}' sortedstep.txt > gnustep.txt
	gnuplot <<- EOF
		set xlabel "Step"
		set xrange [1:10]
		set ylabel "Estimated Energy"
		set title "DOCKED:USER Free Estimated Energy of Binding"
		set key right box
		set terminal png
		set output "soru2.png"
		plot "gnustep.txt" with lines
EOF
rm -r *.txt