codeunit 50237 "Stub Send - No TaskId" implements IMidjourneySend
{
    procedure Send(Path: Text; RequestBody: JsonObject; Factory: Interface IMidjourneyFactory) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom('{ "invalid": "json" }');
    end;
}
