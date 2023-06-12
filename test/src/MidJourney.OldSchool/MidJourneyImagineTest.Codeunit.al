codeunit 50202 "MidJourney Imagine Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    // [FEATURE] [MidJourney Imagine]

    var
        IsInitialized: Boolean;
        LibraryInventory: Codeunit "Library - Inventory";
        Assert: Codeunit "Assert";

    var //Shared Fixtures
        MidjourneySetup: Record "Midjourney Setup";
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

        // [GIVEN] given Setup
        SetupMidJourney(InValidMidJourneyKey);

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Darth Vader, filtering sand from sea water, pooring in a glass while standing on a beach with his feet in the water';

        // [WHEN] when
        asserterror Url := ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt);

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

        // [GIVEN] given Setup
        SetupMidJourney(ValidMidJourneyKey);

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Darth Vader, filtering sand from sea water, pooring in a glass while standing on a beach with his feet in the water';

        // [WHEN] when
        Url := ImagineWithMidJourneyMeth.GetImageUrl(MidJourneyPrompt);

        // [THEN] then
        Assert.IsTrue(Url <> '', 'Url is empty');
        Assert.IsTrue(Url.StartsWith('http'), 'Url is not a valid url');
    end;

    local procedure InitializeFreshFixtures()
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

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"MidJourney Imagine Test");

        IsInitialized := true;
        Commit();
        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"MidJourney Imagine Test");
    end;

    local procedure SetupMidJourney(TestKey: Text)
    var
        MidjourneySetup: Record "Midjourney Setup";
    begin
        if not MidjourneySetup.Get then
            MidjourneySetup.Insert();

        MidjourneySetup.SetMidjourneyAuthKey(TestKey);
        MidjourneySetup.Modify();
    end;
}