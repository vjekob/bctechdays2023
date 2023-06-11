page 50007 "Midjourney Image JQ"
{
    Caption = 'Midjourney Image (Job Queue)';
    PageType = Card;
    SourceTable = Item;
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field(PictureFld; Rec.Picture)
            {
                ApplicationArea = All;
                Caption = 'Source Picture';
                ShowCaption = false;
                ToolTip = 'Shows the current picture for this item';

            }

            group(Midjourney)
            {
                Caption = 'Midjourney Image';

                field(Prompt; Rec."MidJourney Prompt")
                {
                    ApplicationArea = All;
                    Tooltip = 'Prompt type for Midjourney Imagine request';
                }
                field("MidJourney TaskId"; Rec."MidJourney TaskId")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contains the Midjourney Imagine task ID';
                }

                field(ImageURL; Rec."Pic-In-Scene URL (MidJourney)")
                {
                    Caption = 'MidJourney URL';
                    ApplicationArea = All;
                    ToolTip = 'Contains the Midjourney Imagine image URL';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(Rec."Pic-In-Scene URL (MidJourney)");
                    end;
                }

                field(Status; Rec."MidJourney Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    ToolTip = 'Contains the status of the Midjourney Imagine flow';
                    Editable = false;
                    Width = 150;
                }
            }
            field("Picture In Scene"; Rec."Pic-In-Scene")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Shows the picture in scene';
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Imagine)
            {
                Caption = 'Imagine';
                ApplicationArea = All;
                ToolTip = 'Sends a Midjourney Imagine request for the current image and the specified prompt';
                Image = Picture;
                Enabled = MidjourneyEnabled;

                trigger OnAction()
                var
                    Params: Dictionary of [Text, Text];
                begin
                    RunBackgroundTask;
                end;
            }
        }
    }

    var
        MidjourneyEnabled: Boolean;

    local procedure RunBackgroundTask()
    var
        JobQueueEntry: Record "Job Queue Entry";
        TaskId: Integer;
        Params: Dictionary of [Text, Text];
    begin
        ResetMidJourney();

        GetMidJourneyImageInBackground(Rec);

        CurrPage.EnqueueBackgroundTask(TaskID, Codeunit::"Midjourney Background Task JQ", Params, 120000, PageBackgroundTaskErrorLevel::Ignore);
    end;

    local procedure GetMidJourneyImageInBackground(var Item: Record Item)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"MidJourney JQ";
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Record ID to Process" := Item.RecordId();
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
    end;

    local procedure ResetMidJourney()
    begin
        Rec.TestField("MidJourney Prompt");

        Rec."MidJourney Done" := false;
        Rec."MidJourney PromptText" := '';
        Rec."MidJourney Status" := '';
        Rec."MidJourney TaskId" := '';
        Rec.Modify();
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        CurrPage.Update(true);

        MidjourneyEnabled := Rec."MidJourney Done";

        If not Rec."MidJourney Done" then
            RunBackgroundTask;
    end;

    trigger OnOpenPage()
    begin
        MidjourneyEnabled := true;
    end;
}
