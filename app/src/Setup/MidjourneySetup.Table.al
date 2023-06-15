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
        AuthKeyHandler: Interface IAuthKeyHandler;
        AuthKeyHandlerIsSet: Boolean;

    local procedure SetAuthKeyHandler(pAuthKeyHandler: Interface IAuthKeyHandler)
    begin
        AuthKeyHandlerIsSet := true;
        AuthKeyHandler := pAuthKeyHandler;
    end;

    local procedure GetAuthKeyHandler(): Interface IAuthKeyHandler
    var
        AuthKeyIsolatedStorage: Codeunit "AuthKey - Isolated Storage";
    begin
        if not AuthKeyHandlerIsSet then begin
            AuthKeyHandler := AuthKeyIsolatedStorage;
        end;

        exit(AuthKeyHandler);
    end;

    internal procedure GetMidjourneyAuthKey() Result: Text
    begin
        if not GetAuthKeyHandler().GetKey(MidjourneyAuthKey, DataScope::Company, Result) then;
        if not IsolatedStorage.Get(MidjourneyAuthKey, DataScope::Company, Result) then;
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
        IsolatedStorage.Set(MidjourneyAuthKey, KeyValue, DataScope::Company);
    end;

    internal procedure DeleteMidjourneyAuthKey()
    begin
        IsolatedStorage.Delete(MidjourneyAuthKey, DataScope::Company);
    end;

    procedure HasMidjourneyAuthKey(): Boolean
    begin
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
        if Confirm(ConfirmLbl) then
            DeleteMidjourneyAuthKey();
    end;

    procedure GetForMidjourney()
    begin
        Rec.Get();
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


}
