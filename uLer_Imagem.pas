{*******************************************************}
{                                                       }
{              FELIPE ALVES DE LIMA                     }
{                                                       }
{ https://www.linkedin.com/in/felipe-alves-lima         }
{                                                       }
{*******************************************************}

unit uLer_Imagem;

interface

uses ExtCtrls,DB,DBClient, Classes,  Windows, SysUtils, StdCtrls, Math , Graphics;

type
    THistogramResult = Record
      histogram  : Array of Double;
      min        : Double;
      max        : Double;
    end;

    TRGBArray = array[Word] of TRGBTriple;
    pRGBArray = ^TRGBArray;

    TLerImagem = class (Tobject)

    {$REGION 'Constantes do objeto'}
    // Posi��o inicial valida��o do documento x horizontal y vertical
    const intCor_Procurada = 13000000;

    // Posi��o inicial valida��o do documento
    const intPosicaoInicial_Validacao_X = 30;
    const intPosicaoInicial_Validacao_Y = 60;

    // Tamanho do caracter validador
    const intTamanhoValidador_X  = 8;
    const intTamanhoValidador_Y  = 8;

    // Margens de seguran�a para verificar perguntas e valida��o do documento
    const intMargemSeguranca_Validacao_X = 50;
    const intMargemSeguranca_Validacao_Y = 40;

    // Posi��o inicial valida��o das P�ginas
    const intPosicaoInicial_Paginas_X = 650;
    const intPosicaoInicial_Paginas_Y = 60;

    // Margens de seguran�a para verificar perguntas e valida��o do documento
    const intMargemSeguranca_Paginas_X = 180;
    const intMargemSeguranca_Paginas_Y = 35;


    // Margens de seguran�a para verificar perguntas e valida��o do documento
    const intMargemSeguranca_Perguntas_X = 40;
    const intMargemSeguranca_Perguntas_Y = 30;

    // Posi��o inicial valida��o das P�ginas
    const intPosicaoInicial_Perguntas_X = 30;
    const intPosicaoInicial_Perguntas_Y = 120;

    // Margens de seguran�a para verificar perguntas e valida��o do documento
    const intMargemSeguranca_Respostas_X = 75;
    const intMargemSeguranca_Respostas_Y = 25;

    // Intervalo das respostas a serconsiderado
    const intIntervalo_Respostas_X  = 80;

    // Posi��o inicial respostas do documento
    const intPosicaoInicial_Resposta_A_X = 490;
    const intPosicaoInicial_Resposta_B_X = intPosicaoInicial_Resposta_A_X + intIntervalo_Respostas_X;
    const intPosicaoInicial_Resposta_C_X = intPosicaoInicial_Resposta_B_X + intIntervalo_Respostas_X;
    const intPosicaoInicial_Resposta_D_X = intPosicaoInicial_Resposta_C_X + intIntervalo_Respostas_X;



    // Margens de seguran�a para verificar p�ginas
    const intMargemPaginas_X   = 80;
    const intMargemPaginas_Y   = 80;
    {$ENDREGION}

    Protected

    Private

      {$REGION 'Vari�veis do objeto'}
        // Tabela tempor�ria de retorno da leitura da imagem
        cdsRetorno      : TClientDataSet;
        memoCoordenadas : TStringList;
        intPagina       : Integer;
      {$ENDREGION}

      {$REGION 'Propriedades'}
      // Vari�vel que ir� armazenar a Imagem
      imgImagem     : TBitmap;
      bMarcaLeitura : Boolean;

      procedure SetImage(const Value: TBitmap);
      procedure SetMarcaLeitura(const Value: Boolean);
      {$ENDREGION}

      {$REGION 'Metodos privados'}

      //
      function parsePattern(Pattern : string) : String;

    	function ReadCode39(bmp         : TBitmap;
                          startheight : Integer;
                          endheight   : Integer) : String;


      // Fun��o que ir� efetuar Rotacionar imagem
      procedure RotateBitmap(var hBitmapDC  : Longint;
                             var lWidth     : Longint;
                             var lHeight    : Longint;
                                 lRadians   : real);

      // Efetua o redimencionamento de uma imagem
      procedure EfetuaRedimencionamento(Antigo, Novo: TBitmap);

      // Redimenciona um aimagem
      procedure RedimencionaImagem(var imgBmp: TBitmap; MaxWidth: Integer);


      // Rotacionar imagem
      function RotacionaImagem(imagem : TBitmap) : Boolean;

      // Cria tabela tempor�ria
      function CriaObjetos : Boolean;

      // Fun��o respons�vel por validar a imagem
      function ValidaDocumento : Boolean;

      // Fun��o respons�vel por verificar a pagina em quest�o
      function VerificaPagina : Boolean;

      // Fun��o respons�vel por verificar as perguntas
      function VerificaPerguntas : Boolean;

      // Fun��o respons�vel por buscar as respostas de determinada pergunta
      function BuscaRespostas(intPergunta         : Integer;
                              Y_Inicial_Sequencia : Integer) : Boolean;


      // Fun��o respons�vel por verificar se teve resposta
      function Resposta_A(Y_Inicial : Integer) : Boolean;

      // Fun��o respons�vel por verificar se teve resposta
      function Resposta_B(Y_Inicial : Integer) : Boolean;

      // Fun��o respons�vel por verificar se teve resposta
      function Resposta_C(Y_Inicial : Integer) : Boolean;

      // Fun��o respons�vel por verificar se teve resposta
      function Resposta_D(Y_Inicial : Integer) : Boolean;

      // Fun��o respons�vel por verificar em uma �rea predeterminada
      // se existe o caracter validador pelo eixo X
      function LerMargem_Seguranca_Eixo_X(X_inicial,Y,Margem_Seguranca_X : Integer) : Boolean;

      // Fun��o respons�vel por verificar em uma �rea predeterminada
      // se existe o caracter validador pelo eixo Y
      function LerMargem_Seguranca_Eixo_Y(X,Y_inicial,Margem_Seguranca_Y : Integer) : Boolean;
      {$ENDREGION}

    Public
      // Construtor do objeto em quest�o
      Constructor Create; overload;

      // Fun��o respons�vel por varrer e ler o documento
      function VarreImagem : Boolean;

      // Imagem a ser processada
      property  Imagem              : TBitmap         read imgImagem Write SetImage;
      property  Marca_Leitura       : Boolean         read bMarcaLeitura Write SetMarcaLeitura;
      property  Coordenadas_Validas : TStringList     read memoCoordenadas;
      property  Pagina              : Integer         read intPagina;
      property  cdsLeitura          : TClientDataSet  read cdsRetorno;

    Published

    end;

implementation



{ TLerImagem }


function TLerImagem.BuscaRespostas(intPergunta,Y_Inicial_Sequencia: Integer): Boolean;
begin
  cdsRetorno.Insert;
  cdsRetorno.FieldByName('Pagina').AsInteger := intPagina;
  cdsRetorno.FieldByName('Pergunta').AsInteger := intPergunta;
  cdsRetorno.FieldByName('Resposta_A').AsBoolean := Resposta_A(Y_Inicial_Sequencia);
  cdsRetorno.FieldByName('Resposta_B').AsBoolean := Resposta_B(Y_Inicial_Sequencia);
  cdsRetorno.FieldByName('Resposta_C').AsBoolean := Resposta_C(Y_Inicial_Sequencia);
  cdsRetorno.FieldByName('Resposta_D').AsBoolean := Resposta_D(Y_Inicial_Sequencia);
  cdsRetorno.Post;
end;

constructor TLerImagem.Create;
begin
  {$REGION 'Inicia objetos utilizados na classe'}
    // Tenta criar objetos tempor�rios
    CriaObjetos;
  {$ENDREGION}
end;

function TLerImagem.CriaObjetos: Boolean;
begin
  {$REGION 'Cria tabela tempor�ria'}
  try
    cdsRetorno := TClientDataSet.Create(nil);

    cdsRetorno.Close;
    cdsRetorno.FieldDefs.Clear;
    with cdsRetorno do
       begin
          FieldDefs.Add('Pagina',ftInteger,0,false);
          FieldDefs.Add('Pergunta',ftInteger,0,false);
          FieldDefs.Add('Resposta_A',ftBoolean,0,false);
          FieldDefs.Add('Resposta_B',ftBoolean,0,false);
          FieldDefs.Add('Resposta_C',ftBoolean,0,false);
          FieldDefs.Add('Resposta_D',ftBoolean,0,false);
       end;
    cdsRetorno.CreateDataSet;

  except
    Result := False;

    // Retorna exce��o com o erro ocorrido
    raise Exception.Create('Ler Imagem - Erro ao criar tabela tempor�ria');
  end;
  {$ENDREGION}

  {$REGION 'Cria memo'}
    try
      memoCoordenadas := TStringList.Create;
      memoCoordenadas.Clear;
    except
      Result := False;
      // Retorna exce��o com o erro ocorrido
      raise Exception.Create('Ler Imagem - Erro ao criar objeto memo');
    end;
  {$ENDREGION}

  Result := True;

end;

procedure TLerImagem.EfetuaRedimencionamento(Antigo, Novo: TBitmap);
var
  {$REGION 'DECLARA��O DAS VARI�VEIS'}
  x, y: Integer;
  xP, yP: Integer;
  xP2, yP2: Integer;
  SrcLine1, SrcLine2: pRGBArray;
  t3: Integer;
  z, z2, iz2: Integer;
  DstLine: pRGBArray;
  DstGap: Integer;
  w1, w2, w3, w4: Integer;
  {$ENDREGION}
begin
  {$REGION 'EFETUA O REDIMENCIONAMENTO'}
  Antigo.PixelFormat := pf24Bit;
  Novo.PixelFormat := pf24Bit;

  if (Antigo.Width = Novo.Width) and (Antigo.Height = Novo.Height) then
    Novo.Assign(Antigo)
  else
  begin
    DstLine := Novo.ScanLine[0];
    DstGap  := Integer(Novo.ScanLine[1]) - Integer(DstLine);

    xP2 := MulDiv(pred(Antigo.Width), $10000, Novo.Width);
    yP2 := MulDiv(pred(Antigo.Height), $10000, Novo.Height);
    yP  := 0;

    for y := 0 to pred(Novo.Height) do
    begin
      xP := 0;

      SrcLine1 := Antigo.ScanLine[yP shr 16];

      if (yP shr 16 < pred(Antigo.Height)) then
        SrcLine2 := Antigo.ScanLine[succ(yP shr 16)]
      else
        SrcLine2 := Antigo.ScanLine[yP shr 16];

      z2  := succ(yP and $FFFF);
      iz2 := succ((not yp) and $FFFF);
      for x := 0 to pred(Novo.Width) do
      begin
        t3 := xP shr 16;
        z  := xP and $FFFF;
        w2 := MulDiv(z, iz2, $10000);
        w1 := iz2 - w2;
        w4 := MulDiv(z, z2, $10000);
        w3 := z2 - w4;
        DstLine[x].rgbtRed := (SrcLine1[t3].rgbtRed * w1 +
          SrcLine1[t3 + 1].rgbtRed * w2 +
          SrcLine2[t3].rgbtRed * w3 + SrcLine2[t3 + 1].rgbtRed * w4) shr 16;
        DstLine[x].rgbtGreen :=
          (SrcLine1[t3].rgbtGreen * w1 + SrcLine1[t3 + 1].rgbtGreen * w2 +

          SrcLine2[t3].rgbtGreen * w3 + SrcLine2[t3 + 1].rgbtGreen * w4) shr 16;
        DstLine[x].rgbtBlue := (SrcLine1[t3].rgbtBlue * w1 +
          SrcLine1[t3 + 1].rgbtBlue * w2 +
          SrcLine2[t3].rgbtBlue * w3 +
          SrcLine2[t3 + 1].rgbtBlue * w4) shr 16;
        Inc(xP, xP2);
      end; {for}
      Inc(yP, yP2);
      DstLine := pRGBArray(Integer(DstLine) + DstGap);
    end; {for}
  end; {if}
  {$ENDREGION}
end;

procedure TLerImagem.SetImage(const Value: TBitmap);
begin
  {$Region 'Valida a imagem a ser armazenada'}
    imgImagem := Value;
  {$EndRegion}
end;


procedure TLerImagem.SetMarcaLeitura(const Value: Boolean);
begin
  {$REGION 'Seta variavel marca leitura'}
    bMarcaLeitura := Value;
  {$ENDREGION}
end;

function TLerImagem.ValidaDocumento: Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Zera o contador
  intContador := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo Y
  for  Y := intPosicaoInicial_Validacao_Y to intPosicaoInicial_Validacao_Y + intMargemSeguranca_Validacao_Y do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Validacao_X,Y,intMargemSeguranca_Validacao_X) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta Retorno como Verdadeiro
        bRetorno := true;
        Break;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.VarreImagem: Boolean;
