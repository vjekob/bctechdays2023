codeunit 50242 "ImagineWithMidjourney Int.Test"
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
        Factory: Codeunit "Midjourney Factory";
        MockHttpClient: Codeunit "Mock HttpClient";
        InvalidUrl: Codeunit "Stub Setup - Invalid URL";
        SpyTransportErrorHandler: Codeunit "Spy - TransportError";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        Factory.SetHttpClient(MockHttpClient);
        Factory.SetMidjourneySetup(InvalidUrl);
        Factory.SetTransportErrorHandler(SpyTransportErrorHandler);
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Factory);

        Assert.IsTrue(Url = '', 'Url must be empty');
        Assert.IsTrue(SpyTransportErrorHandler.IsInvoked(), 'TransportErrorHandler must be invoked');
        Assert.IsSubstring(SpyTransportErrorHandler.GetErrorMessage(), 'No such host is known.');
    end;

    [Test]
    procedure ImagineMeth_InvalidAuthKey()
    var
        Factory: Codeunit "Midjourney Factory";
        MockHttpClient: Codeunit "Mock HttpClient";
        InvalidAuthKey: Codeunit "Stub Setup - Invalid AuthKey";
        SpyHttpError: Codeunit "Spy - HttpError";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        Factory.SetHttpClient(MockHttpClient);
        Factory.SetMidjourneySetup(InvalidAuthKey);
        Factory.SetHttpErrorHandler(SpyHttpError);
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Factory);

        Assert.IsTrue(Url = '', 'Url must be empty');
        Assert.IsTrue(SpyHttpError.IsInvoked(), 'HttpErrorHandler must be invoked');
        Assert.AreEqual(401, SpyHttpError.GetStatusCode(), 'StatusCode must be 401');
    end;

    [Test]
    procedure ImagineMeth_BlockedByEnvironment()
    var
        Factory: Codeunit "Midjourney Factory";
        MockHttpClient: Codeunit "Mock HttpClient";
        ValidConfig: Codeunit "Stub Setup - Valid";
        SpyBlockedByEnvironment: Codeunit "Spy - BlockedByEnvironment";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        MockHttpClient.ExpectSendToFailBlockedByEnvironment();
        Factory.SetHttpClient(MockHttpClient);
        Factory.SetMidjourneySetup(ValidConfig);
        Factory.SetBlockedByEnvironmentHandler(SpyBlockedByEnvironment);
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Factory);

        Assert.IsTrue(Url = '', 'Url must be empty');
        Assert.IsTrue(SpyBlockedByEnvironment.IsInvoked(), 'BlockedByEnvironmentHandler must be invoked');
    end;

    [Test]
    procedure ImagineMeth_TransportError()
    var
        Factory: Codeunit "Midjourney Factory";
        MockHttpClient: Codeunit "Mock HttpClient";
        ValidConfig: Codeunit "Stub Setup - Valid";
        SpyTransportError: Codeunit "Spy - TransportError";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        MockHttpClient.ExpectSendToFailWithError('TRANSPORT');
        Factory.SetHttpClient(MockHttpClient);
        Factory.SetMidjourneySetup(ValidConfig);
        Factory.SetTransportErrorHandler(SpyTransportError);
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Factory);

        Assert.IsTrue(Url = '', 'Url must be empty');
        Assert.IsTrue(SpyTransportError.IsInvoked(), 'TransportErrorHandler must be invoked');
        Assert.AreEqual('TRANSPORT', SpyTransportError.GetErrorMessage(), 'Unexpected error message');
    end;

    [Test]
    procedure ImagineMeth_Success()
    var
        Factory: Codeunit "Midjourney Factory";
        MockHttpClient: Codeunit "Mock HttpClient";
        ValidConfig: Codeunit "Stub Setup - Valid";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        Factory.SetHttpClient(MockHttpClient);
        Factory.SetMidjourneySetup(ValidConfig);
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Factory);

        Assert.IsTrue(Url <> '', 'Url must not empty');
    end;

}
