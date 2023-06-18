codeunit 50231 "ImagineWithMidjourney Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Factory: Codeunit "Midjourney Factory";
        Assert: Codeunit Assert;

    [Test]
    procedure ImagineFails_NoTaskId()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineNoTaskId: Codeunit "Stub Imagine - No TaskId";
        SpyResult: Codeunit "Spy - Result";
    begin
        Factory.Reset();
        Factory.SetMidjourneyImagine(StubImagineNoTaskId);
        Factory.SetMidjourneyResult(SpyResult);

        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt');

        Assert.IsFalse(SpyResult.IsInvoked(), 'SpyResult should not have been called');
    end;

    [Test]
    procedure ImagineFails_UnknownStatus()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineSuccess: Codeunit "Stub Imagine - Success";
        MockResult: Codeunit "Mock Result";
    begin
        ImagineWithMidjourney.SetRetryDelay(0);
        MockResult.SetFailsWithUnknown();
        Factory.Reset();
        Factory.SetMidjourneyImagine(StubImagineSuccess);
        Factory.SetMidjourneyResult(MockResult);

        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt');

        Assert.ExpectedError('Unknown Midjourney Status!');
    end;

    [Test]
    procedure ImagineFails_Error()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineSuccess: Codeunit "Stub Imagine - Success";
        MockResult: Codeunit "Mock Result";
        ErrorToThrow: Label 'Something went wrong', Locked = true;
    begin
        ImagineWithMidjourney.SetRetryDelay(0);
        MockResult.SetFailsWithError(ErrorToThrow);
        Factory.SetMidjourneyImagine(StubImagineSuccess);
        Factory.SetMidjourneyResult(MockResult);

        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt');

        Assert.ExpectedError(ErrorToThrow);
    end;

    [Test]
    procedure Imagine_Succeeds()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineSuccess: Codeunit "Stub Imagine - Success";
        MockResult: Codeunit "Mock Result";
        Url: Text;
    begin
        ImagineWithMidjourney.SetRetryDelay(0);
        Factory.SetMidjourneyImagine(StubImagineSuccess);
        Factory.SetMidjourneyResult(MockResult);

        Url := ImagineWithMidjourney.GetImageUrl('Dummy prompt');

        Assert.IsTrue(Url <> '', 'Url should not be empty');
    end;
}
