codeunit 50248 "Stub Setup - Valid" implements IMidjourneySetup
{
    procedure GetEndpoint(Path: Text): Text;
    begin
        exit('https://valid/' + Path.Trim());
    end;

    procedure AuthorizationKey(): Text;
    begin
        exit('VALID');
    end;
}
