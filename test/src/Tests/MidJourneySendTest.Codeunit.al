codeunit 50218 "MidJourney Send Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    // [FEATURE] [MidJourney Imagine]

    var
        IsInitialized: Boolean;
        MockImagineUnauthorized: Codeunit "Mock Imagine Unauthorized";
        MockImagineSuccess: Codeunit "Mock Imagine Success";
        MockResultStatusDone: Codeunit "Mock Result Status Done";
        MockResultStatusRunning: Codeunit "Mock Result Status Running";
        MockResultStatusError: Codeunit "Mock Result Status Error";
        MockSendError: Codeunit "Mock Send Error";
        MockSendRunning: Codeunit "Mock Send Running";
        MockSendDoneImageUrl: Codeunit "Mock Send Done ImageUrl";
        SpySendResponseHandleError: Codeunit "Spy SendResponse Handle Error";

    var //Shared Fixtures
        InValidMidjourneySetup: Record "Midjourney Setup";
        ValidMidjourneySetup: Record "Midjourney Setup";
        InValidMidJourneyKey: label 'This-Key-Is-Invalid', Locked = true;
        ValidMidJourneyKey: label 'c19c7ee6-c590-4aed-996d-67bcacff3273', Locked = true;
        MidJourneyPrompt: Text;

    var //Fresh Fixtures
        RequestBody: JsonObject;

    [Test]
    procedure Send_Success()
    var
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        MockImagineSuccess.Imagine(MidJourneyPrompt, ValidMidjourneySetup, MockSendDoneImageUrl);

    end;

    [Test]
    procedure Send_Error()
    var
        Url: Text;
    begin
        // [SCENARIO #issueno] scenario
        Initialize();

        // [GIVEN] Prompt
        MidJourneyPrompt := 'Marble statue of Julius Caesar dunking a basket ball::2 in a basketball hoop, frog perspective, realistic';

        // [WHEN] when
        asserterror MockSendError.Send('Test', ValidMidjourneySetup, RequestBody, SpySendResponseHandleError)
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