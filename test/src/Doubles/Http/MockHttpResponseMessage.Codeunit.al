codeunit 50247 "Mock HttpResponseMessage" implements IHttpResponseMessage
{
    var
        _statusCode: Integer;
        _reasonPhrase: Text;
        _responseBody: JsonObject;
        _blockedByEnvironment: Boolean;

    procedure InitializeError(StatusCode: Integer; ReasonPhrase: Text)
    begin
        _statusCode := StatusCode;
        _reasonPhrase := ReasonPhrase;
    end;

    procedure InitializeSuccess(StatusCode: Integer; ResponseBodyText: Text)
    var
        ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom(ResponseBodyText);
        _statusCode := StatusCode;
        _responseBody := ResponseBody;
    end;

    procedure InitializeBlockedByEnvironment()
    begin
        _blockedByEnvironment := true;
    end;

    procedure IsBlockedByEnvironment(): Boolean;
    begin
        exit(_blockedByEnvironment);
    end;

    procedure IsSuccessStatusCode(): Boolean;
    begin
        exit((_statusCode >= 200) and (_statusCode < 300));
    end;

    procedure HttpStatusCode(): Integer;
    begin
        exit(_statusCode);
    end;

    procedure ReasonPhrase(): Text;
    begin
        exit(_reasonPhrase);
    end;

    procedure GetResponseBody(): JsonObject;
    begin
        exit(_responseBody);
    end;

    procedure GetResponseBodyAsText() Body: Text;
    begin
        _responseBody.WriteTo(Body);
    end;
}
