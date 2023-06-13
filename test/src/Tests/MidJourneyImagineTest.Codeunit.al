codeunit 50202 "MidJourney Imagine Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    // [FEATURE] [MidJourney Imagine]

    var
        IsInitialized: Boolean;
        LibraryInventory: Codeunit "Library - Inventory";
        Assert: Codeunit "Assert";
        MockImagineUnauthorized: Codeunit "Mock Imagine Unauthorized";
        MockImagineSuccess: Codeunit "Mock Imagine Success";
        MockResultStatusDone: Codeunit "Mock Result Status Done";
        MockResultStatusRunning: Codeunit "Mock Result Status Running";
        MockResultStatusError: Codeunit "Mock Result Status Error";

    var //Shared Fixtures
        InValidMidjourneySetup: Record "Midjourney Setup";
        ValidMidjourneySetup: Record "Midjourney Setup";
        InValidMidJourneyKey: label 'This-Key-Is-Invalid', Locked = true;
        ValidMidJourneyKey: label 'c19c7ee6-c590-4aed-996d-67bcacff3273', Locked = true;
        MidJourneyPrompt: Text;

    var //Fresh Fixtures

    [Test]
    procedure ImagineMeth_InValidKey()
    var
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        asserterror Url := ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt, InValidMidjourneySetup, MockImagineUnauthorized, MockResultStatusDone);

        // [THEN] then
        Assert.ExpectedError('Unauthorized');
    end;

    [Test]
    procedure ImagineMeth_NotIsEmpty()
    var
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        Url := ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt, ValidMidjourneySetup, MockImagineSuccess, MockResultStatusDone);

        // [THEN] then
        Assert.IsTrue(Url <> '', 'Url is empty');
        Assert.IsTrue(Url.StartsWith('http'), 'Url is not a valid url');
    end;

    [Test]
    procedure ImagineMeth_NotDone()
    var
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        Url := ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt, ValidMidjourneySetup, MockImagineSuccess, MockResultStatusRunning);

        // [THEN] then
        Assert.IsTrue(Url = '', 'Url is not empty');
    end;

    [Test]
    procedure ImagineMeth_Error()
    var
        ImagineWithMidJourneyMeth: Codeunit "ImagineWithMidJourney Meth";
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        asserterror ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt, ValidMidjourneySetup, MockImagineSuccess, MockResultStatusError);

    end;

    procedure InitializeFreshFixtures()
    begin

    end;

    local procedure Initialize()
    var
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"MidJourney Imagine Test");

        InitializeFreshFixtures();

        if IsInitialized then exit;

        //SharedFixtures
        SetupMidJourney(ValidMidJourneyKey, ValidMidjourneySetup);
        SetupMidJourney(InValidMidJourneyKey, InValidMidjourneySetup);

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"MidJourney Imagine Test");

        IsInitialized := true;
        Commit();
        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"MidJourney Imagine Test");
    end;

    local procedure SetupMidJourney(TestKey: Text; var MidjourneySetup: Record "Midjourney Setup")
    begin
        if not MidjourneySetup.Get then
            MidjourneySetup.Insert();

        MidjourneySetup.SetMidjourneyAuthKey(TestKey);
    end;
}