
Program ej7;

Type 
  novela = Record
    titulo: string;
    autor: string;
    ano_pub: integer;

  End;

  archivo_novela = file Of novela;



Procedure agregarNovelas(Var arch_novela: archivo_novela; Var arch_txt: text);

Var 
  n: novela;
Begin
  Assign(arch_novela, 'novelas.dat');
  Assign(arch_txt, 'novelas.txt');
  Rewrite(arch_novela);
  Reset(arch_txt);
  While Eof(arch_txt) Do
    Begin
      Read(arch_txt, n.ano_pub);
      Read(arch_txt, n.autor);
      Read(arch_txt, n.titulo);
      Write(arch_novela, n);
    End;
  close(arch_novela);
  Close(arch_txt);



End;
Procedure agregarNovelasNuevas(Var arch_novela:archivo_novela)

Var n: novela;
Begin
  Assign(arch_novela, 'novelas.dat');
  Reset(arch_novela);
  writeLn('Ingrese el titulo de la novela');
  ReadLn(n.titulo);
  writeLn('Ingrese el autor de la novela');
  ReadLn(n.autor);
  writeLn('Ingrese el año de publicacion de la novela');
  ReadLn(n.ano_pub);
  seek(arch_novela, filesize(arch_novela));
  Write(arch_novela, n);
  Close(arch_novela);
End;

Procedure buscarNovelas(Var arch_novela:archivo_novela; anio: integer);

Var n: novela;
Begin
  Assign(arch_novela, 'novelas.dat');
  Reset(arch_novela);
  Read(arch_novela, n);
  While (Not Eof(arch_novela) And Not(anio=n.anio )) Do
    Begin
      Read(arch_novela, n);
    End;
  If (anio=n.anio) Then
    Begin
      WriteLn("modifique el año");
      ReadLn(anio);
      seek(arch_novela, filepos(arch_novela)-1);
      n.anio := anio;
      Read(arch_novela, n);
      Close(arch_novela);
    End;

End;

Var 
  arch_novela: archivo_novela;
  arch_txt: text;

  opcion: integer;
Begin
  writeln('Bienvenido a la tienda de celulares');
  writeln('1. crear');
  writeln('2. agregar');
  writeln('3. modificar');
  readln(opcion);
  If (opcion = 1) Then
    Begin
      agregarNovelas(arch_novela, arch_txt);
    End
  Else If (opcion = 2) Then
         Begin
           agregarNovelasNuevas(arch_novela);
         End
  Else If (opcion = 3) Then
         Begin
           buscarNovelas(arch_novela,196);
         End

End.
