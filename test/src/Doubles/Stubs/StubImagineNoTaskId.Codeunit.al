codeunit 50232 "Stub Imagine - No TaskId" implements IMidjourneyImagine
{
    procedure Imagine(Prompt: Text) TaskId: Text;
    var
        Json: JsonObject;
        Token: JsonToken;
    begin
        Json.ReadFrom('{ "error": "No taskId" }');
        Json.Get('taskId', Token);
    end;
}