var
  bRetorno      : Boolean;
  bPintaLeitura : Boolean;
begin
  {$REGION 'EFETUA A LEITURA DA IMAGEM'}
  bRetorno := true;

  // Armazena o valor setado pelo usu�rio
  bPintaLeitura := bMarcaLeitura;

  // For�a marcar leitura para falso
  bMarcaLeitura := false;

  // Redimenciona Imagem
  RedimencionaImagem(imgImagem,830);

  // Valida o documento
  if not ValidaDocumento then
  begin
    // Rotaciona a imagem
    RotacionaImagem(imgImagem);
  end;

  // Retorna o valor de marcar leitura para o atribuido pelo usu�rio
  bMarcaLeitura := bPintaLeitura;

  // Valida o documento
  if ValidaDocumento then
  begin
    // Verifica p�ginas
    if VerificaPagina then
    begin
      // Verifica Perguntas
      if VerificaPerguntas then
      begin
        bRetorno := true
      end
      else
      begin
        bRetorno := false;

        // Retorna exce��o com o erro ocorrido
        raise Exception.Create('Ler Imagem - Erro ao validar as perguntas');
      end;
    end
    else
    begin
      bRetorno := false;

      // Retorna exce��o com o erro ocorrido
      raise Exception.Create('Ler Imagem - Erro ao validar o n�mero da p�gina');
    end;
  end
  else
  begin
    bRetorno := False;

    // Retorna exce��o com o erro ocorrido
    raise Exception.Create('Ler Imagem - Erro ao validar documento');
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.VerificaPagina: Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VERIFICA��O DA PAGINA'}
  // Zera o contador
  intContador := 0;
  intPagina   := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo X
  for  X := intPosicaoInicial_Paginas_X to intPosicaoInicial_Paginas_X + intMargemSeguranca_Paginas_X do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_Y(X,intPosicaoInicial_Paginas_Y,intMargemSeguranca_Paginas_Y) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_X then
      begin
        // Incrementa Pagina
        inc(intPagina);

        // Zera contador
        intContador := 0;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  // Verifica se encontrou p�ginas
  if intPagina > 0 then
  begin
    bRetorno := true;
  end;

  Result := bRetorno;
