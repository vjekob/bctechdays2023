codeunit 50061 "ImagineWithMidjourney Meth"
{

    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        Factory: Codeunit ImagineFactory;
    begin
        MidjourneyUrl := GetImageUrl(Prompt, Factory);
    end;

    internal procedure GetImageUrl(Prompt: Text; var Factory: Codeunit ImagineFactory) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, Factory, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; var Factory: Codeunit ImagineFactory; IsHandled: Boolean);
    var
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := Factory.Imagine().Imagine(Prompt, Factory);
        MidjourneyUrl := WaitForUrl(TaskId, Factory);
    end;

    local procedure WaitForUrl(TaskId: Text; var Factory: Codeunit ImagineFactory) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        Done: Boolean;
    begin
        Done := false;

        while not Done do begin
            MidjourneyResult := Factory.Result().Result(TaskId, Factory);

            case MidjourneyResult.Status of
                enum::"Midjourney Request Status"::WaitingToStart,
                enum::"Midjourney Request Status"::Running,
                enum::"Midjourney Request Status"::Pending,
                enum::"Midjourney Request Status"::Paused:
                    begin
                        Sleep(5000);
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