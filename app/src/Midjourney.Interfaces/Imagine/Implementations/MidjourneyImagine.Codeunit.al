codeunit 50067 "Midjourney - Imagine" implements IMidjourneyImagine
{
    procedure Imagine(Prompt: Text; MidjourneySend: Interface IMidjourneySend) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := MidjourneySend.Send('imagine', RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;
}
