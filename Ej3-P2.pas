program Ej3P2;
Uses crt;
const
  valorAlto = 9999;
  df = 30;
type

  producto = record
    codigo : integer;
    nombre : String[25];
    descripcion : String[25];
    stock : integer;
    stockMin : integer;
    precio : real;
  end;

  venta = record
    codigo : integer;
    cantVen : integer;
  end;

  maestro = file of producto;
  detalle = file of venta;

  vector = array[1..df] of detalle;
  vectorReg = array[1..df] of venta;

procedure leer(var arch : detalle; var reg : venta);
begin
  if(not eof(arch)) then
    read(arch,reg)
  else
    reg.codigo := valorAlto;
end;

procedure reporte(var arch : maestro);
var
  reg : producto;
  repo : Text;
begin
  assign(repo,'reporte');
  rewrite(repo);
  while(not eof(arch)) do begin
    read(arch,reg);
    if(reg.stock < reg.stockMin) then
      writeln(repo,reg.nombre,' ',reg.descripcion,' ',reg.stock,' ',reg.precio:2:2);
  end;
  close(repo);
end;

procedure minimo(var vec : vector; var vecReg : vectorReg; var min : venta);
var
  i, pos : integer;
begin
  min.codigo := valorAlto;
  for i := 1 to df do
    if(vecReg[i].codigo < min.codigo) then begin
      min := vecReg[i];
      pos := i;
    end;
  if(min.codigo <> valorAlto) then
    leer(vec[pos],vecReg[pos]);
end;

procedure actualizar(var vec : vector);
var
  arch : maestro;
  i, aux, cant : integer;
  reg : producto;
  vecReg : vectorReg;
  min : venta;
begin
  assign(arch,'001productos');
  reset(arch);
  for i := 1 to df do begin
    reset(vec[i]);
    leer(vec[i],vecReg[i]);
  end;
  minimo(vec,vecReg,min);
  while(min.codigo <> valorAlto) do begin
    aux := min.codigo;
    cant := 0;
    while(min.codigo <> valorAlto) and (min.codigo = aux) do begin
      cant := cant + min.cantVen;
      minimo(vec,vecReg,min);
    end;
    read(arch,reg);
    while(reg.codigo <> valorAlto) and (reg.codigo <> aux) do
      read(arch,reg);
    seek(arch,filepos(arch)-1);
    reg.stock := reg.stock - cant;
    write(arch,reg);
  end;
  reporte(arch);
  close(arch);
  for i := 1 to df do
    close(vec[i]);
end;

var
  vec : vector;
  i : integer;
  a : String[2];
begin
  clrscr;

  for i := 1 to df do begin
    Str(i,a);
    assign(vec[i],'001sucursal'+a);
  end;

  actualizar(vec);

  readln;
end.
