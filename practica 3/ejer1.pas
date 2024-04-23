{
    Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados),
agregándole una opción para realizar bajas copiando el último registro del archivo en
la posición del registro a borrar y luego truncando el archivo en la posición del último
registro de forma tal de evitar duplicados
}

Program ejercicio1;

Type 
  empleado = Record
    numero: integer;
    apellido: string[20];
    nombre: string[15];
    edad: integer;
    dni: integer;
  End;
  archivo = file Of empleado;

Procedure bajas(Var arc: archivo; num: integer);

Var e: empleado;
  pos: integer;
Begin
  reset(arc);
  Read(arc, e);
  While (num<>e.numero) Do
    Read(e);
  pos := FilePos(arc)-1;
  While Not(Eof(arc)) Do
    Read(arc,e);
  Seek(arc,FilePos(arc)-1);
  Write(arc,null);
  Seek(arc,pos);
  Write(arc,e);
  close(arc);

End;

//-----------------------MENU DE OPCIONES-----------------------
Procedure menuOpciones(Var arc: archivo);

Var 
  opcion: integer;


Var 
  arc: archivo;
  nombre: string[15];
Begin
  writeln('Ingrese un nombre del archivo');
  readln(nombre);
  assign(arc, nombre);
  rewrite(arc);
  cargarEmpleados(arc);
  menuOpciones(arc);
End.
