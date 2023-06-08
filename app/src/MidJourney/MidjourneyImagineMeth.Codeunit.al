codeunit 50001 "Midjourney Imagine Meth"
{
    internal procedure Imagine(Prompt: Text) Result: Record "Midjourney Response" temporary
    var
        IsHandled: Boolean;
    begin
        OnBeforeImagine(Prompt, Result, IsHandled);
        DoImagine(Prompt, Result, IsHandled);
        OnAfterImagine(Prompt, Result);
    end;

    local procedure DoImagine(Prompt: Text; var Result: Record "Midjourney Response" temporary; IsHandled: Boolean);
    var
        SendMeth: Codeunit "Midjourney Send Meth";
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        if IsHandled then
            exit;

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

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImagine(Prompt: Text; var Result: Record "Midjourney Response" temporary; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterImagine(Prompt: Text; Result: Record "Midjourney Response" temporary);
    begin
    end;
}
