



















{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}

Program ej4;

Type 
  producto = Record
    codigo: integer;
    nombre: string;
    descripcion: string;
    stock: integer;
    stock_min: integer;
    precio: real;
  End;
  detalle = Record
    codigo: integer;
    cantidad: integer;
  End;
  file_maestro = file Of producto;
  file_detalle_sucursal = file Of detalle;
  array_detalle = Array [1..30] Of file_detalle_sucursal;
  array_registros = Array [1..30] Of detalle;
Procedure inicializar(Var Arreglo:array_detalle; Var a);
Begin
  For (i:=1 To 30) Do
    Begin
      assign(Arreglo[i], 'detalle'+intToStr(i)+'.dat');
      reset(Arreglo[i]);
      Read(Arreglo[i], a[i]);
    End;
End;
Procedure cerrar(Var Arreglo:array_detalle);
Begin
  For i:=1 To 30 Do
    close(Arreglo[i]);
End;
Procedure leer(Var array_deta:array_detalle;Var array_reg:array_registros;Var i:integer);
Begin
  If (Not eof(array_deta))
    Then read(array_deta[i],array_reg[i])
  Else array_reg[i].codigo := 9999;
End;
Procedure minimo(Var array_deta:array_detalle;Var array_reg:array_registros;Var j:integer;Var min:detalle);
Begin
  min.codigo := 9999;
  For (int i=1 To 30) Do
    Begin
      If (array_reg[i].codigo < min.codigo) Then
        Begin
          min := array_reg[i];
          j := i;
        End;
      leer(array_deta,array_reg,j);
    End;

  Var maestro: file_maestro;
    detalle: array_detalle;
    regd: array_registros;
    min: detalle;
    j: integer;
    regm: producto;
    txt: Text;
  Begin
    Assign(txt, 'productos.txt');
    Rewrite(txt);
    Assign(maestro, 'maestro.dat');
    Reset(maestro);
    inicializar(detalle, regd);
    min.codigo := 0;
    While (min.codigo <> 9999) Do
      Begin
        minimo(detalle, regd, j, min);
        While (regm.codigo <> min.codigo) Do
          Begin
            read(maestro, regm);
          End;
        While (regm.codigo = min.codigo) Do
          Begin
            regm.stock := regm.stock - min.cantidad;
            minimo(detalle, regd, j, min);
          End;
        If ( regm.stock < regm.stock_min ) Then
          Begin
            Write(txt,regm.codigo);
            Write(txt,regm.nombre);
            Write(txt,regm.descripcion);
            Write(txt,regm.stock);
            Write(txt,regm.precio);
          End;
        Seek(maestro,FilePos(maestro)-1);
        Write(maestro,regm);
      End;
    close(txt);
    close(maestro);
    cerrar(detalle);
  End;
{Preguntar si esta bien el codigo, no estoy seguro si esta bien el minimo, y si esta bien el informe en el mismo procedimiento o en otro.}
