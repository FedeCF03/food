














{Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus
próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la
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


Var 
  maestro: file_maestro;
  detalle1, detalle2: file_detalle;
  aux,regd: reg_detalle;
