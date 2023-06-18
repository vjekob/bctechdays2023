codeunit 50075 MidjourneySetup implements IMidjourneySetup
{
    var
        _url: Text;
        _authorizationKey: Text;

    procedure Initialize(URL: Text; AuthorizationKey: Text)
    begin
        _url := URL.Trim();
        if not _url.EndsWith('/') then
            _url += '/';
        _authorizationKey := AuthorizationKey;
    end;

    procedure GetEndpoint(Path: Text): Text;
    begin
        exit(_url + Path.Trim());
    end;

    procedure AuthorizationKey(): Text;
    begin
        exit(_authorizationKey);
    end;
}