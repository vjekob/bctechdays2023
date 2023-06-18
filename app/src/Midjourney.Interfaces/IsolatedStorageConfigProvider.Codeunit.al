codeunit 50072 IsolatedStorageConfigProvider implements IConfigurationProvider
{
    procedure Get("Key": Text; Scope: DataScope; var Value: Text): Boolean;
    begin
        exit(IsolatedStorage.Get("Key", Scope, Value));
    end;

    procedure Set("Key": Text; Value: Text; Scope: DataScope): Boolean;
    begin
        exit(IsolatedStorage.Set("Key", Value, Scope));
    end;

    procedure Delete("Key": Text; Scope: DataScope): Boolean;
    begin
        exit(IsolatedStorage.Delete("Key", Scope));
    end;

    procedure Contains("Key": Text; Scope: DataScope): Boolean;
    begin
        exit(IsolatedStorage.Contains("Key", Scope));
    end;
}