end;

function TLerImagem.VerificaPerguntas: Boolean;
var
  Y                   : Integer;
  X                   : Integer;
  Y_Inicial_Sequencia : Integer;
  intContador         : Integer;
  intPergunta         : Integer;
  bRetorno            : Boolean;
begin

  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Inicializa vari�veis
  intContador         := 0;
  Y                   := 0;
  X                   := 0;
  Y_Inicial_Sequencia := 0;
  intPergunta         := 0;
  bRetorno            := false;

  // Varre a imagem no eixo Y
  for  Y := intPosicaoInicial_Perguntas_Y to imgImagem.Height do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Perguntas_X,Y,intMargemSeguranca_Perguntas_X) then
    begin
      // Armazena o Y inicial da sequencia
      if Y_Inicial_Sequencia <= 0 then
      begin
        // Armazena o Y inicial da sequencia de pixels validos
        Y_Inicial_Sequencia := Y;
      end;

      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta o retorno
        bRetorno := true;

        // Incrementa a pergunta
        inc(intPergunta);

        // Busca as respostas da Pergunta
        BuscaRespostas(intPergunta,Y_Inicial_Sequencia - 5);

        // Zera contador
        intContador := 0;

      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
      // Zera o Y Inicial da sequencia
      Y_Inicial_Sequencia := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;


