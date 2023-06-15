interface "IAuthKeyHandler"
{
    procedure GetKey(KeyLbl: Text; Scope: DataScope; var Result: Text): boolean;
    procedure SetSet(KeyLbl: Text; KeyValue: Text; Scope: DataScope);
    procedure DeleteKey(KeyLbl: Text; Scope: DataScope);
    procedure HasKey(Keylbl: Text; Scope: DataScope): Boolean
}