codeunit 50067 "Midjourney - Imagine" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Factory: codeunit ImagineFactory) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := Factory.Send().Send('imagine', Factory.Setup(), RequestBody, Factory.ResponseHandler());

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}