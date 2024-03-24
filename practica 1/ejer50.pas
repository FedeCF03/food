
Program ejer5;

Type 
  celular = Record
    codigo: integer;
    nombre: string;
    desc: string;
    marca: string;
    precio: integer;
    stock_minimo: integer;
    stock_act: integer;

  End;
  archivo_celulares = file Of celular;
  archivvbo = file Of Text;
Procedure leercelular(Var celular:celular);
Begin
  writeln('Ingrese el codigo del celular');
  readln(celular.codigo);
  If celular.codigo <> 0 Then
    Begin
      writeln('Ingrese el nombre del celular');
      readln(celular.nombre);
      writeln('Ingrese la descripcion del celular');
      readln(celular.desc);
      writeln('Ingrese la marca del celular');
      readln(celular.marca);
      writeln('Ingrese el precio del celular');
      readln(celular.precio);
      writeln('Ingrese el stock minimo del celular');
      readln(celular.stock_minimo);
      writeln('Ingrese el stock actual del celular');
      readln(celular.stock_act);
    End;
End;

Procedure cargar_celulares(Var arc_logico:archivo_celulares);

Var celula: celular;
Begin
  Assign(arc_logico,'celulares50.dat');
  Rewrite(arc_logico);
  leercelular(celula);
  While celula.codigo <> 0 Do
    Begin
      write(arc_logico,celula);
      leercelular(celula);
    End;
  Close(arc_logico);
End;

Procedure cargar_archivo(Var archivo_celulares_txt: text; Var arc_logico: archivo_celulares);

Var 
  reg: celular;

Begin
  Assign(archivo_celulares_txt, 'celulares.txt');
  Assign(arc_logico, 'celulares50.dat');
  Reset(arc_logico);
  Rewrite(archivo_celulares_txt);
  While Not Eof(arc_logico) Do
    Begin
      Read(arc_logico,reg);
      With reg Do
        Begin
          writeln(archivo_celulares_txt,codigo,' ',stock_minimo,' ',stock_act,' ',precio);
          writeln(archivo_celulares_txt,nombre);
          writeln(archivo_celulares_txt,desc);
          writeln(archivo_celulares_txt,marca);
        End;
    End;
  Close(arc_logico);
  Close(archivo_celulares_txt);

End;

Procedure listarDatos(Var arc_logico:archivo_celulares);

Var reg: celular;
Begin
  reset(arc_logico);
  While Not eof(arc_logico) Do
    Begin
      Read(arc_logico,reg);
      If (reg.stock_minimo>reg.stock_act)Then WriteLn('El celular ',reg.nombre,' tiene stock minimo');

    End;
  close(arc_logico);
End;
Procedure exportarDatos(Var arc_logico:archivo_celulares);

Var reg: celular;
  archivo_celulares_txt2: text;
Begin
  Assign(archivo_celulares_txt2,'celulares_exportar.txt');
  Rewrite(archivo_celulares_txt2);
  Reset(arc_logico);
  While Not eof(arc_logico) Do
    Begin
      Read(arc_logico,reg);
      Write(archivo_celulares_txt2,reg.codigo,reg.nombre,reg.desc,reg.marca,reg.precio,reg.stock_minimo,reg.stock_act);
    End;
End;
Procedure agregarAlFinal(Var arc_logico:archivo_celulares);

Var reg: celular;
Begin
  Assign(arc_logico,'celulares50.dat');
  reset( arc_logico );
  seek( arc_logico, filesize(arc_logico));
  leercelular( reg );
  write( arc_logico, reg);

  close(arc_logico);
End;
Procedure modificarCelularDado(Var archivo_celulares_txt:text;  nombre:String;stock : integer);

Var reg: celular;
Begin
  Assign(archivo_celulares_txt,'celulares.txt');
  Reset(archivo_celulares_txt);
  With reg Do
    Begin
      read(archivo_celulares_txt,codigo,stock_minimo,stock_act,precio);
      read(archivo_celulares_txt,nombre);
      read(archivo_celulares_txt,desc);
      read(archivo_celulares_txt,marca);
    End;
  While ( Not Eof(archivo_celulares_txt)And (reg.nombre <> nombre )) Do
    Begin
      With reg Do
        Begin
          read(archivo_celulares_txt,codigo,stock_minimo,stock_act,precio);
          read(archivo_celulares_txt,nombre);
          read(archivo_celulares_txt,desc);
          read(archivo_celulares_txt,marca);
        End;

    End;
  If (reg.nombre = nombre) Then
    Begin
      seek(archivo_celulares_txt, filepos(archivo_celulares_txt)-5);
      write(archivo_celulares_txt,stock);
    End;

End;


Var 
  reg_celular: celular;
  archivo_celulares_txt: text;
  arc_logico: archivo_celulares;
  opcion: integer;
Begin
  writeln('Bienvenido a la tienda de celulares');
  writeln('1. Exportar');
  writeln('2. Listar celulares con stock bajo');
  writeln('3. Exportar');
  writeln('4. agregar al final');
  WriteLn('5. Modificar stock de un celular')
  readln(opcion);


  If (opcion = 1)Then
    Begin
      cargar_archivo(archivo_celulares_txt,arc_logico);

    End
  Else If (opcion = 2) Then
         Begin
           cargar_celulares(arc_logico);
         End
  Else If (opcion=3)Then
         Begin
           exportarDatos(arc_logico);
         End

  Else If (opcion=4)Then
         Begin
           agregarAlFinal(arc_logico);
         End

  Else If (opcion=5)Then
         Begin
           modificarCelularDado(archivo_celulares_txt,'Iphone',10)
         End


  Else writeln('salida exitosa');


End.
