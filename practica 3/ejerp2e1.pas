{
    . El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran
todos los productos que comercializa. De cada producto se maneja la siguiente
información: código de producto, nombre comercial, precio de venta, stock actual y
stock mínimo. Diariamente se genera un archivo detalle donde se registran todas las
ventas de productos realizadas. De cada venta se registran: código de producto y
cantidad de unidades vendidas. Resuelve los siguientes puntos:
a. Se pide realizar un procedimiento que actualice el archivo maestro con el
archivo detalle, teniendo en cuenta que:
i. Los archivos no están ordenados por ningún criterio.
ii. Cada registro del maestro puede ser actualizado por 0, 1 ó más registros
del archivo detalle.
b. ¿Qué cambios realizaría en el procedimiento del punto anterior si se sabe que
cada registro del archivo maestro puede ser actualizado por 0 o 1 registro del
archivo detalle?

}

Program ejerp2e1;

Const valoralto = 9999;

Type 
  reg_maestro = Record
    cod: integer;
    nombre: string;
    precio: real;
    stock: integer;
    stock_min: integer;
  End;
  reg_detalle = Record
    cod: integer;
    cant: integer;
  End;
  maestro = file Of reg_maestro;
  detalle = file Of reg_detalle;


Procedure leer_maestro(Var a:maestro; Var r:reg_maestro)
Begin
  If Not(Eof(a))
    Then
    Begin
      Read(a,r)
    End
  Else
    r.cod = valoralto;
End;
Procedure leer_detalle(Var a:detalle; Var r:detalle)
Begin
  If Not(Eof(a))
    Then
    Begin
      Read(a,r)
    End
  Else
    r.cod = valoralto;
End;


Procedure actualizacion(Var a:maestro; Var d:detalle)

Var regD: reg_detalle;
  regM: reg_maestro;
  cantV,pos: Integer;
Begin
  leer_maestro(a,regM);
  leer_detalle(d,regD);
  pos := FilePos(a)-1;
  cantV := 0;
  While (regM.cod<>valoralto) Do
    Begin
      While (regD.cod<>valoralto) Do
        Begin
          If (redD.cod==redM.cod)Then
            cantV := cantV+redD.cant;
          leer_detalle(d,regD);
        End;
      Seek(a,pos);
      regM.stock := regM.stock-cantV;
      Write(a,regM);
      Read(a,RegM);
      pos  := FilePos(a)-1;
      cantV := 0;
      Seek(d,0);
      leer_detalle(d,regD);
    End;


End;
