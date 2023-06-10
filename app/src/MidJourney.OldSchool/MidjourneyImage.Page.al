page 50003 "Midjourney Image"
{
    Caption = 'Midjourney Image';
    PageType = Card;
    SourceTable = Item;
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = false;
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

                field(Prompt; Prompt)
                {
                    ApplicationArea = All;
                    Tooltip = 'Prompt type for Midjourney Imagine request';
                }

                field(ImageURL; Rec."Picture URL (MidJourney)")
                {
                    Caption = 'MidJourney URL';
                    ApplicationArea = All;
                    ToolTip = 'Contains the Midjourney Imagine image URL';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(Rec."Picture URL (MidJourney)");
                    end;
                }

                field(Status; Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                    ToolTip = 'Contains the status of the Midjourney Imagine flow';
                    Editable = false;
                    Width = 150;
                }
            }
            field("Picture In Scene"; Rec."Picture In Scene")
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
                    Status := '';
                    MidjourneyEnabled := false;

                    Task := "Midjourney Task Type"::GetURL;
                    RunBackgroundTask();
                end;
            }
        }
    }

    var
        TempBlob: Codeunit "Temp Blob";
        Prompt: Enum "Midjourney Prompt";
    // ImageURL: Text;

    // Imagine workflow
    var
        Task: Enum "Midjourney Task Type";
        AzureBLOBURL: Text;
        ImaginePrompt: Text;
        MidjourneyTaskID: Text;
        Status: Text;
        MidjourneyEnabled: Boolean;

    // Statuses
    var
        StatusGetURLLbl: Label 'Getting URL';
        StatusGetPrompt: Label 'Getting prompt';
        StatusRunImagine: Label 'Running Imagine';

    local procedure RunBackgroundTask()
    var
        Params: Dictionary of [Text, Text];
        TaskID: Integer;
    begin
        Params.Add('task', Format(Task.AsInteger()));

        case Task of
            "Midjourney Task Type"::GetURL:
                begin
                    Status := StatusGetURLLbl;
                    Params.Add('itemNo', Rec."No.");
                end;

            "Midjourney Task Type"::GetPrompt:
                begin
                    Status := StatusGetPrompt;
                    Params.Add('prompt', Format(Prompt.AsInteger()));
                    Params.Add('url', AzureBLOBURL);
                end;

            "Midjourney Task Type"::RunImagine:
                begin
                    Status := StatusRunImagine;
                    Params.Add('prompt', ImaginePrompt);
                end;

            "Midjourney Task Type"::GetResult:
                Params.Add('taskId', MidjourneyTaskID);
        end;

        CurrPage.EnqueueBackgroundTask(TaskID, Codeunit::"Midjourney Background Task", Params, 120000, PageBackgroundTaskErrorLevel::Ignore);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        DoneTxt: Text;
        Done: Boolean;
    begin
        case Task of
            "Midjourney Task Type"::GetURL:
                begin
                    Results.Get('url', AzureBLOBURL);
                    Task := "Midjourney Task Type"::GetPrompt;

                    if Rec."Picture URL (Azure BLOB)" = '' then begin
                        Rec."Picture URL (Azure BLOB)" := AzureBLOBURL;
                        Rec.Modify();
                    end;

                    RunBackgroundTask();
                end;

            "Midjourney Task Type"::GetPrompt:
                begin
                    Results.Get('prompt', ImaginePrompt);
                    Task := "Midjourney Task Type"::RunImagine;
                    RunBackgroundTask();
                end;

            "Midjourney Task Type"::RunImagine:
                begin
                    Results.Get('taskId', MidjourneyTaskID);
                    Task := "Midjourney Task Type"::GetResult;
                    RunBackgroundTask();
                end;

            "Midjourney Task Type"::GetResult:
                begin
                    Results.Get('done', DoneTxt);
                    Done := DoneTxt = Format(true);

                    if Done then begin
                        Results.Get('url', Rec."Picture URL (MidJourney)");
                        Rec.Modify();
                        Rec.DownloadPicInSceneImage();

                        Status := '';
                        MidjourneyEnabled := true;
                    end else begin
                        Results.Get('status', Status);
                        RunBackgroundTask();
                    end;
                end;
        end;
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    begin
        Status := '';
        MidjourneyEnabled := true;
        IsHandled := true;

        Error(ErrorText);
    end;

    trigger OnOpenPage()
    begin
        MidjourneyEnabled := true;
    end;
}
