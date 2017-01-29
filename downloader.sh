#!/bin/bash
function _menuPrincipal()
{
    echo "-----------------------------------------------"
    echo
    echo "1) Descargar información de la web"
    echo "2) Procesar información"
    echo "3) Recrear el procesador de lex"
    echo "4) Empezar con las consultas"
    echo "5) Salir"
    echo
    echo -n "Indica una opcion: "
}

function _submenu1()
{
    echo "-----------------------------------------------"
    echo
    echo "1) Ejecutar consultas"
    echo "2) Recompilar el ejecutor de consultas"
    echo "3) Borrar archivos del ejecutor de consultas"
    echo "4) Volver"
    echo
    echo -n "Indica una opcion: "
}

function _submenu2()
{
    echo "-----------------------------------------------"
    echo
    echo "1) Steam"
    echo "2) Origin"
    echo "3) Uplay"
    echo "4) Ncsoft"
    echo "5) GOG"
    echo "6) Volver"
    echo
    echo -n "Indica una opcion: "
}
 
# establecemos un valor por defecto
opc=0
 
# bucle hasta que no se pulse la opcion 4 del primer menu
until [ $opc -eq 5 ]
do
    case $opc in
        1)
        	wget https://www.instant-gaming.com/es/juegos/steam/ -O info/descargaSteam.txt
            wget https://www.instant-gaming.com/es/juegos/origin/ -O info/descargaOrigin.txt
            wget https://www.instant-gaming.com/es/juegos/uplay/ -O info/descargaUplay.txt
            wget https://www.instant-gaming.com/es/juegos/ncsoft/ -O info/descargaNcsoft.txt
            wget https://www.instant-gaming.com/es/juegos/gog-com/ -O info/descargaGOG.txt
            _menuPrincipal
            ;;
 
        2)
            ./lex/gangas Steam
            ./lex/gangas Origin
            ./lex/gangas Uplay
            ./lex/gangas Ncsoft
            ./lex/gangas GOG
            _menuPrincipal
            ;;
 
        3)
        	flex lex/procesor.l
            gcc lex.yy.c -o lex/gangas -lfl
        	_menuPrincipal
            ;;

        4)
            opc1=0
            until [ $opc1 -eq 4 ]
            do
                case $opc1 in
                    1)
                        opc2=0
                        until [ $opc2 -eq 6 ]
                        do
                            case $opc2 in
                                1)
                                    ./consultor/bin/consultas procesado/Steam.txt
                                    _submenu2
                                    ;;
                                2)
                                    ./consultor/bin/consultas procesado/Origin.txt
                                    _submenu2
                                    ;;
                                3)
                                    ./consultor/bin/consultas procesado/Uplay.txt
                                    _submenu2
                                    ;;
                                4)
                                    ./consultor/bin/consultas procesado/Ncsoft.txt
                                    _submenu2
                                    ;;
                                5)
                                    ./consultor/bin/consultas procesado/GOG.txt
                                    _submenu2
                                    ;;    
                                *)
                                    _submenu2
                                    ;;
                            esac
                            read opc2
                        done
                        _submenu1
                        ;;
                    2)
                        cd consultor/
                        make
                        cd ..
                        _submenu1
                        ;;
                    3)
                        cd consultor/
                        make mrproper
                        cd ..
                        _submenu1
                        ;;    
                    *)
                        _submenu1
                        ;;
                esac
                read opc1
            done
            _menuPrincipal
            ;;
 
        *)
            	_menuPrincipal
            ;;
    esac
    read opc
done

