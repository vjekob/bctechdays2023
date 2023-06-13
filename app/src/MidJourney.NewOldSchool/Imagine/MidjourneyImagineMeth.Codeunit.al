codeunit 50001 "Midjourney Imagine Meth"
{
    internal procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeImagine(Prompt, TaskId, IsHandled);
        DoImagine(Prompt, TaskId, Setup, IsHandled);
        OnAfterImagine(Prompt, TaskId);
    end;

    local procedure DoImagine(Prompt: Text; var TaskId: Text; var Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        SendMeth: Codeunit "Midjourney Send Meth";
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        if IsHandled then
            exit;

        RequestBody.Add('prompt', prompt);
        ResponseBody := SendMeth.Send('imagine', Setup, RequestBody);

        ResponseBody.Get('taskId', Token);
        TaskId := Token.AsValue().AsText();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImagine(Prompt: Text; TaskId: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterImagine(Prompt: Text; TaskId: Text);
    begin
    end;
}
