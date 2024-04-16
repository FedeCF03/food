































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
      If ((regs[i].fecha < min.fecha)Or ( regs[i].fecha == min.fecha And (regs[i].cod_semanario <=min.cod_semanario)))Then
        Begin
          min := regs[i];
          pos := i
        End;
    End;
  If (min.fecha<>valoralto)Then
    leer(archivos[i],regs[i]);

End;

Procedure AbrirDetalles(Var detalles:detalle_file; Var regs:array_reg)

Var i: integer;
Begin
  For i:=1 To 100 Do
    Begin
      Assign(detalles[i],'detalle'+1+'.dat');
      Reset(detalles[i]);
      Read(detalles[i],regs[i]);
    End;

End;


Var 
  maestro: maestro_file;
  detalles: detalle_file;
  min,aux: reg_detalle;
  regs: array_reg;
  regm: reg_maestro;
  max,mini: reg_detalle;
Begin
  Assign(maestro.'maestro.dat');
  reset(maestro);
  AbrirDetalles(detalle_file,regs);
  minimo(detalles,regs,min);
  Read(maestro,regm);
  max.cod_semanario := 0;
  mini.cod_semanario := 0;
  mini.total_vendidos := 999999999;
  max.total_vendidos := 0;
  While Not(min.fecha==valoralto) Do
    Begin
      aux = min;
      While !((regm.fecha==aux.fecha) And (regm.cod_semanario==aux.cod_semanario)) 
        Do
        read(maestro,regm);
      While ((regm.fecha==aux.fecha) And (regm.cod_semanario==aux.cod_semanario)) Do
        Begin
          regm.total_vendidos := regm.total_vendidos + min.total_vendidos;
          minimo(detalles,regs,min);
        End;
      If (regm.total_vendidos >max.total_vendidos)
        Then
        Begin
          max.total_vendidos := regm.total_vendidos;
          max.cod_semanario := regm.cod_semanario;
        End;
      If (mini.total_vendidos>regm.total_vendidos)
        Then
        Begin
          mini.total_vendidos := regm.total_vendidos;
          mini.cod_semanario := regm.cod_semanario;
        End;
      Seek(maestro,FilePos(maestro)-1);
      Write(maestro,regm);
    End;

End.
