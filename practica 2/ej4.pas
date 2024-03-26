
Program ej4;



























{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,                                                                                                                                                  tiempo_total_de_sesiones_abiertas.
Notas:
Cada archivo detalle está ordenado por cod_usuario y fecha.
 Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /

Var /log.}

Const valoralto = 'zzzz';

Type 
  log = Record
    cod_usuario: integer;
    fecha: string;
    tiempo_sesion: integer;
  End;

  master_log = Record
    cod_usuario: integer;
    total_de_sesiones_abiertas: integer;
  End;
  detalle_file = file Of log;
  master_file = file Of master_log;


Procedure leer (Var archivo:detalle_file; Var
                dato:log);
Begin
  If (Not eof( archivo ))
    Then read (archivo, dato)
  Else dato.nombre := valoralto;
End;
Procedure minimo (Var m1,m2,m3,m4,m5:log; Var
                  min:log);
Begin
  If (m1.nombre<=m2.nombre) And
     (m1.nombre<=m3.nombre) And (m1.nombre<=m4.nombre)And
     (m1.nombre<=m5.nombre)  Then
    Begin
      min := m1;
      leer(det1,m1)
    End
  Else If (m2.nombre<=m3.nombre)And (m2.nombre<=m4.nombre) And (m2.nombre<=m5.nombre) Then
         Begin
           min := m2;
           leer(det2,m2)
         End
  Else If  (m3.nombre<=m4.nombre)And (m3.nombre<=m5.nombre) Then
         Begin
           min := m3;
           leer(det3,m3)
         End
  Else If (m4.nombre<=m5.nombre) Then
         Begin
           min := m4;
           leer(det4,m4)
         End
  Else
    Begin
      min := m5;
      leer(det5,m5)
    End;
End;


Var 
  maquina1, maquina2, maquina3, maquina4, maquina5: detalle_file;
  master: master_file;
  min1, min2, min3, min4, min5,min: log;
  regm: master_log;

Begin
  Assign(maquina1, 'maquina1.dat');
  Assign(maquina2, 'maquina2.dat');
  Assign(maquina3, 'maquina3.dat');
  Assign(maquina4, 'maquina4.dat');
  Assign(maquina5, 'maquina5.dat');
  Assign(master, 'master.dat');
  Reset(maquina1);
  Reset(maquina2);
  Reset(maquina3);
  Reset(maquina4);
  Reset(maquina5);
  Rewrite(master);
  leer(maquina1, min1);
  leer(maquina2, min2);
  leer(maquina3, min3);
  leer(maquina4, min4);
  leer(maquina5, min5);
  minimo(min1,min2,min3,min4,min5,min);
  While (min <> valoralto) Do
    Begin
      regm.cod_usuario := min.cod_usuario;
      regm.total_de_sesiones_abiertas := 1;
      While (regm.cod_usuario = min.cod_usuario) Do
        Begin
          regm.total_de_sesiones_abiertas := regm.total_de_sesiones_abiertas + 1;
          minimo(min1,min2,min3,min4,min5,min);
        End;
      write(master, regm);

    End;

End.
