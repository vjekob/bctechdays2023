codeunit 50061 "ImagineWithMidJourney Meth"
{
    internal procedure GetImageUrl(Prompt: Text; Setup: Record "Midjourney Setup") MidJourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidJourneyUrl, IsHandled);

        DoGetImage(Prompt, MidJourneyUrl, Setup, IsHandled);

        OnAfterGetImage(Prompt, MidJourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidJourneyUrl: Text; Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        MidjourneyImagineMeth: Codeunit "Midjourney Imagine Meth";
        TaskId: Text;
    begin
        if IsHandled then
            exit;



        TaskId := MidjourneyImagineMeth.Imagine(Prompt, Setup);
        MidJourneyUrl := WaitForUrl(TaskId);
    end;

    local procedure WaitForUrl(TaskId: Text) Url: Text
    var
        Setup: Record "Midjourney Setup";
        MidjourneyResult: Record "Midjourney Result" temporary;
        MidjourneyResultMeth: Codeunit "Midjourney Result Meth";
        Done: Boolean;
    begin
        Setup.Get();

        Done := false;

        While not Done do begin
            MidjourneyResult := MidjourneyResultMeth.Result(TaskId, Setup);

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
                    Error('Unknown MidJourney Status!');
                    Done := true;
                    Url := '';
                end;
            end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetImage(Prompt: Text; var MidJourneyUrl: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetImage(Prompt: Text; MidJourneyUrl: Text);
    begin
    end;
}