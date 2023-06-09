codeunit 50031 "HttpLogger Factory"
{
    #region HttpLogger
    var
        _HttpLogger: Interface IHttpLogger;
        _HttpLoggerIsDefined: Boolean;

    procedure HttpLogger(): Interface IHttpLogger
    var
        DefaultImplementationCodeunit: Codeunit HttpLogger;
    begin
        if not _HttpLoggerIsDefined then
            SetHttpLogger(DefaultImplementationCodeunit);

        exit(_HttpLogger);
    end;

    local procedure SetHttpLogger(IHttpLogger: Interface IHttpLogger)
    begin
        _HttpLogger := IHttpLogger;
        _HttpLoggerIsDefined := true;
    end;
    #endregion HttpLogger
}