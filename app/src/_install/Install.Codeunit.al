codeunit 50000 "Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallSetup();
    end;

    local procedure InstallSetup()
    var
        Setup: Record "Midjourney Setup";
        DoInsert: Boolean;
    begin
        if not Setup.Get() then
            DoInsert := true;

        if Setup."Midjourney URL".Trim() = '' then
            Setup."Midjourney URL" := 'https://api.midjourneyapi.io/v2/';

        if DoInsert then
            Setup.Insert()
        else
            Setup.Modify();
    end;
}