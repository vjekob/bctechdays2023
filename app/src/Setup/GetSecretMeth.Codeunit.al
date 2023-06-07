codeunit 50009 "Get Secret Meth"
{
    internal procedure GetSecret(var Secret: Text; Caption: Text) Result: Boolean;
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetSecret(Secret, Caption, Result, IsHandled);
        DoGetSecret(Secret, Caption, Result, IsHandled);
        OnAfterGetSecret(Secret, Caption, Result);
    end;

    local procedure DoGetSecret(var Secret: Text; Caption: Text; var Result: Boolean; IsHandled: Boolean);
    var
        SetAPISecret: Page "Set API Secret";
    begin
        if IsHandled then
            exit;

        Result := SetAPISecret.GetSecret(Secret, Caption);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetSecret(var Secret: Text; Caption: Text; var Result: Boolean; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetSecret(var Secret: Text; Caption: Text; var Result: Boolean);
    begin
    end;
}