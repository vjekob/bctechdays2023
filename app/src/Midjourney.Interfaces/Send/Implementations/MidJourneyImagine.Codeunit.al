codeunit 50067 "Midjourney - Imagine" implements IMidJourneyImagine
{
    var
        Factory: Codeunit "Midjourney Factory";

    procedure Imagine(Prompt: Text) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
        Send: interface IMidjourneySend;
    begin
        RequestBody.Add('prompt', prompt);

        Send := Factory.Send();
        ResponseBody := Send.Send('imagine', RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}