codeunit 50252 "Spy - TransportError" implements ITransportErrorHandler
{
    var
        _invoked: Boolean;
        _errorMessage: Text;

    procedure HandleError(ErrorMessage: Text);
    begin
        _invoked := true;
        _errorMessage := ErrorMessage;
    end;

    procedure IsInvoked(): Boolean;
    begin
        exit(_invoked);
    end;

    procedure GetErrorMessage(): Text;
    begin
        exit(_errorMessage);
    end;
}
