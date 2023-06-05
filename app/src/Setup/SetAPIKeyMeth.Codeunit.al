codeunit 50001 "Set API Key Meth BCTD23"
{
    internal procedure SetAuthKey(var Setup: Record "Midjourney Setup BCTD23")
    var
        IsHandled: Boolean;
    begin
        OnBeforeSetAuthKey(Setup, IsHandled);
        DoSetAuthKey(Setup, IsHandled);
        OnAfterSetAuthKey(Setup);
    end;

    local procedure DoSetAuthKey(var Setup: Record "Midjourney Setup BCTD23"; IsHandled: Boolean);
    var
        APIKey: Page "Midjourney API Key BCTD23";
    begin
        if IsHandled then
            exit;

        if APIKey.RunModal() = Action::OK then
            Setup.SetIsolatedAuthKey(APIKey.GetAPIKey());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetAuthKey(var Setup: Record "Midjourney Setup BCTD23"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetAuthKey(var Setup: Record "Midjourney Setup BCTD23");
    begin
    end;
}
