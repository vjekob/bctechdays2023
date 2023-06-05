codeunit 50201 "Upgrade Tests BCTD23"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        InstallTests: Codeunit "Install Tests BCTD23";
    begin
        InstallTests.SetupTestSuite();
    end;
}
