codeunit 50067 "MidJourney - Imagine" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
        MidjourneySendMeth: Codeunit "Midjourney Send Meth";
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := MidjourneySendMeth.Send('imagine', Setup, RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}