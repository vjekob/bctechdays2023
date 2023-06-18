codeunit 50254 "Dummy - HttpResponseMessage" implements IHttpResponseMessage
{
    procedure IsBlockedByEnvironment(): Boolean;
    begin
    end;

    procedure IsSuccessStatusCode(): Boolean;
    begin
    end;

    procedure HttpStatusCode(): Integer;
    begin
    end;

    procedure ReasonPhrase(): Text;
    begin
    end;

    procedure GetResponseBody(): JsonObject;
    begin
    end;

    procedure GetResponseBodyAsText(): Text;
    begin
    end;
}
