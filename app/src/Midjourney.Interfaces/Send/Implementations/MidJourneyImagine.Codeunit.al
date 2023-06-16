codeunit 50067 "Midjourney - Imagine" implements IMidJourneyImagine
{
    var
        _setup: Record "Midjourney Setup";

    procedure Initialize(var SetupIn: Record "Midjourney Setup")
    begin
        _setup := SetupIn;
    end;

    procedure Imagine(Prompt: Text) TaskId: Text
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
        MidjourneySendMeth: Codeunit "Midjourney Send Meth";
    begin
        RequestBody.Add('prompt', prompt);
        ResponseBody := MidjourneySendMeth.Send('imagine', _setup, RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

}