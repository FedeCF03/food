
Program tiendaDeCelulares;

Type 
  Celulares = Record
    cod: integer;
    name: string;
    desc: string;
    marca: string;
    precio: real;
    stock_minimo: integer;
    stock_disponible: integer;
  End;
  CelularesFile = file Of Celulares;

Var 
  archivo: CelularesFile;
  archivo_celulares: Text;
  cekular: Text;
  celular: Celulares;

Begin
  Assign(cekular,'celulares.txt');
  Rewrite(cekular);
  Assign(archivo,'datos_celulares.dat');
  Rewrite(archivo);
  Assign(archivo_celulares,'celulares.txt');
  Reset(archivo_celulares);
  While Not Eof(archivo_celulares) Do
    Begin
      read(archivo_celulares,celular.cod,celular.name,celular.desc,celular.marca,celular.precio,celular.stock_minimo,celular.stock_disponible);
      Write(archivo,celular);
    End;

  Close(archivo);
  Close(archivo_celulares);
  close(cekular);

End.
