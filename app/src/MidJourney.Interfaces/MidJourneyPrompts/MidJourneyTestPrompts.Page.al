page 50005 "MidJourney Test Prompts"
{
    Caption = 'MidJourney Test Prompts';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "MidJourney Test Prompt";

    layout
    {
        area(Content)
        {
            group(Settings)
            {
                field(Custom; CustomPrompt)
                {
                    ApplicationArea = All;
                }
                field(ImageUrl; Rec.ImageUrl)
                {
                    ApplicationArea = All;
                }
                field(Setting; Rec.Setting)
                {
                    ApplicationArea = All;
                }
                field(Style; Rec.Style)
                {
                    ApplicationArea = All;
                }
                field(AspectRatio; Rec."Aspect Ratio")
                {
                    ApplicationArea = All;
                }

            }
            group(Prompt)
            {
                field(PromptFld; Prompt)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Prompt")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    MidJourneyPromptFactory: Codeunit "MidJourney Prompt Factory";
                begin
                    Prompt := Rec.GeneratePrompt(CustomPrompt, MidJourneyPromptFactory);
                end;
            }
        }
        area(Promoted)
        {
            actionref("GeneratePromptPromoted"; "Generate Prompt") { Visible = true; }
        }
    }
    var
        Prompt, CustomPrompt : Text;

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}

