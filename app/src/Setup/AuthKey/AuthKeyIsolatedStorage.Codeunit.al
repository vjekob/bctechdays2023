codeunit 50073 "AuthKey - Isolated Storage" implements IAuthKeyHandler
{
    procedure GetKey(KeyLbl: Text; Scope: DataScope; var Result: Text): Boolean;
    begin
        if not IsolatedStorage.Get(KeyLbl, Scope, Result) then;
    end;

    procedure SetSet(KeyLbl: Text; KeyValue: Text; Scope: DataScope);
    begin
        IsolatedStorage.Set(KeyLbl, KeyValue, Scope);
    end;

    procedure DeleteKey(KeyLbl: Text; Scope: DataScope);
    begin
        IsolatedStorage.Delete(KeyLbl, Scope);
    end;

    procedure HasKey(Keylbl: Text; Scope: DataScope): Boolean;
    begin
        exit(IsolatedStorage.Contains(Keylbl, Scope))
    end;
}