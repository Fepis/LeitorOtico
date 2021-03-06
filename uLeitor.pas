{*******************************************************}
{                                                       }
{              FELIPE ALVES DE LIMA                     }
{                                                       }
{ https://www.linkedin.com/in/felipe-alves-lima         }
{                                                       }
{*******************************************************}
unit uLeitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ComCtrls, DB, DBClient, Grids, DBGrids;

type
  TfrmImagem_Scan = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ScrollBox1: TScrollBox;
    imgDisplay: TImage;
    memoCoordenadas: TMemo;
    Panel1: TPanel;
    btnObjeto: TButton;
    btnPag1: TButton;
    lblPosition: TLabel;
    lblCor: TLabel;
    TabSheet2: TTabSheet;
    cdsLeitura: TClientDataSet;
    memoRetorno: TMemo;
    btnPag2: TButton;
    btnPag3: TButton;
    btnErroValidador: TButton;
    btnErroPagina: TButton;
    btnPaginaVirada: TButton;
    chkMarcaLeitura: TCheckBox;
    procedure imgDisplayMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnPag1Click(Sender: TObject);
    procedure btnObjetoClick(Sender: TObject);
    procedure btnPag3Click(Sender: TObject);
    procedure btnPag2Click(Sender: TObject);
    procedure btnPaginaViradaClick(Sender: TObject);
    procedure btnErroValidadorClick(Sender: TObject);
    procedure btnErroPaginaClick(Sender: TObject);
  private
    { Private declarations }
    procedure Habilita_DesabilitaComponentes(bHabideslita : Boolean);

  public
    { Public declarations }
  end;

var
  frmImagem_Scan: TfrmImagem_Scan;

implementation

uses
  uLer_Imagem, uInformacao;

{$R *.dfm}

procedure TfrmImagem_Scan.btnPag1Click(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  btnPag1.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA PAGINA 1'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\1.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\1.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\1.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnPag1.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;

end;

procedure TfrmImagem_Scan.btnPag2Click(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  btnPag2.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA PAGINA 2'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\2.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\2.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\2.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnPag2.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;

end;

procedure TfrmImagem_Scan.btnPag3Click(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  btnPag3.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA PAGINA 3'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\3.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    //imgBmp.Monochrome := true;
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\3.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\3.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnPag3.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;
end;

procedure TfrmImagem_Scan.btnPaginaViradaClick(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  btnPaginaVirada.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA IMAGEM PAGINA VIRADA'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\virada.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    //imgBmp.Monochrome := true;
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\virada.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\virada.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnPaginaVirada.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;

end;

procedure TfrmImagem_Scan.Habilita_DesabilitaComponentes(bHabideslita: Boolean);
begin
  btnPag1.Enabled := bHabideslita;
  btnPag2.Enabled := bHabideslita;
  btnPag3.Enabled := bHabideslita;
  btnErroValidador.Enabled := bHabideslita;
  btnErroPagina.Enabled := bHabideslita;
  btnPaginaVirada.Enabled := bHabideslita;
  btnObjeto.Enabled := bHabideslita;
  chkMarcaLeitura.Enabled := bHabideslita;
end;

procedure TfrmImagem_Scan.btnErroPaginaClick(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  btnErroPagina.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA IMAGEM PAGINA ERRO VALIDADOR'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\erro_paginas.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    //imgBmp.Monochrome := true;
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\erro_paginas.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\erro_paginas.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnErroPagina.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;

end;

procedure TfrmImagem_Scan.btnErroValidadorClick(Sender: TObject);
var
 imgJPG : TJPEGImage;
 imgBmp : TBitmap;
begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  btnErroValidador.Enabled := false;
  frmInformacao.Show;
  frmInformacao.lblInformacao.Caption := 'Aguarde carregando imagem....';
  Habilita_DesabilitaComponentes(false);
  Application.ProcessMessages;

  {$REGION 'CARREGA IMAGEM PAGINA ERRO VALIDADOR'}
  try
    // Instancia os objetos em quest�o
    imgJPG := TJPEGImage.Create;
    imgBmp := TBitmap.Create;

    // Carrega imagem jpg em quest�o
    imgJPG.LoadFromFile(ExtractFilePath(Application.ExeName) + '\erro_validador.jpg');
    imgJPG.JPEGNeeded;

    // Converte a imagem para BMP - monocromatico
    imgBmp.Assign(imgJPG);
    //imgBmp.Monochrome := true;
    imgBmp.SaveToFile(ExtractFilePath(Application.ExeName) + '\erro_validador.bmp');

    imgDisplay.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\erro_validador.bmp');

  finally
    FreeAndNil(imgJPG);
    FreeAndNil(imgBmp);
  end;
  {$ENDREGION}

  Habilita_DesabilitaComponentes(true);
  frmInformacao.Close;
  btnErroValidador.Enabled := true;
  Screen.Cursor := crArrow;
  Application.ProcessMessages;

end;

procedure TfrmImagem_Scan.btnObjetoClick(Sender: TObject);
var
  lerImagem : TLerImagem;
  strLinha  : String;
begin
  try
    Screen.Cursor := crSQLWait;
    Application.ProcessMessages;
    btnObjeto.Enabled := false;
    frmInformacao.Show;
    frmInformacao.lblInformacao.Caption := 'Efetuando a Leitura da imagem aguarde....';
    Habilita_DesabilitaComponentes(false);
    Application.ProcessMessages;

    {$REGION 'L� IMAGEM'}
    memoCoordenadas.Clear;
    memoRetorno.Clear;

    if cdsLeitura.Active then
      cdsLeitura.EmptyDataSet;


    lerImagem := TLerImagem.Create;




    lerImagem.Imagem := imgDisplay.Picture.Bitmap;   // BMP
    lerImagem.Marca_Leitura := chkMarcaLeitura.Checked;
    lerImagem.VarreImagem;
    imgDisplay.Picture.Bitmap := lerImagem.Imagem;
    imgDisplay.Refresh;
    memoCoordenadas.Lines := lerImagem.Coordenadas_Validas;



    cdsLeitura := lerImagem.cdsLeitura;

    strLinha := EmptyStr;
    strLinha := strLinha + 'Pagina: ' + cdsLeitura.FieldByName('Pagina').AsString;
    memoRetorno.Lines.Add(strLinha);
    memoRetorno.Lines.Add('');

    cdsLeitura.last;
    while not cdsLeitura.Bof do
    begin
      strLinha := EmptyStr;
      strLinha := strLinha + 'Pergunta : ' + cdsLeitura.FieldByName('Pergunta').AsString;
      strLinha := strLinha + ' | Resposta : ';
      if (cdsLeitura.FieldByName('Resposta_A').AsBoolean) then
      begin
        strLinha := strLinha + ' A ';
      end;
      if (cdsLeitura.FieldByName('Resposta_B').AsBoolean) then
      begin
        strLinha := strLinha + ' B ';
      end;
      if (cdsLeitura.FieldByName('Resposta_C').AsBoolean) then
      begin
        strLinha := strLinha + ' C ';
      end;
      if (cdsLeitura.FieldByName('Resposta_D').AsBoolean) then
      begin
        strLinha := strLinha + ' D ';
      end;

      memoRetorno.Lines.Add(strLinha);
      memoRetorno.Lines.Add('');
      cdsLeitura.Prior;
    end;
    {$ENDREGION}

  finally
   Habilita_DesabilitaComponentes(true);
   frmInformacao.Close;
    btnObjeto.Enabled := true;
    Screen.Cursor := crArrow;
    Application.ProcessMessages;
  end;
end;

procedure TfrmImagem_Scan.imgDisplayMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  lblPosition.Caption := 'X:' + IntToStr(X) + ' Y:' + IntToStr(Y) + ' Color:' + IntToStr(imgDisplay.Canvas.Pixels[x,y]);
  lblCor.Color := imgDisplay.Canvas.Pixels[x,y];
end;

end.
