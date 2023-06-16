codeunit 50067 "Midjourney - Imagine" implements IMidJourneyImagine
{
    var
        _send: Interface IMidJourneySend;

    procedure Initialize(Send: Interface IMidJourneySend)
    begin
        _send := Send;
    end;

    procedure Imagine(Prompt: Text) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := _send.Send('imagine', RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}