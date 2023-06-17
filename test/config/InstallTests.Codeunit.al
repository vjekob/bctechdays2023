codeunit 50200 "Install Tests"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupTestSuite();
    end;

    procedure SetupTestSuite()
    var
        ALTestSuite: Record "AL Test Suite";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        SuiteName: Code[10];
        Me: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(Me);
        SuiteName := 'DEMOS';

        if ALTestSuite.Get(SuiteName) then
            ALTestSuite.Delete(true);

        TestSuiteMgt.CreateTestSuite(SuiteName);
        Commit();
        ALTestSuite.Get(SuiteName);

        TestSuiteMgt.SelectTestMethodsByExtension(ALTestSuite, Me.Id());
    end;
}
