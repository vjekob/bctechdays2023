codeunit 50067 "Midjourney - Imagine" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend; ResponseHandler: Interface "IMidJourneySend ResponseHandler") TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := Send.Send('imagine', Setup, RequestBody, ResponseHandler);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}