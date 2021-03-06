#!/bin/bash 

LC_NUMERIC="en_US.UTF-8"

iteraciones=1
n1="$(seq 10 5 70)"
# el minimo n que puedo tener dado el m es: min n {n * (n - 1) /2 >= m} 
n2=50 #El grafo2 queda completamente fijo, el n es el mismo en los dos.
m2=200 #Guarda que el grafo2 no sea uno especial, tipo estrella o algo asi. 
tamTabu=10
cuantosMiro=20
z=10
cuantoDejoCorrer=3e-06

while getopts 'ha:' opt; do
  case $opt in
    a) iteraciones=$OPTARG ;;
    h) echo ""
       echo "    Experimento 3"
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

#==============================tipo1=aristas=======================================================

printf "%d \n" 1 >> $(dirname $0)/aristas-ej4-exp3-f3.txt
printf "%d \n" 1 >> $(dirname $0)/aristas-ej5-exp3-f3-tipo1.txt
printf "%d \n" 1 >> $(dirname $0)/aristas-ej6-exp3-f3-tipo1.txt


  for k in $n1; do
    printf "%d " $k >> $(dirname $0)/aristas-ej4-exp3-f3.txt
    m1=$((3*k))
    echo "Esta corriendo la instancia numero"
    printf "%d\n " $k
    $(dirname $0)/../../../ejercicio4 < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt | $(dirname $0)/../../../dameCantAristas >> $(dirname $0)/aristas-ej4-exp3-f3.txt
    printf "\n" >> $(dirname $0)/aristas-ej4-exp3-f3.txt
  done


  for k in $n1; do
    printf "%d " $k >> $(dirname $0)/aristas-ej5-exp3-f3-tipo1.txt
    m1=$((3*k))
    echo "Esta corriendo la instancia numero"
    printf "%d\n " $k
    $(dirname $0)/../../../ejercicio5-tipo1-tiempo < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosMiro $cuantoDejoCorrer | $(dirname $0)/../../../dameCantAristas >> $(dirname $0)/aristas-ej5-exp3-f3-tipo1.txt
    printf "\n" >> $(dirname $0)/aristas-ej5-exp3-f3-tipo1.txt
  done

  for k in $n1; do
    printf "%d " $k >> $(dirname $0)/aristas-ej6-exp3-f3-tipo1.txt
    m1=$((3*k))
    echo "Esta corriendo la instancia numero"
    printf "%d\n " $k
    $(dirname $0)/../../../ejercicio6-tipo1-tiempo < $(dirname $0)/f3/grafo-n1-$k-m1-$m1-n2-$n2-m2-$m2.txt $cuantosMiro $tamTabu $z $cuantoDejoCorrer | $(dirname $0)/../../../dameCantAristas >> $(dirname $0)/aristas-ej6-exp3-f3-tipo1.txt
    printf "\n" >> $(dirname $0)/aristas-ej6-exp3-f3-tipo1.txt
  done
#octave -q $(dirname $0)/exp3.m