function TLerImagem.LerMargem_Seguranca_Eixo_X(X_inicial, Y, Margem_Seguranca_X: Integer): Boolean;
var
  x_atual      : Integer;
  x_final      : Integer;
  intCor       : Integer;
  intContador  : Integer;
  bRetorno     : Boolean;
begin
  {$REGION 'Varre o eixo X at� a margem de seguran�a'}
  // Inicializa vari�veis
  x_atual      := 0;
  x_final      := 0;
  intCor       := 0;
  intContador  := 0;
  bRetorno     := false;

  // X Final ser� igual ao eixo X passado no par�metro + Margem de seguran�a no eixo X
  x_final := X_inicial + Margem_Seguranca_X;

  // Efetua uma varredura no eixo X
  for x_atual := X_inicial to x_final do
  begin
      // Recebe a cor do pixel
      intCor := imgImagem.Canvas.Pixels[x_atual,y];

      // Marca Leitura
      if bMarcaLeitura then
        imgImagem.Canvas.Pixels[x_atual,y] := clRed;

      // Verifica se o pixel esta em um padr�o de cor procurada
      if intCor <= intCor_Procurada then
      begin
        // Caso o pixel esteja no padr�o de cor procurada incrementa o contador
        inc(intContador);

        // Marca Leitura
        if bMarcaLeitura then
          imgImagem.Canvas.Pixels[x_atual,y] := clYellow;

        // Armazena a posi��o X e Y se a quantidade de pixels no padr�o de cor for atingido
        if intContador >= intTamanhoValidador_X  then
        begin
          memoCoordenadas.Add('Pergunta = X: ' + IntToStr(x_atual) + ' Y: ' + IntToStr(Y));
          bRetorno := true;
          Break;
        end;
      end
      else
      begin
        // Caso o pixel n�o esteja no padr�o de cor procurada zera o contador
        intContador := 0;
      end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.LerMargem_Seguranca_Eixo_Y(X, Y_inicial,Margem_Seguranca_Y: Integer): Boolean;
