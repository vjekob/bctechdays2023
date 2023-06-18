codeunit 50081 DefaultHttpErrorHandler implements IHttpErrorHandler
{
    procedure HandleError(Status: Integer; Reason: Text; Body: Text);
    var
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        Error(HttpStatusErr, Status, Reason);
    end;
}
