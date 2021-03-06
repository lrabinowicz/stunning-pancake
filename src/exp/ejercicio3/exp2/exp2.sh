#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
n="$(seq 10 20 200)"
# el minimo n que puedo tener dado el m es: min n {n * (n - 1) /2 >= m} 

while getopts 'ha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 2"
       echo ""
       echo "    Opciones disponibles:"
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones - por defecto 1"
       echo ""
       exit 0 ;;
  esac
done

#genero archivos de entrada 
for i in $n; do
  n2=$((i/2))
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "grafosDeEntrada %d %d %d %d \n" 5 6 $i $n2 | $(dirname $0)/../../../generador-grafosEspeciales 
done

printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp2.txt

for k in $n; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp2.txt
  n2=$((k/2))
  aux=$((n2-1))
  aux2=$((n2*aux))
  m2=$((aux2/2))
  echo "Esta corriendo la instancia numero"
  echo $(dirname $0)/grafosDeEntrada/grafo-n1-$k-n2-$n2-m2-$m2.txt
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio3 < $(dirname $0)/grafosDeEntrada/grafo-n1-$k-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-exp2.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp2.txt
done

#octave -q $(dirname $0)/exp1.m