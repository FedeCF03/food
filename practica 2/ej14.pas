



























































































{
{Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua, # viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización del archivo maestro, se debe proceder de la siguiente manera:
● Al valor de viviendas sin luz se le resta el valor recibido en el detalle.
● Idem para viviendas sin agua, sin gas y sin sanitarios.
● A las viviendas de chapa se le resta el valor recibido de viviendas construidas
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad}
{de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas)}

Program ejer14;

Const valoralto = 9999;

Type 
  maestro_reg = Record
    codigo_pcia = integer;
    nombre_pcia: string;
    cod_localidad: integer;
    nombre_localidad: string;
    sin_luz: integer;
    sin_gas: integer;
    sin_agua: integer;
    de_chapa: integer;
    sin_sanitarios: integer;
  End;
  detalle_reg = Record
    codigo_pcia: integer;
    cod_localidad: integer;
    con_luz: integer;
    construidas: integer;
    con_agua: integer;
    con_gas: integer;
    sanitarios: integer;
  End;
  maestro_file = file Of maestro_reg;
  detalle_file = file Of detalle_reg;
  array_detalles = array [1..10] Of detalle_file;
  array_regd = array [1..10] Of detalle_reg;

Procedure minimo(Var archivo:array_detalles; regd:array_regd; Var min:detalle_reg)

Var i,pos: integer;
Begin
  min.codigo_pcia = valoralto;
  For  i:=1 To 10 Do
    Begin
      If ((regd[i].codigo_pcia <= min.codigo_pcia ) And (regd[i].cod_localidad<=min.cod_localidad)  ) Then
        Begin
          min := regd[i];
          pos := i;
        End;

    End;
  If (min.codigo_pcia <> valoralto )Then
    Begin
      leer(archivo[pos],regd[i]);
    End;

End;

Procedure leer(Var archivo:detalle_file; Var reg:detalle_reg)
Begin
  If Not(Eof(archivo))Then
    Read(archivo,reg)
  Else reg.codigo_pcia := valoralto;
End;
Procedure leer(Var archivo:detalle_file; Var regd:detalle_reg)
Begin
  If Not(Eof(archivo))Then
    Begin
      Read(archivo,regd)
    End
  Else regd.codigo_pcia := valoralto

End;
Procedure inicializar(Var detalles:array_detalles; Var regs: array_regd)

Var i: integer;
Begin
  For i:=1 To 10 Do
    Begin
      Assign(detalles[i],'detalle'+i+'.dat');
      Reset(detalles[i]);
      leer(detallesÑ[i],regs[i]);
    End;
End;

Var 
  maestro: maestro_file;
  detalles: array_detalles;
  min,aux: detalle_reg;
  regs: array_regd;
  regm: maestro_reg;
  cant_sinchapita: integer;
Begin
  cant_sinchapita := 0;
  Assign(maestro,'maestro.dat');
  inicializar(detalles,regs);
  reset(maestro);
  minimo(detalles,regs,min);
  While Not(min.codigo_pcia==valoralto) Do
    Begin
      aux := min;
      Read(maestro,regm);
      While Not(regm.codigo_pcia == min.codigo_pcia)
            Read(maestro,regd);
            While (min.codigo_pcia== aux.codigo_pcia) Do
        Begin
          aux := min.cod_localidad;
          While Not(regm.cod_localidad==min.cod_localidad)
                Read(maestro,regm);
                While (min.cod_localidad==aux.cod_localidad) Do
            Begin
              regm.sin_lux := regm.sin_lux-min.con_luz;
              regm.sin_gas := regm.sin_gas-min.con_gas;
              regm.sin_agua := regm.sin_agua-min.con_agua;
              regm.de_chapa := regm.de_chapa-min.construidas;
              minimo(detalles,regs,min);
            End;
          If (regm.de_chapa==0)Then
            cant_sinchapita := cant_sintchapita+1;
          Seek(maestro,FilePos(maestro)-1);
          Write(maestro,regm);
        End;

    End;
  write(cant_sinchapita);
  close(maestro);
  clouser(detalles);

End.
