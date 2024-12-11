

for f in *.dat 
do
awk 'NR % 10 == 1' $f > $f.10

done