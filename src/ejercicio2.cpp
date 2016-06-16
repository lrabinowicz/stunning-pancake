#include <vector>
#include <iostream>

using namespace std;

bool estaRepetido(int j, vector<int> mapeo, int k) {
	bool respuesta = false;
	for (int h = 0; h < k; h++){
		if (j == mapeo[h]) {
			respuesta = true;
		}
	}
	return respuesta;
}

bool estanTodosVacios(vector<vector<int > > verticesPosibles) {
	bool respuesta = true;
	for (int i = 0; i < verticesPosibles.size(); i++) {
		if (verticesPosibles[i].size() != 0) {
			respuesta = false;
		}
	}
	return respuesta;
}

bool aparece(vector<int> mapeo, vector<vector<int > > grafoGrande, int i, int j) {
	int vertice1 = mapeo[i];
	int vertice2 = mapeo[j];
	bool respuesta = false;
	for (int i = 0; i < grafoGrande[vertice1].size(); i++) {
		if (grafoGrande[vertice1][i] == vertice2) {
			respuesta = true;
		}
	}
	return respuesta;
}

vector<pair<int, int> > calcularConjAristas(vector<int> mapeo, vector<vector<int > > grafoChico, vector<vector<int > > grafoGrande) {
	vector<pair<int, int> > respuesta; //para este mapeo, cual es el subgrafo comun maximo
	pair<int, int> arista;
	for (int i = 0; i < grafoChico.size(); i++) { //nos fijamos si la arista que esta en el grafoChico, aparece en el grafoGrande (con este mapeo)
		for (int j = 0; j < grafoChico[i].size(); j++) {
			if (aparece(mapeo, grafoGrande, i, j)) {
				arista.first = i;
				arista.second = j;
				respuesta.push_back(arista);
			}
		}
	}
	return respuesta;
}


vector<pair<int, int > > MCS(vector<int> mapeo, vector<vector<int > > verticesPosibles, vector<pair<int, int> > mejorActual, int tamGrande, vector<vector<int > > grafoChico, vector<vector<int > > grafoGrande) { //en mejorActual tengo el conjunto de aristas que representa el MCS hasta el momento
	if (estanTodosVacios(verticesPosibles)) {
		return mejorActual;
	} else {
		if (verticesPosibles[verticesPosibles.size()-1].size() == 0) { // esta vacio el ultimo?
			int ultimoNoVacio;
			for (int i = verticesPosibles.size() - 1; i >= 0; i--) { //buscamos el ultimo no vacio
				if (verticesPosibles[i].size() != 0) {
					ultimoNoVacio = i;
					break;
				}
			}
			int dameUno = verticesPosibles[ultimoNoVacio].back();
			verticesPosibles[ultimoNoVacio].pop_back(); //sinUno
			mapeo[ultimoNoVacio] = dameUno;
			for (int k = ultimoNoVacio + 1; k < mapeo.size(); k++) { //llenamos todos los conjuntos siguientes (ya que todos estan vacios)
				for (int j = 0; j < tamGrande; j++) {
					if (!estaRepetido(j, mapeo, k)) {
						verticesPosibles[k].push_back(j);
					}					
				}
				dameUno = verticesPosibles[k].back();
				verticesPosibles[k].pop_back(); //sinUno
				mapeo[k] = dameUno;
			}
		} else {
			int dameUno = verticesPosibles[verticesPosibles.size()-1].back();
			verticesPosibles[verticesPosibles.size()-1].pop_back(); //sinUno
			mapeo[verticesPosibles.size()-1] = dameUno;
		}
		vector<pair<int, int> > nuevasAristas = calcularConjAristas(mapeo, grafoChico, grafoGrande);
		vector<pair<int, int > > respuesta;
		if (nuevasAristas.size() > mejorActual.size() ) {
			respuesta = MCS(mapeo, verticesPosibles,nuevasAristas,tamGrande, grafoChico, grafoGrande);
		} else {
			respuesta = MCS(mapeo, verticesPosibles,mejorActual,tamGrande, grafoChico, grafoGrande);
		}
		return respuesta;
	}

}


int main() {
	int m1, n1, m2, n2;
	cin >> n1 >> m1 >> n2 >> m2;
	vector<vector<int> > grafo1;
	vector<vector<int> > grafo2;

	vector<int> vacio;

	for (int i = 0; i < n1; i++) {
		grafo1.push_back(vacio);
	}

	for (int i = 0; i < n2; i++) {
		grafo2.push_back(vacio);
	}

	int v1, v2;

	for (int i = 0; i < m1; i++) {
		cin >> v1 >> v2;
		grafo1[v1].push_back(v2);
		grafo1[v2].push_back(v1);
	}

	for (int i = 0; i < m2; i++) {
		cin >> v1 >> v2;
		grafo2[v1].push_back(v2);
		grafo2[v2].push_back(v1);
	}

	vector<vector<int > > verticesPosibles;
	vector<int> mapeo;
	if (n1 < n2) {
		for (int i = 0; i < n1; i++) {
			mapeo.push_back(i);
			verticesPosibles.push_back(vacio);
			for (int k = i + 1; k < n2; k++) {
				verticesPosibles[i].push_back(k);
			}
		}
	} else {
		for (int i = 0; i < n2; i++) {
			mapeo.push_back(i);
			verticesPosibles.push_back(vacio);
			for (int k = i + 1; k < n1; k++) {
				verticesPosibles[i].push_back(k);
			}
		}
	}
	
	vector<pair<int, int> > mejorActual;

	//MCS(vector<int> mapeo, vector<vector<int > > verticesPosibles, vector<pair<int, int> > mejorActual, int tamGrande, vector<vector<int > > grafoChico, vector<vector<int > > grafoGrande)
	if (n1 > n2) {
		vector<pair<int, int> > maxcomsub = MCS(mapeo, verticesPosibles, mejorActual, n1, grafo2, grafo1);
	} else {
		vector<pair<int, int> > maxcomsub = MCS(mapeo, verticesPosibles, mejorActual, n2, grafo1, grafo2);
	}

	cerr 

	return 0;
}