/*----- Sección de Declaraciones --------------*/

final	[\n| |\t]
espacio [ ]
numero		[0-9]*
comilla	["]
discount	\-{numero}\%|\-\-{numero}\%|"N/A"
descuento	"earch"{comilla}">"{discount}
prix 	{numero}\.{numero}
precio 	"</span>"{espacio}{prix}\€
cualquiera	.*
initdiv	"me"{comilla}>
findiv	"</div>"
namegame	{initdiv}{cualquiera}*{findiv}


%{
#include <stdio.h>
#include <string.h>
int totalNombres, totalDescuentos, totalPrecios;
FILE *fp;
%}

/*----- Sección de Reglas ----------------*/
%%

.	{}
\n	{}
{namegame}	{totalNombres++; recortex(yytext,"me\"\>",0);}
{descuento}	{totalDescuentos++; recortex(yytext,"earch\">",1);}
{precio}	{totalPrecios++; recortex(yytext,"</span> ",2);}

%%

/*----- Sección de Procedimientos --------*/
int main (int argc, char *argv[]) {
	if (argc == 2) {
		char cabecera[15] = "info/descarga";
		strcat( cabecera, argv[1] );
		strcat( cabecera, ".txt" );
		yyin = fopen (cabecera, "rt");
		if (yyin == NULL) {
			printf ("El fichero %s no se puede abrir\n", argv[1]);
			exit (-1);
		}
	}

	else 
		yyin = stdin;

	char cabecera2[15] = "procesado/";
	strcat( cabecera2, argv[1] );
	strcat( cabecera2, ".txt" );	
	
	fp = fopen ( cabecera2, "w+" );	

	yylex ();
	printf("\tOfertas\n");
	printf("Hemos encontrado %d Juegos\n",totalNombres);
	printf("Hemos encontrado %d Descuentos\n",totalDescuentos);
	printf("Hemos encontrado %d Precios\n",totalPrecios);
	fclose ( fp );
	
	return 0;
}

int recortex(char const *original, char const* inicio, int tipo){
	
	char nueva[90];
	int posicion = strlen(original) - strlen(strstr(original, inicio));
	int a;
	int b;

	

	for(a = 0; a<posicion; a++)
		nueva[a]=original[a];
	
	for(b=posicion; a< strlen(original); a++)
		nueva[a]=original[a+strlen(inicio)];

	
	switch(tipo) {

	   case 0:
	      recortarFinal(nueva,"</div>",0);
	      break;
	   case 1:
	      fputs(nueva, fp );
	      fputs(";", fp );
	      break;
	   case 2:
	      recortarFinal(nueva,"€",2);
	      break;
	   default :
	   	printf("TROLOLOLOLOLO\n");
	}	
	return 0;

}

int recortarFinal(char const *original, char const* final, int tipo){
	
	char nueva[90];
	int posicion = strlen(original) - strlen(strstr(original, final));
	int a;
	int b;

	for(a = 0; a<posicion; a++)
		nueva[a]=original[a];
	
	for(b=posicion; b< strlen(original); b++)
		nueva[b]=original[b+strlen(final)];

	fputs( nueva, fp );
	

	switch(tipo) {
	   case 0:
	      fputs( ";\n", fp );
	      break;
	   case 2:
	      fputs( ";", fp );
	      break;
	   default :
	   	printf("TROLOLOLOLOLO\n");
	}	
	return 0;

}


