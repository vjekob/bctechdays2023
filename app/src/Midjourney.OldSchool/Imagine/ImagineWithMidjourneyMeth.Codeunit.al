codeunit 50061 "ImagineWithMidjourney Meth"
{
    var
        _retryDelay: Integer;

    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        Setup: Record "Midjourney Setup";
        Imagine: Codeunit "Midjourney - Imagine";
        Result: Codeunit "Midjourney - Result";
    begin
        _retryDelay := 5000;
        Setup.GetForMidjourney();
        Imagine.Initialize(Setup);
        Result.Initialize(Setup);
        MidjourneyUrl := GetImageUrl(Prompt, Imagine, Result);
    end;

    internal procedure SetRetryDelay(RetryDelay: Integer)
    begin
        _retryDelay := RetryDelay;
    end;

    internal procedure GetImageUrl(Prompt: Text; Imagine: Interface IMidjourneyImagine; Result: Interface IMidjourneyResult) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, Imagine, Result, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; Imagine: Interface IMidjourneyImagine; Result: Interface IMidjourneyResult; IsHandled: Boolean);
    var
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := Imagine.Imagine(Prompt);
        MidjourneyUrl := WaitForUrl(TaskId, Result);
    end;

    local procedure WaitForUrl(TaskId: Text; Result: Interface IMidjourneyResult) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        Done: Boolean;
    begin
        Done := false;

        while not Done do begin
            MidjourneyResult := Result.Result(TaskId);

            case MidjourneyResult.Status of
                enum::"Midjourney Request Status"::WaitingToStart,
                enum::"Midjourney Request Status"::Running,
                enum::"Midjourney Request Status"::Pending,
                enum::"Midjourney Request Status"::Paused:
                    begin
                        Sleep(_retryDelay);
                    end;
                enum::"Midjourney Request Status"::Done:
                    begin
                        Done := true;
                        Url := MidjourneyResult.URL;
                    end;
                enum::"Midjourney Request Status"::Error:
                    begin
                        Error(MidjourneyResult."Error Message");
                        Done := true;
                        Url := '';
                    end;
                else begin
                    Error('Unknown Midjourney Status!');
                    Done := true;
                    Url := '';
                end;
            end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetImage(Prompt: Text; var MidjourneyUrl: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetImage(Prompt: Text; MidjourneyUrl: Text);
    begin
    end;
}