
SRC = src
INC = include
OBJ = obj
BIN = bin
LIB = lib
CXX = g++
CPPFLAGS = -Wall -g -c -I$(INC)

all: $(BIN)/consultas
	
# ************ documentación *******
documentacion:
	doxygen doc/doxys/Doxyfile

# ************ Compilación de módulos ************
$(BIN)/consultas : $(OBJ)/consultas.o 
	$(CXX) $^ -o $@ -Llib

$(OBJ)/consultas.o : $(SRC)/consultas.cpp 
	$(CXX) $(CPPFLAGS) -o $@ $^ -I$(INC)


# ************ Limpieza ************
clean :
	echo "Limpiando..."
	-rm $(OBJ)/* $(SRC)/*~ $(INC)/*~ ./*~

mrproper : clean
	-rm $(BIN)/* doc/html/*


