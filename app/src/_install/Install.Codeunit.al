codeunit 50000 "Install BCTD23"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallSetup();
    end;

    local procedure InstallSetup()
    var
        Setup: Record "Midjourney Setup BCTD23";
        DoInsert: Boolean;
    begin
        if not Setup.Get() then
            DoInsert := true;

        if Setup.URL.Trim() = '' then
            Setup.URL := 'https://api.midjourneyapi.io/v2/';

        if DoInsert then
            Setup.Insert()
        else
            Setup.Modify();
    end;
}