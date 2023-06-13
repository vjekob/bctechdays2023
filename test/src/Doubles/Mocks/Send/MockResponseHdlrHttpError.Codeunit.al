codeunit 50214 "MockResponseHdlr - HttpError" implements "IMidJourneySend ResponseHandler"
{
    procedure HandleResponse(var Response: HttpResponseMessage);
    var
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        Error(HttpStatusErr, '500', 'Internal Server Error');
    end;
}