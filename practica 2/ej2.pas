
Program ej2;

Type 
  alumno = Record
    name: string;
    cod: integer;
    mat_cursadas: integer;
    mat_aprobadas: integer;
  End;
  alumno_detalle = Record
    cod: integer;
    mat_cursadas: integer;
    mat_aprobadas: integer;
  End;
  maestro_file = file Of alumno;
  detalle_file = file Of alumno_detalle;

Var maestro: maestro_file;
  detalle: detalle_file;
  reg_alumno: alumno;
  reg_detalle: alumno_detalle;

Procedure actualizar_maestro(Var maestro: maestro_file; Var detalle: detalle_file);

Var reg_alumno: alumno;
  reg_detalle: alumno_detalle;
Begin
  Assign(maestro,'maestro.dat');
  Assign(detalle,'detalle.dat');
  Reset(maestro);
  Reset(detalle);
  While Not eof(detalle) Do
    Begin
      Read(detalle,reg_detalle);
      Read(maestro,reg_alumno);
      While (reg.alumno.cod <> reg_detalle.cod) Do
        Begin
          Read(maestro,reg_alumno);
        End;
      Seek(maestro,FilePos(maestro)-1);
      reg_alumno.mat_cursadas := reg_alumno.mat_cursadas+reg_detalle.mat_cursadas;
      reg_alumno.mat_aprobadas := reg_alumno.mat_aprobadas+reg_detalle.mat_aprobadas;
      Write(maestro,reg_alumno);
    End;
  Close(maestro);
  Close(detalle);
End;
Procedure listar(Var maestro:maestro_file);

Var nombre: string;
  alumno: alumno;
  file_text: text;
Begin
  Assign(file_text,'alumnos.txt');
  Assign(maestro,'maestro.dat');
  reset(maestro);
  Rewrite(file_text);
  While Not eof(maestro) Do
    Begin
      Read(maestro,alumno);
      If ( alumno.mat_cursadas- alumno.mat_aprobadas > 4) Then
        Write(file_text,alumno.name)
      Else WriteLn('no cumple');
    End;
  |
End;

Var selec: integer;

Begin

  WriteLn('1-Actualizar maestro');
  WriteLn('2-listar');
  ReadLn(selec);
  Case selec Of 
    1: actualizar_maestro(maestro,detalle);
    2: listar(maestro);
    Else WriteLn('no pibe');



  End.
