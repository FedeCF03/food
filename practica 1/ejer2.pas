
Program ejer2;

Type archivo = File Of integer;

Var 
  nro,sum,cant: integer;
  arc_logico: archivo;
  // el creado
  arc_fisico: string;
  //el que usamos en el compilador
Begin
  ReadLn(arc_fisico);
  sum := 0;
  cant := 0;
  Assign(arc_logico, arc_fisico);
  Reset(arc_logico);
  While Not Eof(arc_logico) Do
    Begin
      Read(arc_logico, nro);
      If (1500>nro) Then
        Begin
          WriteLn('El numero ', nro, ' es menor a 1500');
          sum := sum+nro;
          cant := cant+1;
        End;
    End;
  Close(arc_logico);
End.
