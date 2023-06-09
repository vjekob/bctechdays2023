codeunit 50017 "MidJourney Imagine" implements "MidJourney Http Invoker"
{
    procedure Post(Request: HttpRequestMessage) Content: JsonObject;
    begin

    end;

    local procedure DoImagine(Prompt: Text; var Result: Record "Midjourney Response" temporary);
    var
        SendMeth: Codeunit "Midjourney Send Meth";
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        Clear(Result);
        Result.Status := "Midjourney Request Status"::Error;
        Result.Reason := 'Request was not yet sent';

        RequestBody.Add('prompt', prompt);
        ResponseBody := SendMeth.Send('imagine', RequestBody);

        Result.Reason := 'Response parsing error';

        ResponseBody.Get('taskId', Token);
        Result.TaskId := Token.AsValue().AsText();

        Result.Status := "Midjourney Request Status"::Sent;
        Result.Reason := '';
    end;

}