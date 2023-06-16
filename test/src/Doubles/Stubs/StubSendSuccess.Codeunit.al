codeunit 50224 "Stub Send Success" implements IMidjourneySend
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup"; ResponseHandler: Interface "IMidJourneySend ResponseHandler")
    begin
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    begin
        ResponseBody.ReadFrom('{"imageURL": "http://www.waldo.be", "status": "Done"}');
    end;
}