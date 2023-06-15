codeunit 50002 "Midjourney Result Meth"
{
    internal procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    var
        Setup: Record "Midjourney Setup";
    begin
        Result := Result(TaskId, Setup);
    end;

    internal procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup") Result: Record "Midjourney Result" temporary;
    var
        IsHandled: Boolean;
    begin
        OnBeforeResult(TaskId, Result, IsHandled);
        DoResult(TaskId, Result, Setup, IsHandled);
        OnAfterResult(TaskId, Result);
    end;

    local procedure DoResult(TaskId: Text; var Result: Record "Midjourney Result" temporary; var Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        SendMeth: Codeunit "Midjourney Send Meth";
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
    begin
        if IsHandled then
            exit;

        RequestBody.Add('taskId', TaskId);
        ResponseBody := SendMeth.Send('result', RequestBody, Setup);
        ProcessResponse(ResponseBody, Result);
    end;

    local procedure ProcessResponse(Json: JsonObject; var Result: Record "Midjourney Result" temporary)
    var
        Token: JsonToken;
    begin
        case true of
            Json.Get('status', Token):
                ProcessStatus(Result, Json, Token.AsValue().AsText());
            Json.Get('imageURL', Token):
                ProcessImageUrl(Result, Json, Token.AsValue().AsText());
        end;
    end;

    local procedure ProcessStatus(var Result: Record "Midjourney Result" temporary; Json: JsonObject; Status: Text)
    var
        Token: JsonToken;
    begin
        case Status of
            'running':
                begin
                    Json.Get('percentage', Token);
                    Result.Percentage := Token.AsValue().AsDecimal();
                    Result.Status := "Midjourney Request Status"::Running;
                end;
            'pending':
                Result.Status := "Midjourney Request Status"::Pending;
            'waiting-to-start', 'unknown':
                Result.Status := "Midjourney Request Status"::WaitingToStart;
            'paused':
                Result.Status := "Midjourney Request Status"::Paused;
            else begin
                Result.Status := "Midjourney Request Status"::Error;
                Result."Error Message" := Status;
            end;
        end;
    end;

    local procedure ProcessImageUrl(var Result: Record "Midjourney Result" temporary; Json: JsonObject; ImageUrl: Text)
    begin
        Result.URL := ImageUrl;
        Result.Status := "Midjourney Request Status"::Done;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeResult(TaskId: Text; var Result: Record "Midjourney Result" temporary; IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterResult(TaskId: Text; Result: Record "Midjourney Result" temporary)
    begin
    end;
}