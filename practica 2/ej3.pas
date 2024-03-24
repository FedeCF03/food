
Program ej3;
valoralto = 9999;

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

Var 
  maestro: file_maestro;
  detalle1: file_detalle;
  detalle2: file_detalle;
  detalle3: file_detalle;
  reg_m: producto;
  reg_d1: producto_detalle;
  reg_d2: producto_detalle;
  reg_d3: producto_detalle;
  min: producto_detalle;
Procedure minimo(Var r1:producto_detalle; Var r2:producto_detalle; Var r3:producto_detalle; Var min:producto_detalle);

Begin
  If (r1.cod<=r2.cod) And (r1.cod<=r3.cod) Then
    Begin
      min := r1;
      leer(det1,r1)
    End
  Else If (r2.cod<=r3.cod) Then
         Begin
           min := r2;
           leer(det2,r2)
         End
  Else
    Begin
      min := r3;
      leer(det3,r3)
    End;
End

Begin
  Assign(maestro, 'maestro.dat');
  Assign(detalle1, 'detalle1.dat');
  Assign(detalle2, 'detalle2.dat');
  Assign(detalle3, 'detalle3.dat');
  Reset(maestro);
  Reset(detalle1);
  Reset(detalle2);
  Reset(detalle3);
  read(detalle1, reg_d1);
  read(detalle2, reg_d2);
  read(detalle3, reg_d3);
  minimo(reg_d1, reg_d2, reg_d3,min);
  While (min.cod <> valoralto) Do
    Begin
      read(maestro, reg_m);
      While (reg_m.cod <> min.cod) Do
        read(maestro, reg_m);
      While (reg_m.cod=min.cod) Do
        Begin
          reg_m.stock_disp := reg_m.stock_disp - min.cant_vendida;
          minimo(reg_d1, reg_d2, reg_d3, min);
        End;
      seek(maestro,filepos(maestro)-1);
      write(maestro, reg_m);
    End;
End.
