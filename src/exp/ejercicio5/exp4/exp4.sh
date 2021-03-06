#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
n1="$(seq 10 5 70)"

# el minimo n que puedo tener dado el m es: min n {n * (n - 1) /2 >= m} 
n2=600 #El grafo2 queda completamente fijo, el n es el mismo en los dos.
m2=2500 #Guarda que el grafo2 no sea uno especial, tipo estrella o algo asi. 
cuantosVecinosMiro=20

while getopts 'ha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 4"
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
  m1=$((3*i))
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "f3 %d %d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/../../../generador-grafo-rapido 
done

#==============================tipo1=tiempos=======================================================
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp4-f3-tipo1.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp4-f3-tipo1.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio5-tipo1 < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosVecinosMiro -t >> $(dirname $0)/tiempos-exp4-f3-tipo1.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp4-f3-tipo1.txt
done

#==============================tipo2=tiempos=======================================================

printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-exp4-f3-tipo2.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-exp4-f3-tipo2.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio5-tipo2 < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosVecinosMiro -t >> $(dirname $0)/tiempos-exp4-f3-tipo2.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-exp4-f3-tipo2.txt
done


#==============================tipo1=aristas=======================================================
printf "%d \n" 1 >> $(dirname $0)/aristas-exp4-f3-tipo1.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/aristas-exp4-f3-tipo1.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  $(dirname $0)/../../../ejercicio5-tipo1 < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosVecinosMiro | $(dirname $0)/../../../dameCantAristas >> $(dirname $0)/aristas-exp4-f3-tipo1.txt
  printf "\n" >> $(dirname $0)/aristas-exp4-f3-tipo1.txt
done


#==============================tipo2=aristas=======================================================
printf "%d \n" 1 >> $(dirname $0)/aristas-exp4-f3-tipo2.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/aristas-exp4-f3-tipo2.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  $(dirname $0)/../../../ejercicio5-tipo2 < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosVecinosMiro | $(dirname $0)/../../../dameCantAristas >> $(dirname $0)/aristas-exp4-f3-tipo2.txt

  printf "\n" >> $(dirname $0)/aristas-exp4-f3-tipo2.txt
done

#octave -q $(dirname $0)/exp1.m