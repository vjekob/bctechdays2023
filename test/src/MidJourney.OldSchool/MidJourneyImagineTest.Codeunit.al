codeunit 50202 "Midjourney Imagine Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit "Assert";
        MidjourneyAuthKey: Label 'c19c7ee6-c590-4aed-996d-67bcacff3273', Locked = true;
        MidjourneyURL: Label 'https://api.midjourneyapi.io/v2/', Locked = true;

    [Test]
    procedure ImagineMeth_InvalidURL()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        StubImagineInvalidUrl: Codeunit "Stub Imagine InvalidUrl";
        StubResultStatusDone: Codeunit "Stub Result Status Done";
        StubSendSuccess: Codeunit "Stub Send Success";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [GIVEN] Stubbing SendSuccess
        StubImagineInvalidUrl.Initialize(StubSendSuccess);
        StubResultStatusDone.Initialize(StubSendSuccess);

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, StubImagineInvalidUrl, stubresultstatusdone);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_InvalidAuthKey()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        StubImagineUnauthorized: Codeunit "Stub Imagine Unauthorized";
        StubResultStatusRunning: Codeunit "Stub Result Status Running";
        StubSendSuccess: Codeunit "Stub Send Success";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [GIVEN] Stubbing SendSuccess
        StubImagineUnauthorized.Initialize(StubSendSuccess);
        StubResultStatusRunning.Initialize(StubSendSuccess);

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, StubImagineUnauthorized, StubResultStatusRunning);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_Success()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        StubImagineSuccess: Codeunit "Stub Imagine Success";
        StubResultStatusDone: Codeunit "Stub Result Status Done";
        StubSendSuccess: Codeunit "Stub Send Success";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [GIVEN] Stubbing SendSuccess
        StubImagineSuccess.Initialize(StubSendSuccess);
        StubResultStatusDone.Initialize(StubSendSuccess);

        // [WHEN] Invoking Midjourney
        Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, StubImagineSuccess, StubResultStatusDone);

        // [THEN] URL must be a well-formed URL
        Assert.IsTrue(Url.StartsWith('http'), 'Url is not a valid url');
    end;

    [Test]
    procedure ImagineMeth_SendError()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        FakeImagine: Codeunit "Fake Imagine";
        FakeResult: Codeunit "Fake Result";
        StubSendError: Codeunit "Stub Send Error";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [GIVEN] Stubbing SendError
        FakeImagine.Initialize(StubSendError);
        FakeResult.Initialize(StubSendError);

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, FakeImagine, FakeResult);

    end;
}