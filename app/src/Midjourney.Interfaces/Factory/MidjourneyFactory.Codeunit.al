codeunit 50074 "Midjourney Factory" implements IMidjourneyFactory
{
    #region MidjourneySetup
    var
        _MidjourneySetup: Interface IMidjourneySetup;
        _MidjourneySetupIsDefined: Boolean;

    procedure GetMidjourneySetup(): Interface IMidjourneySetup
    var
        Setup: Record "Midjourney Setup";
    begin
        if not _MidjourneySetupIsDefined then begin
            Setup.SetConfigurationProvider(GetConfigurationProvider());
            Setup.GetForMidjourney();
            exit(Setup.ToMidjourneySetup());
        end;

        exit(_MidjourneySetup);
    end;

    procedure SetMidjourneySetup(IMidjourneySetup: Interface IMidjourneySetup)
    begin
        _MidjourneySetup := IMidjourneySetup;
        _MidjourneySetupIsDefined := true;
    end;
    #endregion MidjourneySetup

    #region Imagine
    var
        _Imagine: Interface IMidjourneyImagine;
        _ImagineIsDefined: Boolean;

    procedure GetMidjourneyImagine(): Interface IMidjourneyImagine
    var
        DefaultImplementationCodeunit: Codeunit "Midjourney - Imagine";
    begin
        if not _ImagineIsDefined then
            SetMidjourneyImagine(DefaultImplementationCodeunit);

        exit(_Imagine);
    end;

    procedure SetMidjourneyImagine(IImagine: Interface IMidjourneyImagine)
    begin
        _Imagine := IImagine;
        _ImagineIsDefined := true;
    end;
    #endregion Imagine

    #region Result
    var
        _Result: Interface IMidjourneyResult;
        _ResultIsDefined: Boolean;

    procedure GetMidjourneyResult(): Interface IMidjourneyResult
    var
        DefaultImplementationCodeunit: Codeunit "Midjourney - Result";
    begin
        if not _ResultIsDefined then
            SetMidjourneyResult(DefaultImplementationCodeunit);

        exit(_Result);
    end;

    procedure SetMidjourneyResult(IResult: Interface IMidjourneyResult)
    begin
        _Result := IResult;
        _ResultIsDefined := true;
    end;
    #endregion Result

    #region Send
    var
        _Send: Interface IMidjourneySend;
        _SendIsDefined: Boolean;

    procedure GetMidjourneySend(): Interface IMidjourneySend
    var
        DefaultImplementationCodeunit: Codeunit "MidJourney - Send";
    begin
        if not _SendIsDefined then
            SetMidjourneySend(DefaultImplementationCodeunit);

        exit(_Send);
    end;

    procedure SetMidjourneySend(ISend: Interface IMidjourneySend)
    begin
        _Send := ISend;
        _SendIsDefined := true;
    end;
    #endregion Send

    #region ConfigurationProvider
    var
        _ConfigurationProvider: Interface IConfigurationProvider;
        _ConfigurationProviderIsDefined: Boolean;

    procedure GetConfigurationProvider(): Interface IConfigurationProvider
    var
        DefaultImplementationCodeunit: Codeunit IsolatedStorageConfigProvider;
    begin
        if not _ConfigurationProviderIsDefined then
            SetConfigurationProvider(DefaultImplementationCodeunit);

        exit(_ConfigurationProvider);
    end;

    procedure SetConfigurationProvider(IConfigurationProvider: Interface IConfigurationProvider)
    begin
        _ConfigurationProvider := IConfigurationProvider;
        _ConfigurationProviderIsDefined := true;
    end;
    #endregion ConfigurationProvider
}