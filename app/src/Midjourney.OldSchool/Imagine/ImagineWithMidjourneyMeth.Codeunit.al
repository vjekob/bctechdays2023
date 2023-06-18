codeunit 50061 "ImagineWithMidjourney Meth"
{
    var
        _retryDelay: Integer;
        _retryDelaySet: Boolean;

    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        Factory: Codeunit "Midjourney Factory";
    begin
        _retryDelay := 5000;
        MidjourneyUrl := GetImageUrl(Prompt, Factory);
    end;

    internal procedure SetRetryDelay(RetryDelay: Integer)
    begin
        _retryDelay := RetryDelay;
        _retryDelaySet := true;
    end;

    internal procedure GetImageUrl(Prompt: Text; Factory: Interface IMidjourneyFactory) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, Factory, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; Factory: Interface IMidjourneyFactory; IsHandled: Boolean);
    var
        Imagine: Interface IMidjourneyImagine;
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        if not _retryDelaySet then
            _retryDelay := 5000;

        Imagine := Factory.GetMidjourneyImagine();
        TaskId := Imagine.Imagine(Prompt, Factory);
        MidjourneyUrl := WaitForUrl(TaskId, Factory);
    end;

    local procedure WaitForUrl(TaskId: Text; Factory: Interface IMidjourneyFactory) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        Result: Interface IMidjourneyResult;
        Done: Boolean;
    begin
        Done := false;

        Result := Factory.GetMidjourneyResult();

        while not Done do begin
            MidjourneyResult := Result.Result(TaskId, Factory);

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