



















{La editorial X, autora de diversos semanarios, posee un archivo maestro con la información
correspondiente a las diferentes emisiones de los mismos. De cada emisión se registra:
fecha, código de semanario, nombre del semanario, descripción, precio, total de ejemplares
y total de ejemplares vendido.
Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el
país. La información que poseen los detalles es la siguiente: fecha, código de semanario y
cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al
procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la
actualización del archivo maestro en función de las ventas registradas. Además deberá
informar fecha y semanario que tuvo más ventas y la misma información del semanario con
menos ventas}

Program ej15;

Const valoralto = 'zzzz';

Type 
  reg_maestro = Record
    fecha: string;
    cod_semanario: integer;
    name_semanario: string;
    desc: string;
    precio: real;
    total_ejemplares: integer;
    total_vendidos: integer;
  End;
  reg_detalle = Record
    fecha: string;
    cod_semanario: integer;
    total_vendidos: integer;
  End;
  maestro_file = file Of reg_maestro;
  detalle_file = file Of reg_detalle;
  array_detalle = array[1..100] Of detalle_file;
  array_reg = array[1..100] Of reg_detalle;

Procedure leer(Var a:reg_detalle; Var r:reg_detalle)
Begin
  If Not(Eof(a))Then

    Read(a,r)
  Else r.fecha := valoralto;

End;

Procedure minimo(Var archivos:array_detalle; regs:array_reg; Var min:reg_detalle)

Var pos,i: integer;
Begin
  min.fecha := valoralto;
  For i:=1 To 100 Do
    Begin
      If ((regs[i].fecha <= min.fecha)And (regs[i].cod_semanario <=min.cod_semanario))Then
        Begin
          min := regs[i];
          pos := i
        End;
    End;
  If (min.fecha<>valoralto)Then
    leer(archivos[i],regs[i]);

End;



Var 
  maestro: maestro_file;
  detalles: detalle_file;
  min,aux: reg_detalle;
  regs: array_reg;

Begin
  Assign(maestro.'maestro.dat');
  reset(maestro);

End.
