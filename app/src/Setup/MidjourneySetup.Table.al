table 50000 "Midjourney Setup"
{
    Caption = 'Midjourney Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Midjourney URL"; Text[250])
        {
            Caption = 'Midjourney URL';
            ExtendedDatatype = URL;
        }
    }

    var
        MidjourneyAuthKey: Label 'BCTD23_Midrange_AuthKey', Locked = true;
        ConfigurationProvider: Interface IConfigurationProvider;
        ConfigurationProviderSet: Boolean;

    internal procedure SetConfigurationProvider(Provider: Interface IConfigurationProvider)
    begin
        ConfigurationProvider := Provider;
        ConfigurationProviderSet := true;
    end;

    local procedure GetConfigurationProvider(): Interface IConfigurationProvider
    var
        IsolatedStorageConfigProvider: Codeunit IsolatedStorageConfigProvider;
    begin
        if ConfigurationProviderSet then
            exit(ConfigurationProvider)
        else
            exit(IsolatedStorageConfigProvider);
    end;

    internal procedure GetMidjourneyAuthKey() Result: Text
    begin
        if not GetConfigurationProvider().Get(MidjourneyAuthKey, DataScope::Company, Result) then;
    end;

    internal procedure TestMidjourneyAuthKey()
    var
        NotConfiguredErr: Label 'MidjourneyAuthKey is not configured.';
    begin
        if not Rec.HasMidjourneyAuthKey() then
            Error(NotConfiguredErr);
    end;

    internal procedure SetMidjourneyAuthKey(KeyValue: Text)
    begin
        GetConfigurationProvider().Set(MidjourneyAuthKey, KeyValue, DataScope::Company);
    end;

    internal procedure DeleteMidjourneyAuthKey()
    begin
        GetConfigurationProvider().Delete(MidjourneyAuthKey, DataScope::Company);
    end;

    procedure HasMidjourneyAuthKey(): Boolean
    begin
        exit(GetConfigurationProvider().Contains(MidjourneyAuthKey, DataScope::Company));
    end;

    procedure ConfigureMidjourneyAuthKey()
    var
        GetSecretMeth: Codeunit "Get Secret Meth";
        MidjourneyAuthKey: Text;
        Caption: Label 'Set Midjourney Auth Key';
    begin
        if GetSecretMeth.GetSecret(MidjourneyAuthKey, Caption) then
            SetMidjourneyAuthKey(MidjourneyAuthKey);
    end;

    procedure ClearMidjourneyAuthKey()
    var
        ConfirmLbl: Label 'Do you want to clear the Midjourney Auth Key?';
    begin
        if Confirm(ConfirmLbl) then
            DeleteMidjourneyAuthKey();
    end;

    procedure GetForMidjourney()
    begin
        Rec.Get();
        Rec.TestField("Midjourney URL");
        Rec.TestMidjourneyAuthKey();
    end;

    procedure ToMidjourneySetup(): Interface IMidjourneySetup
    var
        MidjourneySetup: Codeunit MidjourneySetup;
    begin
        MidjourneySetup.Initialize(Rec."Midjourney URL", Rec.GetMidjourneyAuthKey());
        exit(MidjourneySetup);
    end;
}
