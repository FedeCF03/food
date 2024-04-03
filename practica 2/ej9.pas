{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación}

Program ejer9;

Const valoralto = 9999;

Type 
  votos = Record
    cod_provincia: integer;
    cod_localidad: integer;
    nro_mesa: integer;
    cant_votos: integer;
  End;

  file_maestro = file Of votos;

Procedure leer(Var maestro:file_maestro; Var dato:votos);
Begin

  If Not(Eof(maestro)) Then
    read(maestro,dato)
  Else
    dato.cod_provincia := valoralto;


End;


Var 
  maestro: file_maestro;
  regm,aux: votos;
  total_votos,total_prov,votos_localidad: integer;
Begin
  Assign(maestro,'maestro.dat');
  Reset(maestro);
  total_votos := 0;
  leer(maestro,regm);
  aux = regm;
  While Not (regm.cod_provincia=valoralto) Do
    Begin
      aux.cod_provincia := regm_maestro.cod_provincia;
      total_prov := 0;
      While (aux.cod_provincia=regm.cod_provincia) Do
        Begin
          aux.cod_localidad := regm.cod_localidad;
          votos_localidad := 0;
          While (aux.cod_localidad=regm.cod_localidad) And (aux.cod_provincia=regm.cod_provincia) Do
            Begin
              votos_localidad := votos_localidad + regm.cant_votos;
              total_prov := total_prov + regm.cant_votos;
              total_votos := total_votos + regm.cant_votos;
              leer(maestro,regm);
            End;
          WriteLn('votos localidad' + aux.cod_localidad + ' : ' + votos_localidad);
        End;
      WriteLn('votos provincia' + aux.cod_provincia + ' : ' + total_prov);


    End;
  WriteLn('votos totales'+ total_votos);

End.
