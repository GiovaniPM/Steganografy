unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, StrUtils,
  Menus, ExtCtrls, StdCtrls, PairSplitter, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Exit1: TAction;
    Open: TAction;
    Save: TAction;
    ActionList1: TActionList;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N1: TMenuItem;
    MenuItem5: TMenuItem;
    OpenDialog1: TOpenDialog;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Exit1Execute(Sender: TObject);
    procedure OpenExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function BinToInt(Value: String): LongInt;
    function ClearByte(BValue: Byte): Byte;
    function EncryptSteganography(ImgSource: TImage; TxtSource: TMemo): TImage;
    function DecryptSteganography(ImgSource: TImage): string;
    procedure SaveExecute(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  FileName: string;
  Ms: TMemoryStream;

implementation

{$R *.frm}

{ TForm1 }

//function TForm1.EncryptSteganography(ImgSource:TImage; TxtSource:TMemo) : TImage;
//var
//  x, y, i, j: Integer;
//  PixelData: TColor;
//  CharMask, CharData: Byte;
//  imgTarget: TImage;
//begin
//  imgTarget := TImage.Create(Self);
//  imgTarget.Picture.Assign(ImgSource.Picture);
//  imgTarget.Picture.Bitmap.PixelFormat := pf32bit;
//  x := 0;
//  y := 0;
//  with imgTarget.Picture.Bitmap do
//    for i := 1 to Length(TxtSource.Text) do
//    begin
//      CharMask := $80;
//      for j := 1 to 8 do
//      begin
//        CharData := Byte(TxtSource.Text[i]) and CharMask;
//        if (CharData <> 0) then
//        begin
//          // Aqui é a pegadinha
//          PixelData := Canvas.Pixels[x, y] xor $1;
//          Canvas.Pixels[x, y] := PixelData;
//        end;
//        x := (x + 1) mod Width;
//        if (x = 0) then
//        begin
//          Inc(y);
//        end;
//        CharMask := CharMask shr 1;
//      end;
//    end;
//  Result := imgTarget;
//end;

function TForm1.BinToInt(Value: String): LongInt;
var
  i, Size: Integer;
begin
  Result := 0;
  Size := length(Value) - 1;
  for i := 0 to Size do
  begin
    if Value.Substring(i, 1) = '1' then
    begin
      Result := Result + (2 ** (Size - i));
    end;
  end;
end;

function TForm1.ClearByte(BValue: Byte): Byte;
begin
  if BValue mod 2 = 1 then
    Result := BValue - 1
  else
    Result := BValue;
end;

function TForm1.EncryptSteganography(ImgSource: TImage; TxtSource: TMemo): TImage;
var
  Vector       : array [1 .. 2000000] of string;
  RB, GB, BB   : Byte;
  x, y, i, j, k: LongInt;
  ByteData     : string;
  PixelData    : TColor;
  ImgTarget    : TImage;
begin
  k        := 1;
  j        := Length(TxtSource.Text);                       //Tamanho do texto
  ByteData := IntToBin(j, 24);                              //Cabeçalho como o tamanho do texto em binário
  For i := 1 to 24 do                                        //Adciona o cabeçalho de 3 bytes
  begin
    Vector[i] := ByteData.Substring(i-1, 1);
    k := k + 1;
  end;
  //
  for i := 1 to j do
  begin
    ByteData := IntToBin(ord(TxtSource.Text[i]), 8);   //Adiciona texto original em binário
    for j := 0 to 7 do
    begin
      Vector[k] := ByteData.Substring(j,1);
      k := k + 1;
    end;
  end;
  //
  j         := k;
  ImgTarget := TImage.Create(Self);
  ImgTarget.Picture.Assign(ImgSource.Picture);
  ImgTarget.Picture.Bitmap.PixelFormat := pf32bit;
  x := 0;
  y := 0;
  i := 1;
  for y := 0 to ImgSource.Picture.Height-1 do
    for x := 0 to ImgSource.Picture.Width-1 do
    begin
      PixelData := ImgSource.Picture.Bitmap.Canvas.Pixels[x, y];
      //
      RB        := ClearByte(Red(PixelData));
      GB        := ClearByte(Green(PixelData));
      BB        := ClearByte(Blue(PixelData));
      //
      if (i <= j) and (Vector[i] = '1') then RB := RB + 1;
      i  := i + 1;
      if (i <= j) and (Vector[i] = '1') then GB := GB + 1;
      i  := i + 1;
      if (i <= j) and (Vector[i] = '1') then BB := BB + 1;
      i  := i + 1;
      //
      ImgTarget.Picture.Bitmap.Canvas.Pixels[x, y] := RGBToColor(RB, GB, BB);
    end;
  Result := ImgTarget;
end;

function TForm1.DecryptSteganography(ImgSource: TImage): string;
Var
  x, y, i ,j    : integer;
  SizeStr, Texto: string;
  Size          : LongInt;
  RB, GB, BB    : Byte;
  ByteData      : string;
  PixelData     : TColor;
begin
  i := 1;
  SizeStr := '';
  ByteData := '';
  for y := 0 to ImgSource.Picture.Bitmap.Height-1 do
    for x := 0 to ImgSource.Picture.Bitmap.Width-1 do
    begin
      PixelData := ImgSource.Picture.Bitmap.Canvas.Pixels[x, y];
      //
      RB        := Red(PixelData);
      GB        := Green(PixelData);
      BB        := Blue(PixelData);
      //
      if (i <= 24) then SizeStr := SizeStr + IntToStr(RB mod 2);
      i  := i + 1;
      if (i <= 24) then SizeStr := SizeStr + IntToStr(GB mod 2);
      i  := i + 1;
      if (i <= 24) then SizeStr := SizeStr + IntToStr(BB mod 2);
      i  := i + 1;
    end;
  i := 1;
  Size := (BinToInt(SizeStr) * 8) + 24;
  //
  Texto := '';
  for y := 0 to ImgSource.Picture.Bitmap.Height-1 do
    for x := 0 to ImgSource.Picture.Bitmap.Width-1 do
    begin
      PixelData := ImgSource.Picture.Bitmap.Canvas.Pixels[x, y];
      //
      RB        := Red(PixelData);
      GB        := Green(PixelData);
      BB        := Blue(PixelData);
      //
      if (i > 24) and (i <= Size) then ByteData := ByteData + IntToStr(RB mod 2);
      i  := i + 1;
      if (Length(ByteData) = 8) then
      begin
        j := BinToInt(ByteData);
        Texto := Texto + chr(j);
        ByteData := '';
      end;
      if (i > 24) and (i <= Size) then ByteData := ByteData + IntToStr(GB mod 2);
      i  := i + 1;
      if (Length(ByteData) = 8) then
      begin
        j := BinToInt(ByteData);
        Texto := Texto + chr(j);
        ByteData := '';
      end;
      if (i > 24) and (i <= Size) then ByteData := ByteData + IntToStr(BB mod 2);
      i  := i + 1;
      if (Length(ByteData) = 8) then
      begin
        j := BinToInt(ByteData);
        Texto := Texto + chr(j);
        ByteData := '';
      end;
    end;
  Result := Texto;
end;

procedure TForm1.SaveExecute(Sender: TObject);
begin
  Image1 := EncryptSteganography(Image1, Memo1);
  Image1.Picture.SaveToFile(FileName);
end;

procedure TForm1.OpenExecute(Sender: TObject);
var
  Texto: String;
  Capacidade, Tamanho: Integer;
begin
  if OpenDialog1.Execute then
  begin
    FileName := OpenDialog1.Filename;
    Image1.Picture.LoadFromFile(FileName);
    Image1.Picture.Bitmap.PixelFormat := pf32bit;
    Memo1.Append(DecryptSteganography(Image1));
    Image1.Picture.LoadFromFile(FileName);
    Edit1.Text := FileName;
    Ms := TMemoryStream.Create;
    try
      Ms.LoadFromFile(FileName);
      Tamanho := Image1.Picture.Bitmap.Height * Image1.Picture.Bitmap.Width;
      Capacidade := round(Tamanho * 3 / 8) - 1;
      Edit2.Text := IntToStr(Ms.Size) + ' bytes ' + IntToStr(Image1.Picture.Bitmap.Height) + 'x' + IntToStr(Image1.Picture.Bitmap.Width) + ' pixels ' + IntToStr(Capacidade) + ' chars';
      if Ms.Size > 0 then
      begin
        Ms.Position := 0;
        SetString(Texto, PChar(Ms.memory), Ms.Size);
        Edit3.Text := Texto.Substring(0,2);
      end;
    finally
      Ms.Free;
    end;
  end;
end;

procedure TForm1.Exit1Execute(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    Memo1.Clear;
    Edit1.Text := '';
    Edit2.Text := '';
    Edit3.Text := '';
    Edit4.Text := '';
    Edit5.Text := '';
    Edit6.Text := '';
end;

end.

