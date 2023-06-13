codeunit 50067 "MidJourney - Imagine" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
        ResponseHandler: Codeunit "MidJourneySend ResponseHandler";
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := Send.Send('imagine', Setup, RequestBody, ResponseHandler);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}