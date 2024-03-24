
Program ejer3;

Type 

  Empleado = Record
    nro_empleado: integer;
    Apellido_Nombre: string;
    Age: integer;
    DNI: integer;
  End;
  EmpleadoFile = file Of Empleado;

Var 
  arc_logico: EmpleadoFile;
  Emple : Empleado;
  Nombre_Archivo: string;

Procedure crearArchivo(Var EmpFile: EmpleadoFile; Var Nombre_Archivo:String);
Begin
  Assign(EmpFile, Nombre_Archivo);
  Rewrite(EmpFile);
End;

Procedure cargarArchivo(Var EmpleadoFile: EmpleadoFile);

Var Emple: Empleado;
Begin
  With Emple Do
    Begin
      Repeat
        writeln('Ingrese el numero de empleado');
        readln(nro_empleado);
        writeln('Ingrese el apellido y nombre');
        readln(Apellido_Nombre);
        writeln('Ingrese la edad');
        readln(Age);
        writeln('Ingrese el DNI');
        readln(DNI);
        write(EmpleadoFile, Emple);
      Until (Apellido_Nombre = 'FIN')
    End;
  Close(EmpleadoFile)
End;

Procedure ListarEspf(Var EmpleadoFile: EmpleadoFile; Nombre: String);

Var Emple: Empleado;
Begin
  While Not Eof(EmpleadoFile) Do
    Begin
      Read(EmpleadoFile,Emple);
      If (Emple.Apellido_Nombre=nombre) Then
        Begin
          writeln('Numero de empleado: ',Emple.nro_empleado);
          writeln('Apellido y nombre: ',Emple.Apellido_Nombre);
          writeln('Edad: ',Emple.Age);
          writeln('DNI: ',Emple.DNI);
        End;
    End;

End;

Procedure ListarTpdos(Var EmpleadoFile: EmpleadoFile);

Var Emple: Empleado;
Begin
  FilePos(EmpleadoFile,0);
  While Not Eof(EmpleadoFile) Do
    Begin
      Read(EmpleadoFile,Emple);
      writeln('Numero de empleado: ',Emple.nro_empleado);
      writeln('Apellido y nombre: ',Emple.Apellido_Nombre);
      writeln('Edad: ',Emple.Age);
      writeln('DNI: ',Emple.DNI);
    End;
End;
Procedure leerEmpleado(Var Emple:Empleado);
Begin
  ReadLn(Emple.nro_empleado);
  ReadLn(Emple.Apellido_Nombre);
  ReadLn(Emple.Age);
  ReadLn(Emple.DNI);
End;

Procedure anadirAlFinal(Var arc_logico: EmpleadoFile);

Var emple: Empleado;
Begin
  leerEmpleado(emple);
  SeekEof();
  Write(arc_logico,emple);

End;

Begin
  ReadLn(Nombre_Archivo);
  crearArchivo(arc_logico, Nombre_Archivo);
  cargarArchivo(arc_logico);
  Reset(arc_logico);
  anadirAlFinal(arc_logico);
  WriteLn('Ingrese el nombre del empleado que desea buscar');
  ListarTpdos(arc_logico);

  Close(arc_logico);
End.
