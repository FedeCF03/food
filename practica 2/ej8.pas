















{*/
Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.
;}

Program ej8s;

Const valor_alto = 9999;

Type 
  maestro_reg = Record
    cod_cliente : integer;
    nombre : string;
    apellido : string;
    anio : integer;
    mes : integer;
    dia : integer;
    monto : real;
  End;
  maestro_file = file Of maestro_reg;



Procedure leer(Var archivo: maestro_file;
               Var dato: maestro_reg);
Begin
  If (Not(EOF(archivo))) Then
    read (archivo, dato)
  Else
    dato.cod_cliente := valor_alto;
End;

Var 
  maestro : maestro_file;
  aux,regm : maestro_reg;
  monto_anion,monto_mes : real;
  total_ventas: Integer

                Begin
                  assign (maestro, 'maestro.dat');
                  reset (maestro);
                  leer(maestro, regm);
                  Begin
                    read(maestro, regm);
                    aux := regm;
                    total_ventas = 1;
                    While (regm.cod_cliente <> valor_alto) Do
                      Begin
                        aux = regm;
                        monto_anio := 0;
                        While (regm.anio = aux.anio) Do
                          Begin
                            monto_mes := 0;
                            monto_anio := monto_anio + regm.monto;
                            aux.mes := regm.mes;
                            While (regm.mes = aux.mes) Do
                              Begin
                                monto_mes := monto_mes + regm.monto;
                                leer(maestro,regm);
                              End;
                            WriteLn('Monto mes ' + aux.mes + ': ' + monto_mes);
                          End;
                        WriteLn('Monto añio ' + aux.anio + ': ' + monto_anio);
                        total_ventas := total_ventas + monto_anio;
                      End;
                    WriteLn('Total de ventas: ' + total_ventas);
                  End.
