






























{La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web
de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día,
idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado
por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.
}

Program ej11;

Const valoralto = 9999;

Type 
  visitas_reg = Record
    ano: integer;
    mes: integer;
    dia: integer;
    idUsuario: integer;
    tiempo: integer;
  End;
  visitas_file = file Of visitas_reg;

Procedure leer (Var archivo: visitas_file; Var dato: visitas_reg);
Begin
  If Not(EoF(archivo)) Then
    read(archivo,dato)
  Else
    dato.ano := valoralto;
End;

Var 
  archivo: visitas_file;
  regA,aux: visitas_reg;
  ano: integer;
  tiempo_ano,tiempo_mes,tiempo_dia,tiempo_user: integer;
Begin
  Assign(archivo,'visitas.dat');
  reset(archivo);
  ReadLn(ano);
  tiempo_ano := 0;
  leer(archivo,regA);
  While Not(regA.ano==ano) Do
    leer(archivo,regA);

  aux := regA;
  While ((regA.ano==ano)&& Not(regA=valoralto)) Do
    Begin
      aux := regA;
      tiempo_mes := 0;
      While ((regA.mes=aux.mes) && (regA.ano = ano)) Do
        Begin
          tiempo_dia := 0;
          aux := regA.dia;
          While ((regA.mes=aux.mes)&& (regA.ano = ano)&& (regA.dia=aux.dia)) Do
            Begin
              tiempo_user := 0;
              While ((regA.mes=aux.mes)&& (regA.ano = ano)&& (regA.dia=aux.dia)&& (regA.idUsuario==aux.idUsuario)) Do
                Begin
                  tiempo_user := tiempo_user + regA.tiempo;
                  leer(archivo,regA);
                End;
              WriteLn('idUsuario: ',aux.idUsuario,' Tiempo Total de acceso en el dia ',aux.dia,' mes ');
              tiempo_dia := tiempo_dia + tiempo_user;
            End;
          tiempo_mes := tiempo_mes + tiempo_dia;
          WriteLn('Tiempo total acceso dia ',aux.dia,' mes ',aux.mes);
        End;
      tiempo_ano := tiempo_ano + tiempo_mes;
      WriteLn('Total tiempo de acceso mes ',aux.mes);


    End;

End.
