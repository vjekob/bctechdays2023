interface IHttpErrorHandler
{
    procedure HandleError(Status: Integer; Reason: Text; Body: Text);
}
