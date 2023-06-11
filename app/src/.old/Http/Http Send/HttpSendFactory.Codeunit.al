codeunit 50032 "HttpSend Factory"
{
    #region HttpSend
    var
        _HttpSend: Interface IHttpSend;
        _HttpSendIsDefined: Boolean;

    procedure HttpSend(): Interface IHttpSend
    var
        DefaultImplementationCodeunit: Codeunit HttpSend;
    begin
        if not _HttpSendIsDefined then
            SetHttpSend(DefaultImplementationCodeunit);

        exit(_HttpSend);
    end;

    local procedure SetHttpSend(IHttpSend: Interface IHttpSend)
    begin
        _HttpSend := IHttpSend;
        _HttpSendIsDefined := true;
    end;
    #endregion HttpSend
}