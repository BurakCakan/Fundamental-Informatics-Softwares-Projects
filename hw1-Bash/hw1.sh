for fil in "$@"
do
grep "enthalpy new" "$fil" > step1.txt
cut -d " " -f 23 step1.txt > step2.txt
	gnuplot <<- EOF
		set xlabel "Step"
		set ylabel "Energy"
		set title "Energy over optimization Steps"
		set key right title "$fil" box
		set terminal png
		set output "${fil}.png"
		plot "step2.txt" with lines
EOF
grep "new unit-cell volume" "$fil" > step3.txt
awk '{print $8}' step3.txt > step4.txt # step4'te ANG türünden cell-volume değeri var sadece 
	gnuplot <<- EOF
		set xlabel "Step"
		set ylabel "Volume"
		set title "Volume over optimization Steps"
		set key right title "$fil" box
		set terminal png
		set output "${fil}vol.png"
		plot "step4.txt" with lines
EOF

tagE=$( tail -n 1 step2.txt )
tagV=$( tail -n 1 step4.txt )

counter=$(grep -c Ry "step1.txt")
echo -e "$fil \t$tagE Ry \t$counter \t$tagV Ang^3" >> Final.txt
sort -t$'\t' -k2 -n Final.txt > F_Vol.txt
done
echo -e "\nOUTPUT_NAME \tENERGY \t\t\tITER \tVOL"
perl -ne '/\n/ && print' F_Vol.txt #perl dosyadaki tüm değerleri bastırır. Final dosyasında en optimize değerleri basıyor her output için.
echo -e "\nLowest Energy Structure:"

head -1 F_Vol.txt > F_En2.txt
echo -e "OUTPUT_NAME \tENERGY"
m=$(awk '{print $1}' F_En2.txt)
n=$(awk '{print $2}' F_En2.txt)
echo -e "$m \t$n Ry " 

