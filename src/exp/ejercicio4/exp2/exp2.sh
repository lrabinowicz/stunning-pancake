#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
n1="$(seq 448 5000 100001)"
# el minimo n que puedo tener dado el m es: min n {n * (n - 1) /2 >= m} 
n2=300000 #El grafo2 queda completamente fijo, el n es el mismo en los dos.
m2=300000 #Guarda que el grafo2 no sea uno especial, tipo estrella o algo asi. 

while getopts 'ha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 1 - Tiempo de ejecución variando cantidad de nodos"
       echo ""
       echo "    Opciones disponibles:"
       echo "        -h        Imprime este texto de ayuda."
       echo "        -a <núm>  Cantidad de iteraciones - por defecto 1"
       echo ""
       exit 0 ;;
  esac
done

#genero archivos de entrada 
for i in $n1; do
  m1 = $i*($i-1))/2 
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "%d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/f1/generador-GrafoAleatorio 
done

for i in $n1; do
  m1 = $i-1
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "%d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/f2/generador-GrafoAleatorio 
done

for i in $n1; do
  m1 = 3*$i
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "%d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/f3/generador-GrafoAleatorio 
done

for i in $n1; do
  m1 = $i^2/10
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "%d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/f4/generador-GrafoAleatorio 
done

printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp2-f1.txt
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp2-f2.txt
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp2-f3.txt
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp2-f4.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp2-f1.txt
  m1 = $k*($k-1))/2 
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio4 < $(dirname $0)/f1/grafo-n1-$k-m1-$-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-exp2-f1.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp2-f1.txt
done

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp2-f2.txt
  m1 = $k-1 
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio4 < $(dirname $0)/f2/grafo-n1-$k-m1-$-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-exp2-f2.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp2-f2.txt
done

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp2-f3.txt
  m1 = 3*$k
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio4 < $(dirname $0)/f3/grafo-n1-$k-m1-$-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-exp2-f3.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp2-f3.txt
done

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp2-f4.txt
  m1 = $k^2/10
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio4 < $(dirname $0)/f4/grafo-n1-$k-m1-$-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-exp2-f4.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp2-f4.txt
done

#octave -q $(dirname $0)/exp1.m