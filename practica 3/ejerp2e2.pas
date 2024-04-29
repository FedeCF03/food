{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
localidad en la provincia de Buenos Aires. Para ello, se posee un archivo con la
siguiente información: código de localidad, número de mesa y cantidad de votos en
dicha mesa. Presentar en pantalla un listado como se muestra a continuación:
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total General de Votos: ………………
NOTAS:
● La información en el archivo no está ordenada por ningún criterio.
● Trate de resolver el problema sin modificar el contenido del archivo dado.
● Puede utilizar una estructura auxiliar, como por ejemplo otro archivo, para
llevar el control de las localidades que han sido procesadas.}

Program ejerp2e2;

Type 
  voto = Record
    cod: integer;
    nMesa : integer;
    cVotos : integer;
  End;
  votoControl = Record
    cod : integer;
    cVotosTotal: integer;
  End;
  archivo = file Of voto;
  aux_archivo = file Of votoControl;

Procedure procesar(Var a:archivo; Var aux:aux_archivo;)

Var reg,reg_aux: voto;
  vtos: votoControl;
Begin
  Reset(a);
  Rewrite(aux);
  leerVotos(a,reg);
  reg_aux = reg;
  While Not(reg.cod==valoralto) Do
    Begin
      While (reg.cod==aux.cod) Do
        Begin

        End;
    End;

End;
