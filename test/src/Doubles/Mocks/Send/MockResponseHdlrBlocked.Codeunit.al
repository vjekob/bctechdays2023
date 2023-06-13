codeunit 50217 "MockResponseHdlr - Blocked" implements "IMidJourneySend ResponseHandler"
{
    procedure HandleResponse(var Response: HttpResponseMessage);
    begin
        Error('Blocked by Environment');
    end;
}