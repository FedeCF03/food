{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para}

Program ej2p2;

Const valoralto = 9999;

Type 
  alumno = Record
    codigo: integer;
    apellido: string;
    nombre: string;
    cantMateriasAprobadas: integer;
    cantMateriasConFinal: integer;
  End;
  alumno_detalle = Record
    codigo: integer;
    aproboCursada: boolean;
    aproboFinal: boolean;
  End;
Procedure leer (Var archivo:detalle; Var dato:alumno_detalle);
Begin
  If (Not eof(archivo))
    Then read (archivo,dato)
  Else dato.cod := valoralto;
End;
Procedure aprobo (Var regd:alumno_detalle; Var regm:alumno);
Begin
  If (regd.aproboCursada)
    Then
    regm.cantMateriasAprobadas := regm.cantMateriasAprobadas + 1;

  If (regd.aproboFinal)
    Then
    Begin
      regm.cantMateriasConFinal := regm.cantMateriasConFinal + 1;
      regm.cantMateriasAprobadas := regm.cantMateriasAprobadas - 1;
    End;

End;

Var 
  maestro: file Of alumno;
  detalle: file Of alumno_detalle;
  regd : alumno_detalle;
  regm = alumno;


Begin
  assign(maestro,'maestro');
  assign(detalle,'detalle');
  reset(maestro);
  reset(detalle);
  leer(detalle,regd);

  While (regm.codigo <> valoralto) Do
    Begin
      Read(maestro,regm);
      While (regm.cod <> regd.cod) Do
        read (maestro,regm);
      While (regm.cod = regd.cod) Do
        Begin
          aprobo(regd,regm);
          leer(detalle,regd);
        End;
      Seek(maestro,filepos(maestro)-1);
      Write(maestro,regm);

    End;

End.
