



































































{Suponga que usted es administrador de un servidor de correo electrónico. En los logs del
mismo (información guardada acerca de los movimientos que ocurren en el server) que se
encuentra en la siguiente ruta: /
Var /log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
a. Realice el procedimiento necesario para actualizar la información del log en un
día particular. Defina las estructuras de datos que utilice su procedimiento.
b. Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema. Considere la implementación de esta opción de las
siguientes maneras:
i- Como un procedimiento separado del punto a).
- En el mismo procedimiento de actualización del punto a). Qué cambios
se requieren en el procedimiento del punto a) para realizar el informe en
el mismo recorrido}

Program ejercicio12;

Const valoralto =   9999;

Type 
  reg_maestro = Record
    nro_usuario: integer;
    nombreUsuario: string;
    nombre: string;
    apellido: string;
    cantidadMailEnviados: integer;
  End;
  reg_detalle = Record
    nro_usuario: integer;
    cuentaDestino: string;
    cuerpoMensaje: string;
  End;

  file_maestro = file Of reg_maestro;
  file_detalle = file Of reg_detalle;

Procedure leer(Var archivo:file_detalle; Var dato:reg_detalle);
Begin
  If Not(Eof(archivo))Do
     Begin
     Read(archivo,dato)
     End Else (
     reg_detalle:=valoralto;
     )


     End;
     Procedure crearTxt(Var archivo:file_detalle);
     Var texto:text;
     aux,regd: reg_detalle;
     cant_emails:integer;
     Begin
     Assign(texto,'/var/log/informe.txt');
     Rewrite(texto);
     leer(archivo,regd);
     While Not(regd.nro_usuario==valoralto) Do
     Begin
     aux:=regd;
     cant_emails:=0;
     While (regd.nro_usuario==aux.nro_usuario) Do
     Begin
     cant_emails:=cant_emails+1;
     leer(archivo,regd);
     End;
     WriteLn(texto,aux.nro_usuario,'..........',cant_emails);
     End;
     Close(texto);
     End;


     Var
     maestro: file_maestro;
     detalle: file_detalle;
     regm: reg_maestro;
     regd,aux: reg_detalle;
     cantemails: integer;
     texto:Text;


     Begin
     Assign(texto,'/var/log/informe.txt')
     Assign (maestro, '/var/log/logmail.dat');
     Assign (detalle, '/var/log/logmailDay.dat');
     Reset(maestro);
     Rewrite(texto);
     Reset(detalle);
     leer(detalle,regd);
     While Not(regd.nro_usuario == valoralto ) Do
     Begin
     Read(maestro,regm);
     cantemails := 0;
     While Not(regd.nro_usuario== regm.nro_usuario) Do
     Write(texto,regm.nro_usuario,'..........',regm.cantidadMailEnviados);
     Read(maestro,regm);
     aux := regd;
     While (regd.nro_usuario == aux.nro_usuario) Do
     Begin
     cantemails := cantemails + 1;
     leer(detalle,regd);
     End;
     regm.cantidadMailEnviados := regm.cantidadMailEnviados + cantemails;
     FilePos(maestro,FilePos(maestro)-1);
     Write(maestro,regm);
     Write(texto,regm.nro_usuario,'..........',regm.cantidadMailEnviados);

     End;
     close(maestro);
     close(detalle);
     Close(texto);
     End.