codeunit 50067 "Midjourney - Imagine" implements IMidjourneyImagine
{
    procedure Imagine(Prompt: Text; Factory: Interface IMidjourneyFactory) TaskId: Text
    var
        MidjourneySend: Interface IMidjourneySend;
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        MidjourneySend := Factory.GetMidjourneySend();

        RequestBody.Add('prompt', prompt);
        ResponseBody := MidjourneySend.Send('imagine', RequestBody, Factory);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;
}
