
Program Example71;

{ Program to demonstrate the Truncate function. }

Var F : File Of longint;
  I,L : Longint;

Begin
  Assign (F,'test.tmp');
  Rewrite (F);
  For I:=1 To 10 Do
    Write (F,I);
  Writeln ('Filesize before Truncate : ',FileSize(F));
  Close (f);
  Reset (F);
  Repeat
    Read (F,I);
  Until i=5;
  Truncate (F);
  Writeln ('Filesize after Truncate  : ',Filesize(F));
  Close (f);
End.
