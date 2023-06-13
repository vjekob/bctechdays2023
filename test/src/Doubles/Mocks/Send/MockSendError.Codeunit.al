codeunit 50216 "Mock Send Error" implements IMidJourneySend
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
    var
        Response: HttpResponseMessage;
    begin
        Error('Some Error');
    end;

}