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
            group(AzureBLOB)
            {
                Caption = 'Azure BLOB Storage';

                group(AzureTextFields)
                {
                    ShowCaption = false;

                    field("Azure BLOB Account"; Rec."Azure BLOB Account")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Azure BLOB Storage account name';
                    }

                    field("Azure BLOB Container"; Rec."Azure BLOB Container")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Azure BLOB Storage container name';
                    }

                    field("Azure BLOB Root URL"; Rec."Azure BLOB Root URL")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Azure BLOB Storage root URL';
                    }
                }

                group(AzureCheckbox)
                {
                    ShowCaption = false;

                    field(HasSharedKey; HasAzureBLOBSharedKey)
                    {
                        Caption = 'Shared Key Configured';
                        ApplicationArea = All;
                        ToolTip = 'Indicates whether the Azure BLOB Storage shared key is configured';

                        trigger OnValidate()
                        begin
                            if HasAzureBLOBSharedKey then
                                Rec.ConfigureAzureBLOBSharedKey()
                            else
                                Rec.ClearAzureBLOBSharedKey();
                            CurrPage.Update(true);
                        end;
                    }
                }
            }
        }
    }

    var
        HasMidjourneyAPIKey: Boolean;
        HasAzureBLOBSharedKey: Boolean;

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
        RefreshHasAzureBLOBSharedKey();
    end;

    local procedure RefreshHasMidjourneyAPIKey()
    begin
        HasMidjourneyAPIKey := Rec.HasMidjourneyAuthKey();
    end;

    local procedure RefreshHasAzureBLOBSharedKey()
    begin
        HasAzureBLOBSharedKey := Rec.HasAzureBLOBSharedKey();
    end;


}
