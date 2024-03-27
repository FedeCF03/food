



















{Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
}

Program ej6;

Const valoralto = 9999;

Type 
  detalle_record = Record
    cod_usuario: integer;
    fecha: String;
    tiempo_sesion: integer;
  End;
  maestro_record = Record
    cod: integer;
    fecha: String;
    tiempo_total: integer;
  End;
  file_detalle = file Of detalle_record;
  array_detalle = array[1..5] Of file_detalle;
  registro_det = array[1..5] Of detalle_record;
  file_maestro = file Of maestro;

Procedure inicializar_archivo(Var detalle:array_detalle; Var regd:registro_det);

Var i: integer;
Begin

  For (i:=1 To 5) 
    Do
    Begin
      Assign(detalle[i],'detalle'+i);
      reset(detalle[i]);
      read(detalle[i],reg[i])
    End;
End;


Procedure leer(Var detalle:array_detalle; Var j:Integer;Var reg:registro_det);
Begin

  If Not(eof(detalle[j]))Then
    read(detalle[j],reg[j])
  Else
    reg[j].cod_usuario := valoralto;
End;

Procedure minimo(Var detalle:array_detalle; Var regd:registro_det;Var min:detalle_record);

Var j,i: integer;
Begin
  min.fecha := 'zzzzzzzz';
  min.cod_usuario := valoralto;
  For ( i:=1 To 5) Do
    Begin
      If ((regd[i].fecha<min.fecha) And (regd[i].cod_usuario<min.cod_usuario)) Then
        Begin
          min := regd[i];
          j := i;
        End;
    End;
  If (min.cod_usuario<>valoralto) Then
    Begin
      leer(detalle,j,regd);
    End;
End;

Procedure cerrar(Var detalle:array_detalle; Var regd:registro_det);

Var i: integer;
Begin
  For (i=1 To 5) Do
    Begin
      Close(detalle[i]);
      Close(regd[i]);
    End;

End;

Var 
  detalle: array_detalle;
  regd: registro_det;
  maestro: file_maestro;
  regm: maestro_record;
  min,aux: detalle_record;
Begin
  assign(maestro,'/var/log/maestro');
  inicializar_detalle(detalle);
  Rewrite(maestro);
  minimo(detalle,regd,min);
  While (min.cod <> valoralto) Do
    Begin
      aux = min;
      While ((aux.cod = min.cod) And (aux.fecha = min.fecha)) Do
        Begin
          aux.tiempo_total := aux.tiempo_total + min.tiempo_sesion;
          minimo(detalle,regd,min);
        End;
      Write(maestro,aux);
    End;
  Close(maestro);
  cerrar(detalle);
  cerrar(regd);
End.
