#include <iostream>
#include <fstream>
#include <cstring>
#include <string>
#include <vector>
#include <stdio.h>
#include <sstream>

using namespace std;


struct juego {
  string descuento;
  string precio;
  string nombre;
};

void limpiarDescuentos(vector<juego> v){
	for(unsigned int i = 0; i < v.size(); i++){
		if(v.at(i).descuento.compare("N/A")!=0){
			v.at(i).descuento.erase(v.at(i).descuento.begin()+1);
			v.at(i).descuento.erase(v.at(i).descuento.end()-1);
		}else{
			v.at(i).descuento="0";
		}
	}
}
void imprimirJuego(juego j){
	cout << "Nombre: " <<  j.nombre << "\tPrecio: " << j.precio << "€\tDescuento: " << j.descuento << endl;
}

void descuentoMayor(vector<juego> j, int descuento){
	int des;
	cout << "\tJUEGOS DE LA PLATAFORMA CON UN DESCUENTO DE " << descuento << " O SUPERIOR" << endl;
	for(unsigned i = 0; i < j.size(); i++){
		istringstream(j.at(i).descuento) >> des;
		if(des <= descuento){
			imprimirJuego(j.at(i));
		}
	}	
}

void precioTope(vector<juego> j, double top){
	double value;
	cout << "\tJUEGOS DE LA PLATAFORMA con un precio inferior a " << top << endl;
	for(unsigned i = 0; i < j.size(); i++){
		istringstream(j.at(i).precio) >> value;
		if(value <= top){
			imprimirJuego(j.at(i));
			//cout << "Nombre: " <<  j.at(i).nombre << "\tPrecio: " << j.at(i).precio << "€\tDescuento: " << j.at(i).descuento << endl;
		}
	}	
}

void imprimirTodos(vector<juego> j){
	cout << "\tTODOS LOS JUEGOS DE LA PLATAFORMA" << endl;
	for(unsigned i = 0; i < j.size(); i++){
		imprimirJuego(j.at(i));
	}	
}

void menu(){
	cout << "-----------------------------------------------" << endl;
	cout << "\ntOpciones del Programa" << endl;
	cout << "1) Imprimir todas las ofertas de la plataforma" << endl;
	cout << "2) Imprimir los juegos con más un descuento mínimo de su elección" << endl;
	cout << "3) Imprimir los juego con un precio máximo de su elección" << endl;
	cout << "4) Volver a elegir plataforma" << endl;
}

int main(int argc, char *argv[]){
	if(argc!=2) {
		printf("Ha olvidado su nombre.\n"); 
		return -1;
	} 

	vector<juego> info;
	string cadena, subcadena;
	juego game;
   	ifstream fe(argv[1]);

   	int op, op2;
   	double op3;

   	while(!fe.eof()) {
   		int cont = 1;
      	getline(fe,cadena);
      	//cout << "\n\tCADENA COMPLETA: " << cadena << endl;
      	for ( string::iterator it = cadena.begin(); it!=cadena.end(); ++it){
      		if(*it != ';'){
      			 subcadena.push_back(*it);
      		}else{
      			switch ( cont )  
      			{  
         			case 1:
         				//cout << "\nDESCUENTO " << subcadena << endl;  
			            game.descuento=subcadena;
			            subcadena.clear();  
			            break;  
			        case 2:
			        	//cout << "\nPRECIO " << subcadena << endl;
			            game.precio=subcadena;
			            subcadena.clear();  
			            break;
			        case 3:
			        	//cout << "\nNOMBRE " << subcadena << endl;  
			            game.nombre=subcadena;  
			            subcadena.clear(); 
			            break;  
			        default:  
			            cout << " ";  
      			}
      			cont++; 
      		}
      	}
   		//cout << "Nombre: " <<  game.nombre << "\tPrecio: " << game.precio << "€\tDescuento: " << game.descuento << endl;
		
      	info.push_back (game);
   	}
   	
   	fe.close();
   	limpiarDescuentos(info);

   	do   // Walks buffer until NULL  
   	{  
   		menu();
   		cin >> op;
      	switch ( op )  
      	{  
         	case 1:  
            	imprimirTodos(info);  
            	break;  
         	case 2:
         		cout << "\nIntroduzca el descuento a buscar" << endl;
         		cin >> op2;
         		if(op2>0){
         			op2=op2*(-1);
         		}  
            	descuentoMayor(info, op2);  
            	break;
            case 3:
            	cout << "\nIntroduzca el precio máximo a buscar" << endl;
         		cin >> op3;    
            	precioTope(info,op3);  
            	break;
            case 4:  
            	cout << "\nSaliendo" << endl;  
            	break;			  
         	default:  
         		cout << "\nOpcion erronea, repita la opción" << endl;   
      	}  
   	}while ( op != 4 ); 

   	

   	//descuentoMayor(info,-50);
   	
   	//precioTope(info,10.0);

   	return 0;
}


