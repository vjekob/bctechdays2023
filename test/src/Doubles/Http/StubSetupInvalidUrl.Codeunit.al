codeunit 50250 "Stub Setup - Invalid URL" implements IMidjourneySetup
{
    var
        Valid: Codeunit "Stub Setup - Valid";

    procedure GetEndpoint(Path: Text): Text;
    begin
        exit('https://invalid/');
    end;

    procedure AuthorizationKey(): Text;
    begin
        exit(Valid.AuthorizationKey());
    end;
}
