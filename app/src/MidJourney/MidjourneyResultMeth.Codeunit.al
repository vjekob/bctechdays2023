codeunit 50002 "Midjourney Result Meth"
{
    internal procedure Result(TaskId: Text)
    var
        IsHandled: Boolean;
    begin
        OnBeforeResult(TaskId, IsHandled);
        DoResult(TaskId, IsHandled);
        OnAfterResult(TaskId);
    end;

    local procedure DoResult(TaskId: Text; IsHandled: Boolean);
    var
        SendMeth: Codeunit "Midjourney Send Meth";
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
    begin
        if IsHandled then
            exit;

        RequestBody.Add('taskId', TaskId);
        ResponseBody := SendMeth.Send('result', RequestBody);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeResult(TaskId: Text; IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterResult(TaskId: Text);
    begin
    end;
}