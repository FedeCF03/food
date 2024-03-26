














{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.
}

Program ej3p2;

Const valoralto = 9999;

Type 

  producto = Record
    codigo: integer;
    nombre: string;
    precio: real;
    stock: integer;
    stock_min: integer;
  End;

  venta = Record
    codigo: integer;
    cantidad: integer;
  End;

  maestro = file Of producto;
  detalle = file Of venta;
Procedure leer(Var det:detalle; Var v:venta);
Begin
  If Not(eof(det))Then
    read(det,v)
  Else
    v.codigo := valoralto;

End;
Procedure listarMinStock(Var maest:maestro);

Var stock_minimo = string;
  regm: producto;
Begin
  Assign(stock_minimo,'stock_minimo.txt');
  Rewrite(stock_minimo);
  Reset(maestro);
  While Not eof(maestro) Do
    Begin
      read(maestro,regm);
      If (regm.stock<regm.stock_min) Then WriteLn(stock_minimo,regm.nombre);

    End;

  Var det: detalle;
    maest: maestro;
    ven: venta;
    regm: producto;

  Begin
    Assign(maest,'maestro');
    Assign(det,'detalle');
    Reset(maest);
    Reset(det);
    leer(det,ven);
    While (det.codigo <> valoralto ) Do
      Begin
        Read(maest,regm);
        While (regm.codigo<>ven.codigo) Do
          read(maest,regm);

        While (regm.codigo = ven.codigo) Do
          Begin
            regm.stock := regm.stock - ven.cantidad;
            leer(det,ven);
          End;
        seek(maest,filepos(maest)-1);
        write(maest,regm);

      End;
    listarMinStock(maest);
    Close(maest);
    Close(det);

  End.
