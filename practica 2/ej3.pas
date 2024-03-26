
Program ej3;

Const valoralto = 9999;

Type 
  producto = Record
    cod: integer;
    name: string;
    desc: string;
    stock_disp: integer;
    stock_min: integer;
    price: real;
  End;
  producto_detalle = Record
    cod: integer;
    cant_vendida: integer;
  End;
  file_maestro = file Of producto;
  file_detalle = file Of producto_detalle;
  array_detalle = array[1..30] Of file_detalle;
  array_producto = array[1..30] Of producto;

Procedure inicializar(Var archivo: array_detalle; Var array_prod: array_producto)

Var i: integer;

Var reg: producto_detalle
         Begin
           For ( i :=1; i To 30) Do
             Begin
               Assign(archivo[i], 'detalle'+IntToStr(i)+'.dat');
               Reset(archivo[i]);
               read(archivo[i], reg);
               array_prod[i] := reg;
             End;
         End;


Procedure minimo(Var archivo_detalle:array_detalle; Var min:producto_detalle; Var i:integer);

Var j: integer;
Begin
  For ( j:=1 To 30) Do
    Begin
      If (producto_detalle[j].cod < min.cod) Then
    End;
End;
End;

Var 
  maestro: file_maestro;
  reg_m: producto;
  array_det: array_detalle;
  array_prod: array_producto;
  min: producto_detalle;
  i: integer
     Begin
       i := 1;
       Assign(maestro, 'maestro.dat');
       Reset(maestro);
       inicializar(array_det, array_prod);
       minimo(array_det,i,array_prod);
       While (min.cod <> valoralto) Do
         Begin
           read(maestro, reg_m);
           While (reg_m.cod <> min.cod) Do
             read(maestro, reg_m);
           While (reg_m.cod=array_prod[i].cod) Do
             Begin
               reg_m.stock_disp := reg_m.stock_disp - array_prod[i].cant_vendida;
               minimo(array_det,i,array_prod);
             End;
           seek(maestro,filepos(maestro)-1);
           write(maestro, reg_m);
         End;
       Close(maestro);

     End.