var
  y_atual      : Integer;
  y_final      : Integer;
  intCor       : Integer;
  intContador  : Integer;
  bRetorno     : Boolean;
begin
  {$REGION 'Varre o eixo Y at� a margem de seguran�a'}
  // Inicializa vari�veis
  y_atual      := 0;
  y_final      := 0;
  intCor       := 0;
  intContador  := 0;
  bRetorno     := false;

  // Y Final ser� igual ao eixo Y passado no par�metro + Margem_Seguranca_Y de seguran�a no eixo Y
  y_final := Y_inicial + Margem_Seguranca_Y;

  // Efetua uma varredura no eixo X
  for y_atual := Y_inicial to y_final do
  begin
      // Recebe a cor do pixel
      intCor := imgImagem.Canvas.Pixels[x,y_atual];

      // Marca Leitura
      if bMarcaLeitura then
        imgImagem.Canvas.Pixels[x,y_atual] := clRed;

      // Verifica se o pixel esta em um padr�o de cor procurada
      if intCor <= intCor_Procurada then
      begin
        // Caso o pixel esteja no padr�o de cor procurada incrementa o contador
        inc(intContador);

        // Marca Leitura
        if bMarcaLeitura then
          imgImagem.Canvas.Pixels[x,y_atual] := clYellow;

        // Armazena a posi��o X e Y se a quantidade de pixels no padr�o de cor for atingido
        if intContador >= intTamanhoValidador_Y  then
        begin
          memoCoordenadas.Add('Pergunta = X: ' + IntToStr(x) + ' Y: ' + IntToStr(y_atual));
          bRetorno := true;
          Break;
        end;
      end
      else
      begin
        // Caso o pixel n�o esteja no padr�o de cor procurada zera o contador
        intContador := 0;
      end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.parsePattern(Pattern: string): String;
var
  {$REGION 'DECLARA��O DE VARI�VEIS'}
  strRetorno : String;
  {$ENDREGION}
