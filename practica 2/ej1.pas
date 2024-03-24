
Program ej1;

Const valorAlto = 9999;

Type 
  empleado = Record
    cod: integer;
    name: string;
    mnt: double;
  End;
  file_empleado = file Of empleado;

Var 
  file_emple1: file_empleado;
  file_new: file_empleado;
  reg,reg_anterior: empleado;

Procedure leer (Var archivo:file_empleado; Var dato:empleado);
Begin
  If (Not eof( archivo ))
    Then read (archivo,dato)
  Else dato.cod := valoralto;
End;

Begin
  Assign(file_emple1, 'empleados.dat');
  reset(file_emple1);
  Assign(file_new, 'empleados2.dat');
  rewrite(file_new);

  While Not eof(file_emple1 ) Do
    Begin
      Read(file_emple1, reg_anterior);
      While  Not Eof(file_emple1) Do
        Begin
          Read(file_emple1, reg);
          If (reg_anterior.cod = reg.cod) Then
            reg_anterior.mnt := reg_anterior.mnt + reg.mnt
          Else
            Begin
              Write(file_new, reg_anterior);
              reg_anterior := reg;
            End;
        End;
    End;
  Close(file_emple1);
  Close(file_new);
End.
