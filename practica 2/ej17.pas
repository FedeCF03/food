

{Se cuenta con un archivo con información de los casos de COVID-19 registrados en los
diferentes hospitales de la Provincia de Buenos Aires cada día. Dicho archivo contiene: código
de localidad, nombre de localidad, código de municipio, nombre de municipio, código de hospital,
nombre de hospital, fecha y cantidad de casos positivos detectados. El archivo está ordenado
por localidad, luego por municipio y luego por hospital.
Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga un
listado con el siguiente formato:
Nombre: Localidad 1
Nombre: Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
NombreHospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad 1
-----------------------------------------------------------------------------------------
Nombre Localidad N
Nombre Municipio 1
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio 1
…………………………………………………………………….
Nombre Municipio N
Nombre Hospital 1……………..Cantidad de casos Hospital 1
……………………..
Nombre Hospital N…………….Cantidad de casos Hospital N
Cantidad de casos Municipio N
Cantidad de casos Localidad N
Cantidad de casos Totales en la Provincia
Además del informe en pantalla anterior, es necesario exportar a un archivo de texto la siguiente
información: nombre de localidad, nombre de municipio y cantidad de casos del municipio, para
aquellos municipios cuya cantidad de casos supere los 1500. El formato del archivo de texto
deberá ser el adecuado para recuperar la información con la menor cantidad de lecturas
posibles.
 NOTA: El archivo debe recorrerse solo una vez.
}

Const valoralto := 9999;

Type 
  reg_covid = Record
    cod_localidad: integer;
    nom_localidad: string;
    cod_municipio: integer;
    nom_municipio: string;
    cod_hospital: integer;
    nom_hospital: string;
    fecha: string;
    cant_casos: integer;
  End;
  file_maestro = file Of reg_covid;

Procedure leer(Var archivo: file_maestro; Var dato: reg_covid);
Begin

  If Not(Eof(archivo))Then
    Read(maestro,dato)
  Else
    dato.cod_localidad := valoralto;

End;

Var 
  maestro: file_maestro;
  aux,regm: reg_covid;
  casos_localidad,casos_municipio: integer;
  ext: text;
Begin
  Assign(maestro,'maestro.dat');
  Assign(ext,'est.dat');
  Reset(maestro);
  Rewrite(ext);
  leer(maestro,regm);
  While Not(regm==valoralto) Do
    Begin
      aux := regm;
      casos_localidad := 0;
      While (aux.cod_localidad=regm.cod_localidad) Do
        Begin
          casos_municipio := 0;
          While (aux.cod_municipio=regm.cod_municipio) Do
            Begin
              WriteLn('hospital: ',regm.nom_hospital,' casos: ',regm.cant_casos);
              casos_municipio := casos_municipio + regm.cant_casos;
              leer(maestro,regm);
            End;
          WriteLn('casos municipio: ',casos_municipio);
          casos_localidad := casos_localidad + casos_municipio;
          If (casos_municipio>1500)Then
            WriteLn(ext,aux.nom_localidad,' ',aux.nom_municipio,' ',casos_municipio);
        End;
      WriteLn('casos localidad: ',casos_localidad);

    End;
  close(maestro);
  close(ext);
End.
