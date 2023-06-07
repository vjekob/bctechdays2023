codeunit 50002 "Clear API Key Meth"
{
    internal procedure ClearAuthKey(var Setup: Record "Midjourney Setup")
    var
        IsHandled: Boolean;
    begin
        OnBeforeClearAuthKey(Setup, IsHandled);
        DoClearAuthKey(Setup, IsHandled);
        OnAfterClearAuthKey(Setup);
    end;

    local procedure DoClearAuthKey(var Setup: Record "Midjourney Setup"; IsHandled: Boolean);
    var
        QuestionLbl: Label 'Are you sure you want to clear the Midjourney API authorization key?';
    begin
        if IsHandled then
            exit;

        if Confirm(QuestionLbl) then
            Setup.DeleteIsolatedAuthKey();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeClearAuthKey(var Setup: Record "Midjourney Setup"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterClearAuthKey(var Setup: Record "Midjourney Setup");
    begin
    end;
}
