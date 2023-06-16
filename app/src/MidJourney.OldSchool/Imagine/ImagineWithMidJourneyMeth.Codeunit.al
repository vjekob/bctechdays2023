codeunit 50061 "ImagineWithMidjourney Meth"
{
    internal procedure GetImageUrl(Prompt: Text) MidjourneyUrl: Text
    var
        Factory: Codeunit "Midjourney Factory";
        Setup: Record "Midjourney Setup";
        Imagine: Interface IMidjourneyImagine;
        Result: Interface IMidjourneyResult;
    begin
        Imagine := Factory.Imagine();
        Result := Factory.Result();

        MidjourneyUrl := GetImageUrl(Prompt, Imagine, Result);
    end;

    internal procedure GetImageUrl(Prompt: Text; Imagine: Interface IMidJourneyImagine; Result: Interface IMidJourneyResult) MidjourneyUrl: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetImage(Prompt, MidjourneyUrl, IsHandled);

        DoGetImage(Prompt, MidjourneyUrl, Imagine, Result, IsHandled);

        OnAfterGetImage(Prompt, MidjourneyUrl);
    end;

    local procedure DoGetImage(Prompt: Text; var MidjourneyUrl: Text; Imagine: Interface IMidJourneyImagine; Result: Interface IMidJourneyResult; IsHandled: Boolean);
    var
        TaskId: Text;
    begin
        if IsHandled then
            exit;

        TaskId := Imagine.Imagine(Prompt);
        MidjourneyUrl := WaitForUrl(TaskId, Result);
    end;

    local procedure WaitForUrl(TaskId: Text; Result: Interface IMidJourneyResult) Url: Text
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