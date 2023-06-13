codeunit 50213 "Mock Send Running" implements IMidJourneySend
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
    var
        Response: HttpResponseMessage;
    begin
        ResponseBody.ReadFrom('{"status": "Running"}')
    end;

}