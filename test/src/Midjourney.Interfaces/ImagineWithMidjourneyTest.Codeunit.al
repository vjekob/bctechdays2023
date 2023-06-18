codeunit 50231 "ImagineWithMidjourney Test"
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure ImagineFails_NoTaskId()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineNoTaskId: Codeunit "Stub Imagine - No TaskId";
        SpyResult: Codeunit "Spy - Result";
    begin
        // Act
        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt', StubImagineNoTaskId, SpyResult);

        // Assert
        Assert.IsFalse(SpyResult.IsInvoked(), 'SpyResult should not have been called');
    end;

    [Test]
    procedure ImagineFails_UnknownStatus()
    var
        ImagineWithMidjourney: Codeunit "ImagineWithMidjourney Meth";
        StubImagineSuccess: Codeunit "Stub Imagine - Success";
        MockResult: Codeunit "Mock Result";
    begin
        // Arrange
        ImagineWithMidjourney.SetRetryDelay(0);
        MockResult.SetFailsWithUnknown();

        // Act
        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt', StubImagineSuccess, MockResult);

        // Assert
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
        // Arrange
        ImagineWithMidjourney.SetRetryDelay(0);
        MockResult.SetFailsWithError(ErrorToThrow);

        // Act
        asserterror ImagineWithMidjourney.GetImageUrl('Dummy prompt', StubImagineSuccess, MockResult);

        // Assert
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
        // Arrange
        ImagineWithMidjourney.SetRetryDelay(0);

        // Act
        Url := ImagineWithMidjourney.GetImageUrl('Dummy prompt', StubImagineSuccess, MockResult);

        // Assert
        Assert.IsTrue(Url <> '', 'Url should not be empty');
    end;
}
