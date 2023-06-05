page 50000 "Midjourney Setup BCTD23"
{
    Caption = 'Midjourney Setup';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Midjourney Setup BCTD23";

    layout
    {
        area(Content)
        {
            group(API)
            {
                Caption = 'API';

                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Midjourney API base URL';
                }

                field(HasAuthKey; Rec.HasAuthKey)
                {
                    Caption = 'API Key Configured';
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the Midjourney API authorization key is configured';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SetAPIKey)
            {
                ApplicationArea = All;
                Caption = 'Set API Key';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EncryptionKeys;

                trigger OnAction()
                begin
                    Rec.SetAPIKey();
                end;
            }

            action(ClearAPIKey)
            {
                ApplicationArea = All;
                Caption = 'Clear API Key';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;
                Enabled = ClearEnabled;

                trigger OnAction()
                begin
                    Rec.ClearAPIKey();
                end;
            }
        }
    }

    var
        ClearEnabled: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateEnabled();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateEnabled();
    end;

    local procedure UpdateEnabled()
    begin
        ClearEnabled := Rec.HasAuthKey;
    end;
}
