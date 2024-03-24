
Program Generar_Archivo;

Type archivo = file Of integer; {definición del tipo de dato para el archivo }

Var arc_logico: archivo; {variable que define el nombre lógico del archivo}
  nro: integer; {nro será utilizada para obtener la información de teclado}
  arc_fisico: string;
  {utilizada para obtener el nombre físico del archivo desde teclado}
Begin
  write( 'Ingrese el nombre del archivo:' );
  ReadLn( arc_fisico ); { se obtiene el nombre del archivo}
  assign( arc_logico, arc_fisico );
  rewrite( arc_logico ); { se crea el archivo }
  read( nro ); { se obtiene de teclado el primer valor }
  While nro <> 30000 Do
    Begin
      write( arc_logico, nro ); { se escribe en el archivo cada número }
      read( nro );
    End;
  close( arc_logico );
  { se cierra el archivo abierto oportunamente con la instrucción rewrite }
End.
