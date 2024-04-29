{Se cuenta con un archivo con información de las diferentes distribuciones de linux
existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de
versión del kernel, cantidad de desarrolladores y descripción. El nombre de las
distribuciones no puede repetirse. Este archivo debe ser mantenido realizando bajas
lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.
Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
a. ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve
verdadero si la distribución existe en el archivo o falso en caso contrario.
b. AltaDistribución: módulo que lee por teclado los datos de una nueva
distribución y la agrega al archivo reutilizando espacio disponible en caso
de que exista. (El control de unicidad lo debe realizar utilizando el módulo
anterior). En caso de que la distribución que se quiere agregar ya exista se
debe informar “ya existe la distribución”.
c. BajaDistribución: módulo que da de baja lógicamente una distribución 
cuyo nombre se lee por teclado. Para marcar una distribución como
borrada se debe utilizar el campo cantidad de desarrolladores para
mantener actualizada la lista invertida. Para verificar que la distribución a
borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir
se debe informar “Distribución no existente”}

Program ejer8;

Type 
  distribucion = Record
    nombre: string;
    anio: integer;
    version: integer;
    cantDesarrolladores: integer;
    descripcion: string;
    pos: integer;
  End;

  archivo = file Of distribucion;

Procedure ExisteDistribucion(Var a:archivo; nombre:String);

Var res: Boolean;
  d: distribucion;
Begin
  res := false;
  Reset(a);
  leerDistri(a,d);
  While (d.nombre<>valoralto && d.nombre<>nombre) Do
    Begin

      leerDistri(a,d);
    End;
  If (d.nombre==nombre)Begin
     res:=true;
     End;

     close(a);
     return res;
     End;
     Procedure recuperarEspacio(Var a:archivo; r:distribucion)
     Var cabe,aux:distribucion;
     pos:integer;
     Begin
     Reset(a);
     ReadLn(a,cabe);
     leerDistri(a,aux);
     While ((aux.nombre <> r.nombre ) && (aux.nombre<>valoralto)) Do
     leerDistri(a,aux);
     If(aux.nombre<>r.nombre)Then
    Begin

      If (cabe.cantDesarroladores<0)Then
        Begin
          pos := cabe.pos*-1;
          Seek(a,pos);
          Read(a,aux);
          Seek(a,FilePos(a)-1);
          Write(a,r);
          Seek(a,0);
          Write(a,aux);
        End
      Else
        Begin
          Seek(a,FileSize(a)-1);
          Write(a,r);
        End;

    End
  Else WriteLn('ya existe la distri');

  close(a);


End;

Procedure BajaDistribución (Var a : archivo)Then

Var n: string;

Var cabeza,aux,reg: distribucion;
Begin
  ReadLn(n);
  Read(a,cabeza);
  leerDistri(a,aux);
  While (aux.nombre<>n && aux.nombre<>valoralto) Do
    leerDistri(a,aux);
  If (aux.nombre<>nombre)Then
    Begin
      WriteLn('no existe esa distri')
    End
  Else
    Begin
      Seek(a,aux.pos);
      write(a,cabeza);
      Seek(a,0);
      aux.cantDesarrolladores := aux.cantDesarrolladores*-1;
      Write(a,aux);
    End;

End;
