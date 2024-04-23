{Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
{Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.
}

Program ejer4;

Type 
  reg_flor = Record
    nombre: String[45];
    codigo: integer;
    eliminado: Boolean;
  End;
  tArchFlores = file Of reg_flor;
Procedure agregarFlor (Var a: tArchFlores ; nombre: String;
                       codigo:integer);

Var cabeza,aux,act: reg_flor;
  pos: integer;
Begin
  Read(a,cabeza);
  aux.nombre := nombre;
  aux.codigo := codigo;
  If (cabeza.codigo<0)Then
    Begin
      pos := cabeza.codigo *-1;
      Seek(a,pos);
      Write(a,aux);
      cabeza.codigo := 0;
      Seek(a,0);
      Write(a,cabeza);

    End
  Else
    Begin
      Seek(a,FileSize(a));
      Write(a,aux);

    End;
End;

Procedure recorrer(Var a:tArchFlores)

Var reg: reg_flor;
Begin
  Read(a,reg);
  While Not(Eof(a)) Do
    Begin
      If Not(reg.eliminado)Then
        Begin
          WriteLn(reg.codigo);
        End;
      Read(a,reg);
    End;
End;

Procedure eliminarFlor (Var a: tArchFlores; flor:reg_flor);

Var aux,act,cabe: reg_flor;
  pos: integer;
Begin
  Read(a,cabe);
  Read(a,act);
  While ((flor.codigo<>act.codigo) And Not(Eof(a))) Do
    Begin
      Read(a,act);
    End;
  pos := (FilePos(a)-1)*-1;
  Seek(a,pos*-1);
  Write(a,cabe);
  cabe.codigo := pos;
  Seek(a,0);
  Write(a,cabe);

End;
