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
        Setup: Record "Midjourney Setup";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with invalid URL
        Setup.SetConfigurationProvider(FakeConfigProvider);
        Setup."Midjourney URL" := 'gopher://fake.url/?really';
        Setup.SetMidjourneyAuthKey(MidjourneyAuthKey);

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Setup);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_InvalidAuthKey()
    var
        Setup: Record "Midjourney Setup";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with invalid auth key
        Setup.SetConfigurationProvider(FakeConfigProvider);
        Setup."Midjourney URL" := MidjourneyURL;
        Setup.SetMidjourneyAuthKey('fake-auth-key');

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Setup);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_Success()
    var
        Setup: Record "Midjourney Setup";
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        FakeConfigProvider: Codeunit FakeConfigurationProvider;
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with valid URL and auth key
        Setup.SetConfigurationProvider(FakeConfigProvider);
        Setup."Midjourney URL" := MidjourneyURL;
        Setup.SetMidjourneyAuthKey(MidjourneyAuthKey);

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt, Setup);

        // [THEN] URL must be a well-formed URL
        Assert.IsTrue(Url.StartsWith('http'), 'Url is not a valid url');
    end;
}