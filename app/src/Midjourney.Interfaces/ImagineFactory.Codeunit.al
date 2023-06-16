codeunit 50074 "ImagineFactory"
{
    #region Setup
    var
        _Setup: Record "MidJourney Setup";
        _SetupIsDefined: Boolean;

    procedure Setup(): Record "MidJourney Setup"
    var
        DefaultImplementationCodeunit: Record "MidJourney Setup";
    begin
        if not _SetupIsDefined then begin
            DefaultImplementationCodeunit.Get();
            SetSetup(DefaultImplementationCodeunit);
        end;

        exit(_Setup);
    end;

    procedure SetSetup(pSetup: Record "MidJourney Setup")
    begin
        _Setup := pSetup;
        _SetupIsDefined := true;
    end;
    #endregion Setup

    #region Imagine
    var
        _Imagine: Interface IMidjourneyImagine;
        _ImagineIsDefined: Boolean;

    procedure Imagine(): Interface IMidjourneyImagine
    var
        DefaultImplementationCodeunit: Codeunit "Midjourney - Imagine";
    begin
        if not _ImagineIsDefined then
            SetImagine(DefaultImplementationCodeunit);

        exit(_Imagine);
    end;

    procedure SetImagine(IImagine: Interface IMidjourneyImagine)
    begin
        _Imagine := IImagine;
        _ImagineIsDefined := true;
    end;
    #endregion Imagine

    #region Result
    var
        _Result: Interface IMidjourneyResult;
        _ResultIsDefined: Boolean;

    procedure Result(): Interface IMidjourneyResult
    var
        DefaultImplementationCodeunit: Codeunit "Midjourney - Result";
    begin
        if not _ResultIsDefined then
            SetResult(DefaultImplementationCodeunit);

        exit(_Result);
    end;

    procedure SetResult(IResult: Interface IMidjourneyResult)
    begin
        _Result := IResult;
        _ResultIsDefined := true;
    end;
    #endregion Result

    #region Send
    var
        _Send: Interface IMidJourneySend;
        _SendIsDefined: Boolean;

    procedure Send(): Interface IMidJourneySend
    var
        DefaultImplementationCodeunit: Codeunit "MidJourney - Send";
    begin
        if not _SendIsDefined then
            SetSend(DefaultImplementationCodeunit);

        exit(_Send);
    end;

    procedure SetSend(ISend: Interface IMidJourneySend)
    begin
        _Send := ISend;
        _SendIsDefined := true;
    end;
    #endregion Send

    #region ResponseHandler
    var
        _ResponseHandler: Interface "IMidJourneySend ResponseHandler";
        _ResponseHandlerIsDefined: Boolean;

    procedure ResponseHandler(): Interface "IMidJourneySend ResponseHandler"
    var
        DefaultImplementationCodeunit: Codeunit "MidJourneySend ResponseHandler";
    begin
        if not _ResponseHandlerIsDefined then
            SetResponseHandler(DefaultImplementationCodeunit);

        exit(_ResponseHandler);
    end;

    procedure SetResponseHandler(IResponseHandler: Interface "IMidJourneySend ResponseHandler")
    begin
        _ResponseHandler := IResponseHandler;
        _ResponseHandlerIsDefined := true;
    end;
    #endregion ResponseHandler
}