begin
  {$REGION 'EFETUA O CONVERTE O PATTERN'}
    if Pattern = 'wnnwnnnnw' then      strRetorno := '1'
    else if Pattern = 'nnwwnnnnw' then strRetorno := '2'
    else if Pattern = 'wnwwnnnnn' then strRetorno := '3'
    else if Pattern = 'nnnwwnnnw' then strRetorno := '4'
    else if Pattern = 'wnnwwnnnn' then strRetorno := '5'
    else if Pattern = 'nnwwwnnnn' then strRetorno := '6'
    else if Pattern = 'nnnwnnwnw' then strRetorno := '7'
    else if Pattern = 'wnnwnnwnn' then strRetorno := '8'
    else if Pattern = 'nnwwnnwnn' then strRetorno := '9'
    else if Pattern = 'nnnwwnwnn' then strRetorno := '0'
    else if Pattern = 'wnnnnwnnw' then strRetorno := 'A'
    else if Pattern = 'nnwnnwnnw' then strRetorno := 'B'
    else if Pattern = 'wnwnnwnnn' then strRetorno := 'C'
    else if Pattern = 'nnnnwwnnw' then strRetorno := 'D'
    else if Pattern = 'wnnnwwnnn' then strRetorno := 'E'
    else if Pattern = 'nnwnwwnnn' then strRetorno := 'F'
    else if Pattern = 'nnnnnwwnw' then strRetorno := 'G'
    else if Pattern = 'wnnnnwwnn' then strRetorno := 'H'
    else if Pattern = 'nnwnnwwnn' then strRetorno := 'I'
    else if Pattern = 'nnnnwwwnn' then strRetorno := 'J'
    else if Pattern = 'wnnnnnnww' then strRetorno := 'K'
    else if Pattern = 'nnwnnnnww' then strRetorno := 'L'
    else if Pattern = 'wnwnnnnwn' then strRetorno := 'M'
    else if Pattern = 'nnnnwnnww' then strRetorno := 'N'
    else if Pattern = 'wnnnwnnwn' then strRetorno := 'O'
    else if Pattern = 'nnwnwnnwn' then strRetorno := 'P'
    else if Pattern = 'nnnnnnwww' then strRetorno := 'Q'
    else if Pattern = 'wnnnnnwwn' then strRetorno := 'R'
    else if Pattern = 'nnwnnnwwn' then strRetorno := 'S'
    else if Pattern = 'nnnnwnwwn' then strRetorno := 'T'
    else if Pattern = 'wwnnnnnnw' then strRetorno := 'U'
    else if Pattern = 'nwwnnnnnw' then strRetorno := 'V'
    else if Pattern = 'wwwnnnnnn' then strRetorno := 'W'
    else if Pattern = 'nwnnwnnnw' then strRetorno := 'X'
    else if Pattern = 'wwnnwnnnn' then strRetorno := 'Y'
    else if Pattern = 'nwwnwnnnn' then strRetorno := 'Z'
    else if Pattern = 'nwnnnnwnw' then strRetorno := '-'
    else if Pattern = 'wwnnnnwnn' then strRetorno := '.'
    else if Pattern = 'nwwnnnwnn' then strRetorno := ' '
    else if Pattern = 'nwnnwnwnn' then strRetorno := '*'
    else if Pattern = 'nwnwnwnnn' then strRetorno := '$'
    else if Pattern = 'nwnwnnnwn' then strRetorno := '/'
    else if Pattern = 'nwnnnwnwn' then strRetorno := '+'
    else if Pattern = 'nnnwnwnwn' then strRetorno := '%'
    else strRetorno := EmptyStr;
  {$ENDREGION}

  Result := strRetorno;
end;

function TLerImagem.ReadCode39(bmp          : TBitmap;
                               startheight  : Integer;
                               endheight    : Integer): String;
var
  {$REGION 'DECLARA��O DE VARI�VEIS'}
    vertHist        : THistogramResult;
    threshold       : Double;
    patternString   : string;
    nBarStart       : Integer;
    nNarrowBarWidth : Integer;
    bDarkBar        : Boolean;
  {$ENDREGION}
begin
  with vertHist do
  begin

  end;


end;

