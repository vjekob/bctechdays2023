codeunit 50249 "Stub Setup - Invalid AuthKey" implements IMidjourneySetup
{
    var
        Valid: Codeunit "Stub Setup - Valid";

    procedure GetEndpoint(Path: Text): Text;
    begin
        exit(Valid.GetEndpoint(Path));
    end;

    procedure AuthorizationKey(): Text;
    begin
        exit('INVALID');
    end;
}
