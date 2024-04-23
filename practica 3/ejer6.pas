{
    Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
la información correspondiente a las prendas que se encuentran a la venta. De cada
prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las
prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las
prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba
ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de
efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
información de las prendas a la venta. Para ello se deberá utilizar una estructura
auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
que no están marcadas como borradas. Al finalizar este proceso de compactación
del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
original
}

Program ejer6;

Const valor_alto = 9999;

Type 
  prendas = Record
    cod_prenda : integer;
    descripcion : string;
    colores : string;
    tipo_prenda : string;
    stock : integer;
    precio_unitario : real;
  End;

  prendido_archivo = file Of prendas;
  baja_archivo = File Of integer;


Procedure leer_cod(Var b:baja_archivo; Var reg:integer  )
Begin
  If Not(Eof(b))Then
    Begin
      Read(b,reg);
    End
  Else
    Begin
      reg := valor_alto;
    End;


End;

Procedure leer_prenda(Var b:baja_archivo; Var reg:prendas  )
Begin
  If Not(Eof(b))Then
    Begin
      Read(b,reg);
    End
  Else
    Begin
      prendas.codigo := valor_alto;
    End;


End;


Procedure modificar_stock(Var p:prendido_archivo;Var b:baja_archivo)

Var p_reg: prendas;
  cod: integer;
Begin
  leer_cod(b,cod);
  leer_prenda(p,p_reg);
  While (cod<>valor_alto)  Do
    Begin
      While (p_reg.cod_prenda<>cod) And (p.cod_prenda<>valor_alto) Do
        leer_prenda(p,p_reg);
      If (p_reg.cod_prenda=cod)Then
        Begin
          p_reg.stock := p_reg.stock*-1;
        End;
      leer_prenda(p,p_reg);
    End;

End;
Procedure rename_nueva_temporada(Var maestro:prendido_archivo; Var newArchivo:prendido_archivo)

Var p: prenda;
Begin
  leer_prenda(maestro,p);
  While (p.cod<>valor_alto) Do
    Begin
      If (p.stock>0)Then
        Write(newArchivo,p);
      leer_prenda(maestro,p)
    End;
  rename(maestro,'maestro_temp_ant');
  rename(newArchivo,'maestro');


End;
