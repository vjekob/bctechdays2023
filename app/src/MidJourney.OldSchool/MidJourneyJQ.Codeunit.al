codeunit 50058 "MidJourney JQ"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        Item: Record Item;
        RecRef: RecordRef;
    begin
        Rec.Testfield("Record ID to Process");
        RecRef.Get(Rec."Record ID to Process");
        RecRef.SetTable(Item);
        Item.Find();

        GetMidjourneyURL(Item);
        GetPrompt(Item);
        RunImagine(Item);
        GetResult(Item);
    end;

    local procedure GetMidjourneyURL(var Item: Record Item)
    begin
        if Item."Picture URL" <> '' then exit;

        Item."Picture URL" := Item.GetAzureBLOBURL();
    end;

    local procedure GetPrompt(var Item: Record Item)
    var
        PromptMeth: Codeunit "Midjourney Prompt Meth";
    begin
        Item."MidJourney PromptText" := item.GetPrompt();
    end;

    local procedure RunImagine(var Item: Record Item)
    var
        ImagineMeth: Codeunit "Midjourney Imagine Meth";
        Setup: Record "Midjourney Setup";
    begin
        Setup.Get();
        item."MidJourney TaskId" := ImagineMeth.Imagine(Item."MidJourney PromptText", Setup);
    end;

    local procedure GetResult(var Item: Record Item)
    begin
        while not item."MidJourney Done" do begin
            SetMidjourneyResult(Item);
            Sleep(5000);
        end;

        //Download
    end;

    local procedure SetMidjourneyResult(var Item: Record Item)
    var
        Result: Record "Midjourney Result" temporary;
        Setup: Record "Midjourney Setup";
        ResultMeth: Codeunit "Midjourney Result Meth";
        Results: Dictionary of [Text, Text];
        TaskId: Text;
        FailedErr: Label 'Midjourney request failed with an error: %1', Comment = '%1 is error message';
        WaitingToStartLbl: Label 'Waiting to start...';
        PendingLbl: Label 'Pending...';
        PausedLbl: Label 'Paused';
        RunningLbl: Label 'Running (%1% done)', Comment = '%1 is percentage done';
    begin
        Setup.Get();

        Result := ResultMeth.Result(Item."MidJourney TaskId", Setup);

        case Result.Status of
            "Midjourney Request Status"::WaitingToStart:
                begin
                    Item."MidJourney Status" := WaitingToStartLbl;
                    item."MidJourney Done" := false;
                end;

            "Midjourney Request Status"::Pending:
                begin
                    Item."MidJourney Status" := WaitingToStartLbl;
                    item."MidJourney Done" := false;
                end;

            "Midjourney Request Status"::Paused:
                begin
                    Item."MidJourney Status" := PausedLbl;
                    item."MidJourney Done" := false;
                end;

            "Midjourney Request Status"::Running:
                begin
                    Item."MidJourney Status" := StrSubstNo(RunningLbl, Result.Percentage);
                    item."MidJourney Done" := false;
                end;

            "Midjourney Request Status"::Done:
                begin
                    Item."Pic-In-Scene URL (MidJourney)" := StrSubstNo(RunningLbl, Result.Percentage);
                    item."MidJourney Done" := true;
                end;

            "Midjourney Request Status"::Error:
                Error(FailedErr, Result."Error Message");
        end;
    end;

}