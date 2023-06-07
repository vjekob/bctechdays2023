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

        field(2; URL; Text[250])
        {
            Caption = 'URL';
            ExtendedDatatype = URL;
        }
    }

    var
        AuthKey: Label 'BCTD23_Midrange_AuthKey', Locked = true;

    internal procedure GetIsolatedAuthKey() Result: Text
    begin
        if not IsolatedStorage.Get(AuthKey, DataScope::Company, Result) then;
    end;

    internal procedure SetIsolatedAuthKey(KeyValue: Text)
    begin
        IsolatedStorage.Set(AuthKey, KeyValue, DataScope::Company);
    end;

    internal procedure DeleteIsolatedAuthKey()
    begin
        IsolatedStorage.Delete(AuthKey, DataScope::Company);
    end;

    procedure HasAuthKey(): Boolean
    begin
        exit(IsolatedStorage.Contains(AuthKey, DataScope::Company));
    end;

    procedure SetAPIKey()
    var
        SetAPIKeyMeth: Codeunit "Set API Key Meth";
    begin
        SetAPIKeyMeth.SetAuthKey(Rec);
    end;

    procedure ClearAPIKey()
    var
        ClearAPIKeyMeth: Codeunit "Clear API Key Meth";
    begin
        ClearAPIKeyMeth.ClearAuthKey(Rec);
    end;
}
