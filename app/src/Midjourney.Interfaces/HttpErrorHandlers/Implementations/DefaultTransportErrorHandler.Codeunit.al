codeunit 50080 DefaultTransportErrorHandler implements ITransportErrorHandler
{
    procedure HandleError(ErrorMessage: Text);
    begin
        Error(ErrorMessage);
    end;
}
