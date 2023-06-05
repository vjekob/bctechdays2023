page 50000 "Midjourney Setup"
{
    Caption = 'Midjourney Setup';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Midjourney Setup";

    layout
    {
        area(Content)
        {
            group(MidjourneyAPI)
            {
                Caption = 'Midjourney API';

                field("Midjourney URL"; Rec."Midjourney URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Midjourney API base URL';
                }

                field(HasAuthKey; HasMidjourneyAPIKey)
                {
                    Caption = 'API Key Configured';
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the Midjourney API authorization key is configured';

                    trigger OnValidate()
                    begin
                        if HasMidjourneyAPIKey then
                            Rec.ConfigureMidjourneyAuthKey()
                        else
                            Rec.ClearMidjourneyAuthKey();
                        CurrPage.Update(true);
                    end;
                }
            }
        }
    }

    var
        HasMidjourneyAPIKey: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        RefreshSecrets();
    end;

    trigger OnAfterGetRecord()
    begin
        RefreshSecrets();
    end;

    local procedure RefreshSecrets()
    begin
        RefreshHasMidjourneyAPIKey();
    end;

    local procedure RefreshHasMidjourneyAPIKey()
    begin
        HasMidjourneyAPIKey := Rec.HasMidjourneyAuthKey();
    end;


}
