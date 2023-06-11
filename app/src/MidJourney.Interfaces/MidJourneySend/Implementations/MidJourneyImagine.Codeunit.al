codeunit 50067 "MidJourney - Imagine" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; IMidJourneySend: interface IMidJourneySend) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
        MidJourneySendResponseHandler: Codeunit "MidJourneySend ResponseHandler";
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := IMidJourneySend.Send('imagine', RequestBody, MidJourneySendResponseHandler);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}