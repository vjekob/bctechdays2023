codeunit 50070 "Midjourney - Result" implements IMidjourneyResult
{
    procedure Result(TaskId: Text; MidjourneySend: Interface IMidjourneySend) Result: Record "Midjourney Result" temporary;
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
    begin
        RequestBody.Add('taskId', TaskId);
        ResponseBody := MidjourneySend.Send('result', RequestBody);
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
}