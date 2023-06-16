codeunit 50224 "Stub Send Success" implements IMidJourneySend
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}')
    end;
}