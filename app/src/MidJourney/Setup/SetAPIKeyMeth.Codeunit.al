codeunit 50001 "Set API Key Meth"
{
    internal procedure SetAuthKey(var Setup: Record "Midjourney Setup")
    var
        IsHandled: Boolean;
    begin
        OnBeforeSetAuthKey(Setup, IsHandled);
        DoSetAuthKey(Setup, IsHandled);
        OnAfterSetAuthKey(Setup);
    end;

    local procedure DoSetAuthKey(var Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        APIKey: Page "Midjourney API Key";
    begin
        if IsHandled then
            exit;

        if APIKey.RunModal() = Action::OK then
            Setup.SetIsolatedAuthKey(APIKey.GetAPIKey());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetAuthKey(var Setup: Record "Midjourney Setup"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetAuthKey(var Setup: Record "Midjourney Setup");
    begin
    end;
}
