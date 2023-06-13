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

        field(3; "Azure BLOB Account"; Text[250])
        {
            Caption = 'Azure BLOB Account';
        }

        field(4; "Azure BLOB Container"; Text[250])
        {
            Caption = 'Azure BLOB Container';
        }

        field(5; "Azure BLOB Root URL"; Text[250])
        {
            Caption = 'Azure BLOB Root URL';
            ExtendedDatatype = URL;
        }
    }

    var
        MidjourneyAuthKey: Label 'BCTD23_Midrange_AuthKey', Locked = true;
        AzureBLOBSharedKey: Label 'BCTD23_AzureBLOB_SharedKey', Locked = true;
        AuthKey: Text;

    internal procedure GetMidjourneyAuthKey(): Text
    begin
        if AuthKey = '' then
            IsolatedStorage.Get(MidjourneyAuthKey, DataScope::Company, AuthKey);

        exit(AuthKey);
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
        AuthKey := KeyValue;

        IsolatedStorage.Set(MidjourneyAuthKey, KeyValue, DataScope::Company);
    end;

    internal procedure DeleteMidjourneyAuthKey()
    begin
        IsolatedStorage.Delete(MidjourneyAuthKey, DataScope::Company);
    end;

    procedure HasMidjourneyAuthKey(): Boolean
    begin
        if AuthKey <> '' then
            exit(true);

        exit(IsolatedStorage.Contains(MidjourneyAuthKey, DataScope::Company));
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
        AuthKey := '';

        if Confirm(ConfirmLbl) then
            DeleteMidjourneyAuthKey();
    end;

    procedure GetForMidjourney()
    begin
        Rec.TestField("Midjourney URL");
        Rec.TestMidjourneyAuthKey();
    end;

    procedure GetMidjourneyEndpoint(Path: Text): Text;
    var
        Root: Text;
    begin
        Root := Rec."Midjourney URL".Trim();
        ;
        if not Root.EndsWith('/') then
            Root += '/';
        exit(Root + Path);
    end;

    internal procedure GetAzureBLOBSharedKey() Result: Text
    begin
        if not IsolatedStorage.Get(AzureBLOBSharedKey, DataScope::Company, Result) then;
    end;

    internal procedure TestAzureBLOBSharedKey()
    var
        NotConfiguredErr: Label 'AzureBLOBSharedKey is not ';
    begin
        if not Rec.HasAzureBLOBSharedKey() then
            Error(NotConfiguredErr);
    end;

    internal procedure SetAzureBLOBSharedKey(KeyValue: Text)
    begin
        IsolatedStorage.Set(AzureBLOBSharedKey, KeyValue, DataScope::Company);
    end;

    internal procedure DeleteAzureBLOBSharedKey()
    begin
        IsolatedStorage.Delete(AzureBLOBSharedKey, DataScope::Company);
    end;

    procedure HasAzureBLOBSharedKey(): Boolean
    begin
        exit(IsolatedStorage.Contains(AzureBLOBSharedKey, DataScope::Company));
    end;

    procedure ConfigureAzureBLOBSharedKey()
    var
        GetSecretMeth: Codeunit "Get Secret Meth";
        AzureBLOBSharedKey: Text;
        Caption: Label 'Set Azure BLOB Shared Key';
    begin
        if GetSecretMeth.GetSecret(AzureBLOBSharedKey, Caption) then
            SetAzureBLOBSharedKey(AzureBLOBSharedKey);
    end;

    procedure ClearAzureBLOBSharedKey()
    var
        ConfirmLbl: Label 'Do you want to clear the Azure BLOB Shared Key?';
    begin
        if Confirm(ConfirmLbl) then
            DeleteAzureBLOBSharedKey();
    end;

}
