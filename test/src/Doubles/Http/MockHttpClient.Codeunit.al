codeunit 50243 "Mock HttpClient" implements IHttpClient
{
    var
        _sendError: Text;
        _blocked: Boolean;

    procedure ExpectSendToFailWithError(SendError: Text)
    begin
        _sendError := SendError;
    end;

    procedure ExpectSendToFailBlockedByEnvironment()
    begin
        _blocked := true;
    end;

    [TryFunction]
    local procedure TrySend(RequestMessage: HttpRequestMessage; var ResponseMessage: Interface IHttpResponseMessage);
    var
        MockResponse: Codeunit "Mock HttpResponseMessage";
        StubBlocked: Codeunit "Stub Response - Blocked";
        RequestHeaders: HttpHeaders;
        Authorized: Boolean;
        Authorization: List of [Text];
        FirstAuthorization: Text;
    begin
        if _sendError <> '' then
            Error(_sendError);

        if not RequestMessage.GetRequestUri().ToLower().StartsWith('https://valid/') then
            Error('No such host is known. (%1)', RequestMessage.GetRequestUri());

        if _blocked then begin
            ResponseMessage := StubBlocked;
            Error('');
        end;

        Authorized := false;
        RequestMessage.GetHeaders(RequestHeaders);
        if RequestHeaders.GetValues('Authorization', Authorization) then
            if Authorization.Count() = 1 then
                if Authorization.Get(1, FirstAuthorization) then
                    Authorized := FirstAuthorization = 'VALID';

        if not Authorized then begin
            MockResponse.InitializeError(401, 'Unauthorized');
            ResponseMessage := MockResponse;
            exit;
        end;

        case true of
            RequestMessage.GetRequestUri().EndsWith('/imagine'):
                begin
                    MockResponse.InitializeSuccess(200, '{ "taskId": "123456" }');
                    ResponseMessage := MockResponse;
                    exit;
                end;

            RequestMessage.GetRequestUri().EndsWith('/result'):
                begin
                    MockResponse.InitializeSuccess(200, '{ "imageURL": "https://vjeko.com/" }');
                    ResponseMessage := MockResponse;
                    exit;
                end;
        end;
    end;

    procedure Send(RequestMessage: HttpRequestMessage; var ResponseMessage: Interface IHttpResponseMessage): Boolean;
    var
        HttpResponse: Codeunit "Dummy - HttpResponseMessage";
    begin
        ClearLastError();
        ResponseMessage := HttpResponse;
        exit(TrySend(RequestMessage, ResponseMessage));
    end;
}
