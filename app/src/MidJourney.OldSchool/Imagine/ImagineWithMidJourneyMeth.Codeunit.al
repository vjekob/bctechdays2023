codeunit 50061 "ImagineWithMidjourney Meth"
{

    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        Setup: Record "Midjourney Setup";
        Imagine: Codeunit "Midjourney - Imagine";
        Result: Codeunit "Midjourney - Result";
    begin
        Setup.Get();
        MidjourneyUrl := GetImageUrl(Prompt, Setup, Imagine, Result);
    end;

    internal procedure GetImageUrl(Prompt: Text; var Setup: Record "Midjourney Setup"; Imagine: Interface IMidJourneyImagine; Result: Interface IMidJourneyResult) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, Setup, Imagine, Result, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; var Setup: Record "Midjourney Setup"; Imagine: Interface IMidJourneyImagine; Result: Interface IMidJourneyResult; IsHandled: Boolean);
    var
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := Imagine.Imagine(Prompt, Setup);
        MidjourneyUrl := WaitForUrl(TaskId, Setup, Result);
    end;

    local procedure WaitForUrl(TaskId: Text; var Setup: Record "Midjourney Setup"; Result: Interface IMidJourneyResult) Url: Text
    var
        MidjourneyResult: Record "Midjourney Result" temporary;
        Done: Boolean;
    begin
        Setup.Get();

        Done := false;

        while not Done do begin
            MidjourneyResult := Result.Result(TaskId, Setup);

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