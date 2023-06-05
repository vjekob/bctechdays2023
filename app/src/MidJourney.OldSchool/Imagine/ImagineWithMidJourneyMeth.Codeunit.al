codeunit 50061 "ImagineWithMidjourney Meth"
{
    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; IsHandled: Boolean);
    var
        MidjourneyImagineMeth: Codeunit "Midjourney Imagine Meth";
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := MidjourneyImagineMeth.Imagine(Prompt);
        MidjourneyUrl := WaitForUrl(TaskId);
    end;

    local procedure WaitForUrl(TaskId: Text) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        MidjourneyResultMeth: Codeunit "Midjourney Result Meth";
        Done: Boolean;
    begin
        Done := false;

        While not Done do begin
            MidjourneyResult := MidjourneyResultMeth.Result(TaskId);

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