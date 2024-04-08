































































































{
    Se desea modelar la información necesaria para un sistema de recuentos de casos de covid
para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad de
casos activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad de casos activos, cantidad de casos
nuevos, cantidad de recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).
}

Program ej7;

Const valoralto = 9999;

Type 
  reg_det = Record
    cod_localidad: integer;
    cod_cepa: integer;
    casos_act: integer;
    casos_new: integer;
    casos_rec: integer;
    casos_rip: integer;
  End;
  reg_mister = Record
    cod_localidad: integer;
    name_localidad: String[20];
    cod_cepa: integer;
    name_cepa: integer;
    casos_act: integer;
    casos_new: integer;
    casos_rec: integer;
    casos_rip: integer;
  End;

  detalle_file = file Of reg_det;
  maestro_file = file Of reg_mister;
  array_dets = array[1..10] Of detalle_file;
  regs_dets = array[1..10] Of reg_det;

Procedure leer (Var detalles: detalle_file; Var reg: reg_det);
Begin

  If Not(Eof(detalles)) Then
    read(detalles, reg)
  Else
    reg.cod_localidad := valoralto;

End;

Procedure minimo(Var detalles: array_dets; Var regs:regs_dets; Var min: reg_det; )

Var 
  i, pos: integer;
Begin
  min.localidad := valoralto;
  For i:= 1 To 10 Do
    Begin
      If (regs[i].cod_localidad = min.cod_localidad) And (regs[i].cod_cepa < min.cod_cepa) Then
        Begin
          min := regs[i];
          pos := i;
        End;
    End;
  If (min.cod_localidad <> valoralto) Then
    leer(detalles[pos], regs[pos]);
End;


Procedure inicializar(Var archivo: array_dets; Var array_prod: regs_dets)

Var i: integer;

Var reg: producto_detalle
         Begin
           For ( i :=1; i To 30) Do
             Begin
               Assign(archivo[i], 'detalle'+i+'.dat');
               Reset(archivo[i]);
               leer(archivo[i], reg);
               array_prod[i] := reg;
             End;
         End;


Var 
  detalles: array_dets;
  array_regd: array_dets;
  reg_minimo,aux: reg_det;
  maestro: maestro_file;
  regm: reg_mister;
  i,localidades_mas_50: integer;
  casosact,casosnuevos: integer;
Begin
  Assign(maestro, 'maestro.dat');
  assignDetalles(detalles);
  leerDetalles(detalles, array_regd,reg_minimo);
  reset(maestro);
  Read(maestro, regm);
  While (reg_minimo.cod_localidad <> valoralto) Do
    Begin
      casosact := 0;
      casosnuevos := 0;
      While (regm.cod_localidad <> reg_minimo.cod_localidad) Do
        read(maestro, regm);
      While (regm.cod_localidad == reg_minimo.cod_localidad) Do
        Begin
          While (regm.cod_cepa<>reg_minimo.cod_cepa) Do
            Read(maestro, regm);
          While (regm.cod_cepa==reg_minimo.cod_cepa) Do
            Begin
              casosact := casosact + reg_minimo.casos_act;
              casosnuevos := casosnuevos + reg_minimo.casos_new;
              regm.cant_rip := regm.cant_rip + reg_minimo.cant_rip;
              regm.cant_rec := regm.cant_rec + reg_minimo.cant_rec;
              minimo(detalles, array_regd, reg_minimo);
            End;
          Seek(maestro, FilePos(maestro)-1);
          Write(maestro, regm);
        End;
      If (casosact > 50) Then
        Begin
          localidades_mas_50 := localidades_mas_50 + 1;
          writeln('Localidad con mas de 50 casos activos: ', regm.name_localidad);
        End;
    End;
  Close(maestro);
  For i:= 1 To 10 Do
    Close(detalles[i]);
  WriteLn('Cantidad de localidades con mas de 50 casos activos: ', localidades_mas_50);


End.