procedure TLerImagem.RedimencionaImagem(var imgBmp: TBitmap; MaxWidth: Integer);
var
  aWidth: Integer;
  NewBitmap: TBitmap;
begin
  {$REGION 'REDIMENCIONA IMAGEM'}
  aWidth := imgBmp.Width;
  if (imgBmp.Width <> MaxWidth) then
  begin
    aWidth    := MaxWidth;
    NewBitmap := TBitmap.Create;
    try
      NewBitmap.Width  := MaxWidth;
      NewBitmap.Height := MulDiv(MaxWidth, imgBmp.Height, imgBmp.Width);
      EfetuaRedimencionamento(imgBmp, NewBitmap);
      NewBitmap.SaveToFile('c:\tmp.bmp');
      imgBmp.LoadFromFile('c:\tmp.bmp');
      DeleteFile('c:\tmp.bmp')
    finally
      NewBitmap.Free;
    end; {try}
  end; {if}
  {$ENDREGION}
end;

function TLerImagem.Resposta_A(Y_Inicial : Integer): Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Zera o contador
  intContador := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo Y
  for  Y := Y_Inicial to Y_Inicial + intMargemSeguranca_Respostas_Y do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Resposta_A_X,Y,intMargemSeguranca_Respostas_X) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta Retorno como Verdadeiro
        bRetorno := true;
        Break;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.Resposta_B(Y_Inicial : Integer): Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Zera o contador
  intContador := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo Y
  for  Y := Y_Inicial to Y_Inicial + intMargemSeguranca_Respostas_Y do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Resposta_B_X,Y,intMargemSeguranca_Respostas_X) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta Retorno como Verdadeiro
        bRetorno := true;
        Break;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.Resposta_C(Y_Inicial : Integer): Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Zera o contador
  intContador := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo Y
  for  Y := Y_Inicial to Y_Inicial + intMargemSeguranca_Respostas_Y do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Resposta_C_X,Y,intMargemSeguranca_Respostas_X) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta Retorno como Verdadeiro
        bRetorno := true;
        Break;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.Resposta_D(Y_Inicial : Integer): Boolean;
var
  Y           : Integer;
  X           : Integer;
  intContador : Integer;
  bRetorno    : Boolean;
begin
  {$REGION 'EFETUA A VARREDURA PARA A VALIDA��O DO DOCUMENTO'}
  // Zera o contador
  intContador := 0;

  // Seta Retorno como falso
  bRetorno := false;

  // Varre a imagem no eixo Y
  for  Y := Y_Inicial to Y_Inicial + intMargemSeguranca_Respostas_Y do
  begin
    // Verifica se encontra um padr�o de sequencia de pixels
    if LerMargem_Seguranca_Eixo_X(intPosicaoInicial_Resposta_D_X,Y,intMargemSeguranca_Respostas_X) then
    begin
      // Incrementa o contador at� chegar na quantidade de "Padr�es" desejado
      inc(intContador);

      // Verifica se o contador chegou at� a quantidade desejada
      if intContador >= intTamanhoValidador_Y then
      begin
        // Seta Retorno como Verdadeiro
        bRetorno := true;
        Break;
      end;
    end
    else
    begin
      // Zera contador
      intContador := 0;
    end;
  end;
  {$ENDREGION}

  Result := bRetorno;
end;

function TLerImagem.RotacionaImagem(imagem: TBitmap): Boolean;
var
  {$REGION 'DECLARA��O DE VARI�VEIS'}
    lRadians : real;
    DC  : longint;
    H, W : integer;
    Degrees : integer;
  {$ENDREGION}
begin
  {$REGION 'EFETUA A ROTA��O DA IMAGEM'}
    Degrees := 180;
    lRadians := PI * Degrees / 180;
    DC := imagem.Canvas.Handle;
    H := imagem.Height;
    W := imagem.Width;
    RotateBitmap(DC, W, H, lRadians);
    imagem.Width := W;
    imagem.Height := H;
    imagem.Width := W;
    imagem.Height := H;
    BitBlt(imagem.Canvas.Handle, 0, 0, W, H, DC, 0, 0, SRCCopy);
  {$ENDREGION}
end;

