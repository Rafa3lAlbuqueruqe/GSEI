# Prof. Rodrigo M. S. de Oliveira
# 2024

#Script para calcular as diferencas entre os arquivos de tensao_?.dat


script_dir=$(dirname $(readlink -f $0));

#echo $script_dir

for i in ??-*  #padrao para filtrar os diretorios
do


  echo " $i"
  cd $script_dir/$i
   rm -rf fouri_tensao_1.*
   for tensao in fouri_tensao*.dat
   do
      
       awk '$1 >= 10E6 && $1 <= 20E6' "$tensao" | awk '{print $4}'   >>  ../rna-$i.dat
       
  done
  cd ..


done

echo
echo OK
