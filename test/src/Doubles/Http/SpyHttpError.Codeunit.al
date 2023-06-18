codeunit 50253 "Spy - HttpError" implements IHttpErrorHandler
{
    var
        _invoked: Boolean;
        _status: Integer;
        _reason: Text;
        _body: Text;

    procedure HandleError(Status: Integer; Reason: Text; Body: Text);
    begin
        _invoked := true;
        _status := Status;
        _reason := Reason;
        _body := Body;
    end;

    procedure IsInvoked(): Boolean
    begin
        exit(_invoked);
    end;

    procedure GetStatusCode(): Integer
    begin
        exit(_status);
    end;

    procedure GetReason(): Text
    begin
        exit(_reason);
    end;

    procedure GetBody(): Text
    begin
        exit(_body);
    end;
}
