






























{Una compañía aérea dispone de un archivo maestro donde guarda información sobre suspróximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la
cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
a. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
sin asiento disponible.
b. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
tengan menos de una cantidad específica de asientos disponibles. La misma debe
ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.}

Program ejercicio13;

Const valoralto = 'zzzz';

Type 
  reg_maestro = Record
    destino: string;
    fecha: string;
    horasalida: string;
    cant_asientos_disp: integer;
  End;

  reg_detalle = Record
    destino: string;
    fecha: string;
    horasalida: string;
    cant_asientos_comp: integer;
  End;
  file_maestro = file Of reg_maestro;
  file_detalle = file Of reg_detalle;



Procedure leer (Var archivo: file_detalle; Var dato: reg_detalle);
Begin
  If (Not eof(archivo)) Then
    Read(archivo,dato)
  Else dato.destino := valoralto;
End;
Procedure minimo( Var min,r1,r2:reg_detalle);
Begin
  If (r1.destino <= r2.destino) Then
    Begin
      min := r1;
      leer(detalle1,r1);
    End
  Else
    Begin
      min := r2;
      leer(detalle2,r2);
    End;
End;

Var 
  maestro: file_maestro;
  regm: reg_maestro;
  detalle1, detalle2: file_detalle;
  aux,min,regd,regd2: reg_detalle;
  cant_comprados: integer;
  texto: Text;
Begin
  Assign(maestro,'maestro');
  Assign(detalle1,'detalle1');
  Assign(detalle2,'detalle2');
  Assign(texto,'lista.txt');
  Rewrite(texto);
  Reset(maestro);
  Reset(detalle1);
  Reset(detalle2);
  leer(detalle1,regd);
  leer(detalle2,regd2);
  minimo(min,regd,regd2);
  read(cant);
  While Not(min.destino==valoralto ) Do
    Begin
      aux := min;
      read(maestro,regm);
      While Not(regm.destino==min.destino) Do
        Read(maestro,regm);
      While (min.destino==aux.destino) Do
        Begin
          aux.fecha := min.fecha;
          While Not(regm.fecha==min.fecha) Do
            Read(maestro,regm);

          While ((aux.fecha==min.fecha)&&(min.destino==aux.destino) ) Do
            Begin
              While Not(regm.horasalida==min.horasalida) Do
                Read(maestro,regm);
              aux.horasalida := min.horasalida;
              While ((aux.fecha==min.fecha)And(min.destino==aux.destino)And(aux.horasalida=min.horasalida)) Do
                Begin
                  regm.cant_asientos_disp := regm.cant_asientos_disp - min.cant_asientos_comp;
                  minimo(min,regd,regd2);
                End;
              FilePos(maestro,FilePos(maestro)-1);
              Write(maestro,regm);
              If (regm.cant_asientos_disp < cant) Then
                Begin
                  Write(texto,'Destino: ',regm.destino);
                  Write(texto,'Fecha: ',regm.fecha);
                  Write(texto,'Hora de salida: ',regm.horasalida);
                End;
            End;
        End;

    End;

End.
