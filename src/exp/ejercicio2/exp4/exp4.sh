#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
n1="$(seq 1 1 7)"
# el minimo n que puedo tener dado el m es: min n {n * (n - 1) /2 >= m} 
n2=10 #El grafo2 queda completamente fijo, el n es el mismo en los dos.
m2=20 #Guarda que el grafo2 no sea uno especial, tipo estrella o algo asi.  
#a la hora de correr este experimento, acordarse de reutilizar los grafos de entrada del exp2


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

for i in $n1; do
  aux=$((i^2))
  m1=$((aux/10))
  echo "Esta creando el archivo numero "
  printf "%d\n " $i
  printf "f4 %d %d %d %d \n" $i $m1 $n2 $m2 | $(dirname $0)/../../../generador-grafo-rapido
done


#sin poda:

printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-sinPoda-exp4-f3.txt
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-sinPoda-exp4-f4.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-sinPoda-exp4-f3.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio2-sinPoda < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-sinPoda-exp4-f3.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-sinPoda-exp4-f3.txt
done

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-sinPoda-exp4-f4.txt
  aux=$((k^2))
  m1=$((aux/10))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio2-sinPoda < $(dirname $0)/f4/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-sinPoda-exp4-f4.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-sinPoda-exp4-f4.txt
done

#con poda:

printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-conPoda-exp4-f3.txt
printf "%d \n" $iteraciones >> $(dirname $0)/tiempos-conPoda-exp4-f4.txt

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-conPoda-exp4-f3.txt
  m1=$((3*k))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio2-conPoda < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-conPoda-exp4-f3.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-conPoda-exp4-f3.txt
done

for k in $n1; do
  printf "%d " $k >> $(dirname $0)/tiempos-conPoda-exp4-f4.txt
  aux=$((k^2))
  m1=$((aux/10))
  echo "Esta corriendo la instancia numero"
  printf "%d\n " $k
  for h in $(seq 1 $iteraciones); do
    echo "iteracion numero"
    printf "%d\n " $h
    $(dirname $0)/../../../ejercicio2-conPoda < $(dirname $0)/f4/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt -t >> $(dirname $0)/tiempos-conPoda-exp4-f4.txt
  done
  printf "\n" >> $(dirname $0)/tiempos-conPoda-exp4-f4.txt
done

#octave -q $(dirname $0)/exp1.m