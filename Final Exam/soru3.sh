# Burak Cakan - 702201003 - 25/01/2021
grep "N\|C\|H" "old.xyz" > step1.txt
awk '{print $1 "\t" $2 "\t" $3+10.0 "\t" $4}' step1.txt > step2.txt
grep -x "20" "old.xyz" > new.xyz
grep "P" "old.xyz" >> new.xyz
cat step2.txt >> new.xyz