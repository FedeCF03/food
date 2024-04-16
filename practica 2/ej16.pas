
{Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información
de las motos que posee a la venta. De cada moto se registra: código, nombre, descripción,
modelo, marca y stock actual. Mensualmente se reciben 10 archivos detalles con
información de las ventas de cada uno de los 10 empleados que trabajan. De cada archivo
detalle se dispone de la siguiente información: código de moto, precio y fecha de la venta.
Se debe realizar un proceso que actualice el stock del archivo maestro desde los archivos
detalles. Además se debe informar cuál fue la moto más vendida.
NOTA: Todos los archivos están ordenados por código de la moto y el archivo maestro debe
ser recorrido sólo una vez y en forma simultánea con los detalles
}

Program ej16;

Const valoralto = 9999;

Type 
  reg_maestro = Record
    cod: integer;
    name: string;
    desc: string;
    modelo: string;
    marca: string;
    stock: integer;
  End;
  reg_detalle = Record
    cod: integer;
    price: real;
    fecha: string;
  End;
  file_maestro = file Of reg_maestro;
  file_detalles = file Of reg_detalle;
  array_detalles = array[1..10] Of file_detalles;
  array_regs = array[1..10] Of reg_detalle;

Procedure leer(Var detalle: file_detalle; Var reg:reg_detalle)
Begin

  If Not(eof(detalle))Then
    Begin
      Read(detalle,reg);
    End
  Else
    reg.cod := valoralto;

End;
Procedure minimo(Var detalles:array_detalles; Var regs:reg_detalle;Var min:reg_detalle)

Var i,pos: integer;
Begin

  For i:=1 To 10 Do
    Begin
      min.cod := 9999;
      If (min.cod>=regs[i].cod )Then
        Begin
          min := regs[i];
          pos := i;
        End;

    End;
  If Not(min.cod = valoralto)Then
    Begin
      leer(detalles[pos],regs[pos]);
    End;
End;

Var 
  maestro: file_maestro;
  detalles: array_detalles;
  regs: array_regs;
  min,aux: reg_detalle;
  cant_vendidas,cod_mas_v,vendidas: integer;
  regm: reg_maestro;


Begin
  cant_vendidas := 999;
  Assign(maestro,'maestro.dat');
  AssignDetalles(detalles,regs);
  Reset(maestro);
  minimo(detalles,regs,min);
  Read(maestro,regm);

  While Not(min.cod=valoralto) Do
    Begin
      aux := min;
      vendidas := 0;
      While Not(regm.cod==aux.cod) Do
        Read(maestro,regm);
      While (regm.cod=aux.cod) Do
        Begin
          regm.stock := regm.stock-1;
          vendidas := vendidas+1;
          minimo(detalles,regs,min);
        End;
      If (cant_vendidas<vendidas)Then
        Begin
          cant_vendidas := vendidas;
          cod_mas_v := regm.cod;
        End;
      Seek(maestro,FilePos(maestro)-1);
      Write(maestro,regm);
    End;
  Close(maestro);


End.
