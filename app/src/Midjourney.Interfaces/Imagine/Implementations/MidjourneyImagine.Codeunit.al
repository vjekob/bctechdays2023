codeunit 50067 "Midjourney - Imagine" implements IMidjourneyImagine
{
    var
        Factory: Codeunit "Midjourney Factory";

    procedure Imagine(Prompt: Text) TaskId: Text
    var
        MidjourneySend: Interface IMidjourneySend;
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        MidjourneySend := Factory.GetMidjourneySend();

        RequestBody.Add('prompt', prompt);
        ResponseBody := MidjourneySend.Send('imagine', RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;
}
