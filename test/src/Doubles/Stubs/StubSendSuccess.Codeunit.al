codeunit 50224 "Stub Send Success" implements IMidJourneySend
{
    procedure Send(Path: Text; Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}');
    end;
}