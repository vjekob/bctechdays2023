codeunit 50246 "Stub Response - Blocked" implements IHttpResponseMessage
{
    procedure IsBlockedByEnvironment(): Boolean;
    begin
        exit(true);
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
        ThrowTestError();
    end;

    procedure GetResponseBodyAsText(): Text;
    begin
        ThrowTestError();
    end;

    local procedure ThrowTestError()
    begin
        Error('Critical test code error: Response message retrieved when blocked by environment.');
    end;
}
