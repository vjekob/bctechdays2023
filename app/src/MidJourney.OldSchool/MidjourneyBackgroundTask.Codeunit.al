codeunit 50011 "Midjourney Background Task"
{
    trigger OnRun()
    var
        Params: Dictionary of [Text, Text];
        Task: Enum "Midjourney Task Type";
        TaskText: Text;
        TaskInt: Integer;
    begin
        Params := Page.GetBackgroundParameters();

        Params.Get('task', TaskText);
        Evaluate(TaskInt, TaskText);
        Task := "Midjourney Task Type".FromInteger(TaskInt);

        case Task of
            "Midjourney Task Type"::GetURL:
                GetMidjourneyURL(Params);
            "Midjourney Task Type"::GetPrompt:
                GetMidjourneyPrompt(Params);
            "Midjourney Task Type"::RunImagine:
                RunImagine(Params);
            "Midjourney Task Type"::GetResult:
                GetMidjourneyResult(Params);
        end;
    end;

    local procedure GetMidjourneyURL(Params: Dictionary of [Text, Text])
    var
        Item: Record Item;
        Results: Dictionary of [Text, Text];
        ItemNo: Text;
        URL: Text;
    begin
        Params.Get('itemNo', ItemNo);

        Item.Get(ItemNo);
        URL := Item.GetAzureBLOBURL();

        Results.Add('url', URL);
        Page.SetBackgroundTaskResult(Results);
    end;

    local procedure GetMidjourneyPrompt(Params: Dictionary of [Text, Text])
    var
        PromptMeth: Codeunit "Midjourney Prompt Meth";
        Results: Dictionary of [Text, Text];
        Prompt: Enum "Midjourney Prompt";
        PromptText: Text;
        PromptInt: Integer;
        URL: Text;
    begin
        Params.Get('prompt', PromptText);
        Params.Get('url', URL);
        Evaluate(PromptInt, PromptText);
        Prompt := "Midjourney Prompt".FromInteger(PromptInt);

        PromptText := PromptMeth.GetPrompt(Prompt, URL);

        Results.Add('prompt', PromptText);
        Page.SetBackgroundTaskResult(Results);
    end;

    local procedure RunImagine(Params: Dictionary of [Text, Text])
    var
        ImagineMeth: Codeunit "Midjourney Imagine Meth";
        Results: Dictionary of [Text, Text];
        Prompt: Text;
        TaskId: Text;
    begin
        Params.Get('prompt', Prompt);

        TaskId := ImagineMeth.Imagine(Prompt);

        Results.Add('taskId', TaskId);
        Page.SetBackgroundTaskResult(Results);
    end;

    local procedure GetMidjourneyResult(Params: Dictionary of [Text, Text])
    var
        Result: Record "Midjourney Result" temporary;
        ResultMeth: Codeunit "Midjourney Result Meth";
        Results: Dictionary of [Text, Text];
        TaskId: Text;
        FailedErr: Label 'Midjourney request failed with an error: %1', Comment = '%1 is error message';
        WaitingToStartLbl: Label 'Waiting to start...';
        PendingLbl: Label 'Pending...';
        PausedLbl: Label 'Paused';
        RunningLbl: Label 'Running (%1% done)', Comment = '%1 is percentage done';
    begin
        Params.Get('taskId', TaskId);

        Result := ResultMeth.Result(TaskId);

        case Result.Status of
            "Midjourney Request Status"::WaitingToStart:
                begin
                    Results.Add('status', WaitingToStartLbl);
                    Results.Add('done', Format(false));
                    Sleep(5000);
                end;

            "Midjourney Request Status"::Pending:
                begin
                    Results.Add('status', WaitingToStartLbl);
                    Results.Add('done', Format(false));
                    Sleep(5000);
                end;

            "Midjourney Request Status"::Paused:
                begin
                    Results.Add('status', PausedLbl);
                    Results.Add('done', Format(false));
                    Sleep(5000);
                end;

            "Midjourney Request Status"::Running:
                begin
                    Results.Add('status', StrSubstNo(RunningLbl, Result.Percentage));
                    Results.Add('done', Format(false));
                    Sleep(5000);
                end;

            "Midjourney Request Status"::Done:
                begin
                    Results.Add('url', Result.URL);
                    Results.Add('done', Format(true));
                end;

            "Midjourney Request Status"::Error:
                Error(FailedErr, Result."Error Message");
        end;

        Page.SetBackgroundTaskResult(Results);
    end;

    local procedure ProcessResponse(TaskId: Text): Text
    var
        ResultMeth: Codeunit "Midjourney Result Meth";
        Finished: Boolean;
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetMidjourneyImage(Item: Record Item; Prompt: Enum "Midjourney Prompt"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetMidjourneyImage(Item: Record Item; Prompt: Enum "Midjourney Prompt");
    begin
    end;
}