procedure TLerImagem.RotateBitmap(var hBitmapDC,
                                      lWidth,
                                      lHeight   : Integer;
                                      lRadians  : real);
var
  {$REGION 'DECLARA��O DE VARI�VEIS'}
  I : Longint;              // loop counter
  J : Longint;              // loop counter
  hNewBitmapDC : Longint;   // DC of the new bitmap
  hNewBitmap : Longint;     // handle to the new bitmap
  lSine : extended;         // sine used in rotation
  lCosine : extended;       // cosine used in rotation
  X1 : Longint;             // used in calculating new
                            //   bitmap dimensions
  X2 : Longint;             // used in calculating new
                            //     bitmap dimensions
  X3 : Longint;             // used in calculating new
                            //     bitmap dimensions
  Y1 : Longint;             // used in calculating new
                            // bitmap dimensions
  Y2 : Longint;             // used in calculating new
                            // bitmap dimensions
  Y3 : Longint;             // used in calculating new
                            // bitmap dimensions
  lMinX : Longint;          // used in calculating new
                            // bitmap dimensions
  lMaxX : Longint;          // used in calculating new
                            // bitmap dimensions
  lMinY : Longint;          // used in calculating new
                            // bitmap dimensions
  lMaxY : Longint;          // used in calculating new
                            // bitmap dimensions
  lNewWidth : Longint;      // width of new bitmap
  lNewHeight : Longint;     // height of new bitmap
  lSourceX : Longint;       // x pixel coord we are blitting
                            // from the source  image
  lSourceY : Longint;       // y pixel coord we are blitting
                            // from the source image
  {$ENDREGION}
begin
  {$REGION 'EFETUA A ROTA��O DA IMAGEM'}
   // create a compatible DC from the one just brought
   // into this function
   hNewBitmapDC := CreateCompatibleDC(hBitmapDC);

   // compute the sine/cosinse of the radians used to
   // rotate this image
   lSine := Sin(lRadians);
   lCosine := Cos(lRadians);

   // compute the size of the new bitmap being created
   X1 := Round(-lHeight * lSine);
   Y1 := Round(lHeight * lCosine);
   X2 := Round(lWidth * lCosine - lHeight * lSine);
   Y2 := Round(lHeight * lCosine + lWidth * lSine);
   X3 := Round(lWidth * lCosine);
   Y3 := Round(lWidth * lSine);

   // figure out the max/min size of the new bitmap
   lMinX := Min(0, Min(X1, Min(X2, X3)));
   lMinY := Min(0, Min(Y1, Min(Y2, Y3)));
   lMaxX := Max(X1, Max(X2, X3));
   lMaxY := Max(Y1, Max(Y2, Y3));

   // set the new bitmap width/height
   lNewWidth := lMaxX - lMinX;
   lNewHeight := lMaxY - lMinY;

   // create a new bitmap based upon the new width/height of the
   // rotated bitmap
   hNewBitmap := CreateCompatibleBitmap(hBitmapDC, lNewWidth, lNewHeight);

   //attach the new bitmap to the new device context created
   //above before constructing the rotated bitmap
   SelectObject(hNewBitmapDC, hNewBitmap);

   // loop through and translate each pixel to its new location.
   // this is using a standard rotation algorithm
   For I := 0 To lNewHeight do begin
      For J := 0 To lNewWidth do begin
         lSourceX := Round((J + lMinX) * lCosine + (I + lMinY) * lSine);
         lSourceY := Round((I + lMinY) * lCosine - (J + lMinX) * lSine);
         If (lSourceX >= 0) And (lSourceX <= lWidth) And
         (lSourceY >= 0) And (lSourceY <= lHeight) Then
             BitBlt(hNewBitmapDC, J, I, 1, 1, hBitmapDC,
                        lSourceX, lSourceY, SRCCOPY);
      end;
   end;

   // reset the new bitmap width and height
   lWidth := lNewWidth;
   lHeight := lNewHeight;

   // return the DC to the new bitmap
   hBitmapDC := hNewBitmapDC;

   // destroy the bitmap created
   DeleteObject(hNewBitmap);
  {$ENDREGION}
end;

end.
