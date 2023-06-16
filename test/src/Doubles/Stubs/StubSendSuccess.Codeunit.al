codeunit 50224 "Stub Send Success" implements IMidJourneySend
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup")
    begin
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}')
    end;
}