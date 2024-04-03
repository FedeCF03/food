{Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: departamento,
división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:}

Program ej10;

Const valoralto = 9999;

Type 
  empleado = Record
    departamento: integer;
    division: integer;
    n_empleado: integer;
    cat: integer;
    cant_horas_extras: integer;
  End;
  maestro_file = file Of empleado;
  a_real = array[0..14] Of real;

Procedure cargarArray(Var a:a_real;Var archivo:text);

Var i,categoría: integer;
Begin

  For i:=0 To 14 
    Do
    Begin
      Read(archivo,categoria);
      readln(archivo,a[categoria]);
    End;
End;
Procedure leer(Var a:maestro_file; Var e:empleado)
Begin
  If Not(Eof(a)) Then
    read(a,e)
  Else
    e.departamento := valoralto;

End;

Var 
  maestro: maestro_file;
  monto_horas: text;
  regm,aux: empleado;
  a: a_real;
  horas_division,horas_departamento: integer;
  monto_division,monto_departamento: real;


Begin
  Assign(maestro,'ej10.dat');
  Reset(maestro);
  Assign(monto_horas,'monto_horas.txt');
  Reset(monto_horas);
  cargarArray(a,monto_horas);
  leer(maestro,regm);
  While (regm.departamento <> valoralto) Do
    Begin
      aux := regm;
      monto_departamento := 0;
      horas_departamento := 0;
      While ( regm.departamento=aux.departamento) Do
        Begin
          aux.division := regm.division;
          monto_division := 0;
          horas_division := 0;
          While (regm.division= aux.division) Do
            Begin
              leer(maestro,regm);
              monto_division := monto_division + a[regm.cat]*regm.cant_horas_extras;
              horas_division := horas_division + regm.cant_horas_extras;
              WriteLn('numero emp : ' regm.n_empleado,' horas extras : ',regm.cant_horas_extras);
              WriteLn('monto emp'  + a[regm.cat]*regm.cant_horas_extras)
            End;
          WriteLn('monto division : ',monto_division);
          WriteLn('horas division : ',horas_division);
          monto_departamento := monto_departamento + monto_division;
          horas_departamento := horas_departamento + horas_division;
        End;
      WriteLn('monto departamento : ',monto_departamento);
      WriteLn('horas departamento : ',horas_departamento);

    End;

  close(maestro);
  close(monto_horas);
End.
