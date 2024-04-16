{8. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única. Tenga
en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido}

Program ej18;

Const valoralto = 99999;

Type 

  reg_nacimientos = Record
    nro_partida: integer;
    nombre: string;
    apellido: string;
    direccion: string;
    matricula_medico: integer;
    nombre_madre: string;
    apellido_madre: string;
    dni_madre: integer;
    nombre_padre: string;
    apellido_padre: string;
    dni_padre: integer;
  End;
  reg_fallecimientos = Record
    nro_partida: integer;
    dni: integer;
    nombre: string;
    apellido: string;
    matricula_medico: integer;
    fecha_hora: string;
    lugar: string;
  End;
  reg_maestro = Record
    nro_partida: integer;
    nombre: string;
    apellido: string;
    direccion: string;
    matricula_medico: integer;
    nombre_madre: string;
    apellido_madre: string;
    dni_madre: integer;
    nombre_padre: string;
    apellido_padre: string;
    dni_padre: integer;
    fallecio: boolean;
    matricula_medico_fallecimiento: integer;
    fecha_hora: string;
    lugar: string;
  End;
  archivo_nacimientos = file Of reg_nacimientos;
  archivo_fallecimientos = file Of reg_fallecimientos;
  archivo_maestro = file Of reg_maestro;
  array_nacimientos = array[1..50] Of archivo_nacimientos;
  regs_nacimientos = array[1..50] Of reg_nacimientos;
  regs_fallecimiento = array[1..50] Of reg_fallecimientos;
  array_fallecimientos = array[1..50] Of archivo_fallecimientos;

Procedure leer_nacimiento(Var archivo:archivo_nacimientos; Var dat:reg_nacimientos)
Begin
  If Not(Eof(archivo))
    Then
    Read(archivo,dat)
  Else
    dat.nro_partida := valoralto;

End;
Procedure leer_fallecimiento(Var archivo:archivo_fallecimientos; Var dat:reg_fallecimientos)
Begin
  If Not(Eof(archivo))
    Then
    Read(archivo,dat)
  Else
    dat.nro_partida := valoralto;
End;
Procedure minimo_nacimientos(Var nacimientos:array_nacimientos; Var regs:regs_nacimientos; Var min:reg_nacimientos)

Var i,pos: integer;
Begin
  min.nro_partida := valoralto;
  For i:=1 To 50 
    Do
    Begin
      If (min.nro_partida>regs[i].nro_partida)
        Then
        Begin
          min := regs[i];
          pos := i;
        End;

    End;
  If Not(min.nro_partida==valoralto )Then
    Begin
      leer_nacimiento(nacimientos[pos],regs[pos]);
    End;

End;
Procedure minimo_fallecimiento(Var fallecimiento:array_fallecimientos; Var regs:regs_fallecimiento; Var min:reg_fallecimientos)

Var i,pos: integer;
Begin
  min.nro_partida := valoralto;
  For i:=1 To 50 
    Do
    Begin
      If (min.nro_partida>regs[i].nro_partida)
        Then
        Begin
          min := regs[i];
          pos := i;
        End;

    End;
  If Not(min.nro_partida==valoralto )Then
    Begin
      leer_fallecimiento(fallecimiento[pos],regs[pos]);
    End;

End;

Procedure Assign_Nacimientos(nacimientos:array_nacimientos;regs:regs_nacimientos);

Var i: integer;
Begin
  For i:=1 To 50 Do
    Begin
      Assign(nacimientos[i],'nacimientos'+IntToStr(i)+'.dat');
      Reset(nacimientos[i]);
      leer_nacimiento(nacimientos[i],regs[i]);
    End;
End;
Procedure Assign_Fallecimientos(fallecimientos:array_fallecimientos;regs:regs_fallecimiento);

Var i: integer;
Begin
  For i:=1 To 50 Do
    Begin
      Assign(fallecimientos[i],'fallecimientos'+IntToStr(i)+'.dat');
      Reset(fallecimientos[i]);
      leer_fallecimiento(fallecimientos[i],regs[i]);
    End;
End;


Var 
  maestro: archivo_maestro;
  nacimientos: archivo_nacimientos;
  fallecimientos: archivo_fallecimientos;
  regs_naci: regs_nacimientos;
  regs_falle: regs_fallecimiento;
  aux,min: reg_nacimientos;
  auxF,minF: reg_fallecimientos;
  regm: reg_maestro;
Begin
  Assign(maestro,'maestro.dat');
  Rewrite(maestro);
  Assign_Nacimientos(nacimientos,regs_naci);
  Assign_Fallecimientos(fallecimientos,regs_falle);
  minimo_nacimientos(nacimientos,regs_naci,min);
  minimo_fallecimientos(fallecimientos,regs_falle,minF);
  While Not(min.nro_partida==valoralto) Do
    Begin
      regm.fallecido := False;
      regm.matricula_medico_fallecimiento: 0;
      regm.fecha_hora: ' ';
      regm.lugar: ' ';

      If (min.nro_partida==minF.nro_partida)
        Then
        Begin
          regm.fallecido := True;
          regm.matricula_medico_fallecimiento: minF.matricula_medico_fallecimiento;
          regm.fecha_hora: minF.fecha_hora;
          regm.lugar: minF.lugar;
          minimo_fallecimientos(fallecimientos,regs_falle,minF);  
      End;
      regm.nro_partida: min.nro_partida;
      regm.nombre: min.nombre;
      regm.apellido: min.apellido;
      regm.direccion: min.direccion;
      regm.matricula_medico: min.matricula_medico;
      regm.nombre_madre: min.nombre_madre;
      regm.apellido_madre: min.apellido_madre;
      regm.dni_madre: min.dni_madre;
      regm.nombre_padre: min.nombre_padre;
      regm.apellido_padre: min.apellido_padre;
      regm.dni_padre: min.dni_padre;
      Write(maestro,regm);
      minimo_nacimientos(nacimientos,regs_naci,min);


    End;

  Close(maestro);
  For i:=1 To 50 Do
    Begin
      Close(nacimientos[i]);
      Close(fallecimientos[i]);
    End;
End.
