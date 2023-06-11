page 50008 "Midjourney Imagine"
{
    Caption = 'Midjourney Imagine';
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

                trigger OnDrillDown()
                begin
                    Hyperlink(Rec."Picture URL");
                end;

            }

            group(Midjourney)
            {
                Caption = 'Midjourney Image';

                field("Picture URL"; Rec."Picture URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contains the URL of the image that MidJourney will use.';
                    Editable = false;
                    Visible = false;


                    trigger OnDrillDown()
                    begin
                        Hyperlink(Rec."Picture URL");
                    end;
                }
                field(Prompt; rec."MidJourney Prompt")
                {
                    ApplicationArea = All;
                    Tooltip = 'Prompt type for Midjourney Imagine request';
                }

                field(ImageURL; Rec."Pic-In-Scene URL (MidJourney)")
                {
                    Caption = 'MidJourney URL';
                    ApplicationArea = All;
                    ToolTip = 'Contains the Midjourney Imagine image URL';
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(Rec."Pic-In-Scene URL (MidJourney)");
                    end;
                }
            }
            field("Picture In Scene"; Rec."Pic-In-Scene")
            {
                ApplicationArea = All;
                Caption = 'Picture In Scene';
                ShowCaption = false;
                ToolTip = 'Shows the picture for this item in the chosen scenery.';

                trigger OnDrillDown()
                begin
                    Hyperlink(Rec."Pic-In-Scene URL (MidJourney)");
                end;
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

                trigger OnAction()
                var
                    ItemPicInSceneMeth: Codeunit "ItemPic-In-Scene Meth";
                begin
                    ItemPicInSceneMeth.Imagine(Rec);
                end;
            }
            action(ImagineBG)
            {
                Caption = 'Imagine (Background)';
                ApplicationArea = All;
                ToolTip = 'Sends a Midjourney Imagine request for the current image and the specified prompt';
                Image = Picture;

                trigger OnAction()
                begin
                    GetMidJourneyImageInBackground(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(imagineBGRef; ImagineBG) { Visible = true; }
        }
    }

    local procedure GetMidJourneyImageInBackground(var Item: Record Item)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"ItemPic-In-Scene Meth";
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Record ID to Process" := Item.RecordId();
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
    end;
}
