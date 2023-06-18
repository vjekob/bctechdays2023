codeunit 50236 "Stub Send - Success" implements IMidjourneySend
{
    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom('{ "taskId": "123456" }');
    end;
}
