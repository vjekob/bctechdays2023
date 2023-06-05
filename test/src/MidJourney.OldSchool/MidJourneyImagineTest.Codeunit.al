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
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with invalid URL
        SetupMidjourney('gopher://fake.url/?really', MidjourneyAuthKey);

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_InvalidAuthKey()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with invalid auth key
        SetupMidjourney(MidjourneyURL, 'fake-auth-key');

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        asserterror Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt);

        // [THEN] URL must be empty
        Assert.IsTrue(Url = '', 'Url must be empty');
    end;

    [Test]
    procedure ImagineMeth_Success()
    var
        ImagineWithMidjourneyMeth: Codeunit "ImagineWithMidjourney Meth";
        Url: Text;
        Prompt: Text;
    begin
        // [GIVEN] Setup with valid URL and auth key
        SetupMidjourney(MidjourneyURL, MidjourneyAuthKey);

        // [GIVEN] Prompt
        Prompt := 'Two old muppets Waldorf and Statler presenting in an aula in front of hundreds of people';

        // [WHEN] Invoking Midjourney
        Url := ImagineWithMidjourneyMeth.GetImageUrl(Prompt);

        // [THEN] URL must be a well-formed URL
        Assert.IsTrue(Url.StartsWith('http'), 'Url is not a valid url');
    end;

    local procedure SetupMidjourney(URL: Text; AuthKey: Text)
    var
        MidjourneySetup: Record "Midjourney Setup";
    begin
        if not MidjourneySetup.Get then
            MidjourneySetup.Insert();

        if URL.Trim() <> '' then
            MidjourneySetup."Midjourney URL" := URL;

        if (AuthKey.Trim() <> '') then
            MidjourneySetup.SetMidjourneyAuthKey(AuthKey);

        MidjourneySetup.Modify();
    end;
}