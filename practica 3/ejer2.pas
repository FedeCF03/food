{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}

Program ejer2;

Type 
  asistentes = Record
    nro_asist: integer;
    apellido: string;
    email: string;
    dni: integer;
  End;
  archivo = file Of asistentes;

Procedure generarArchivo(Var arc:archivo)

Var reg: nro_asist;
Begin
  Assign(arc,'archivo.dat');
  Rewrite(arc);
  leer(reg);
  While (nro_asist<>0) Do
    Begin
      Write(arc,reg);
      leer(reg);
    End;
  Close(arc);
End;

Procedure leer(Var reg:asistentes);
Begin
  writeln('Ingrese el numero de asistente');
  readln(reg.nro_asist);
  If (reg.nro_asist<>0) Then
    Begin
      writeln('Ingrese el apellido');
      readln(reg.apellido);
      writeln('Ingrese el email');
      readln(reg.email);
      writeln('Ingrese el dni');
      readln(reg.dni);
    End;
End;

Procedure eliminar_logico(Var arc:archivo;)

Var reg: asistentes;
Begin
  Assign(arc,'archivo.dat');
  Reset(arc);
  While (Not Eof(arc)) Do
    Begin
      Read(arc,reg);
      If (reg.nro_asist<0)Then
        Begin
          reg.apellido := '@'+reg.apellido;
        End;
      Write(arc,reg);
    End;

  Close(arc);

End;
