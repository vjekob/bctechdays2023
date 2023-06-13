codeunit 50061 "ImagineWithMidJourney Meth"
{
    internal procedure GetImageUrl(Prompt: Text; var Setup: Record "Midjourney Setup"; Imagine: Interface IMidJourneyImagine; Result: Interface IMidJourneyResult; Send: Interface IMidJourneySend) MidJourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidJourneyUrl, IsHandled);

        DoGetImage(Prompt, MidJourneyUrl, Setup, Imagine, Result, Send, IsHandled);

        OnAfterGetImage(Prompt, MidJourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidJourneyUrl: Text; var Setup: Record "Midjourney Setup"; var Imagine: Interface IMidJourneyImagine; var Result: Interface IMidJourneyResult; var Send: Interface IMidJourneySend; IsHandled: Boolean);
    var
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := Imagine.Imagine(Prompt, Setup, Send);
        MidJourneyUrl := WaitForUrl(TaskId, Result, Setup, Send);
    end;

    local procedure WaitForUrl(TaskId: Text; Result: interface IMidJourneyResult; var Setup: Record "Midjourney Setup"; var Send: Interface IMidJourneySend) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        MidjourneyResultMeth: Codeunit "Midjourney Result Meth";
        Done: Boolean;
    begin
        Done := false;

        While not Done do begin
            MidjourneyResult := Result.Result(TaskId, Setup, Send);

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