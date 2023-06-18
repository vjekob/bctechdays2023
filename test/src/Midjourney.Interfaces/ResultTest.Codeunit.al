codeunit 50238 ResultTest
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure Result_StatusUnknown()
    var
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubStatus.SetStatus('unknown');

        // Act
        Response := Result.Result('Dummy Task Id', StubStatus);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::WaitingToStart, Response.Status, 'Status should be WaitingToStart');
    end;

    [Test]
    procedure Result_StatusWaitingToStart()
    var
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubStatus.SetStatus('waiting-to-start');

        // Act
        Response := Result.Result('Dummy Task Id', StubStatus);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::WaitingToStart, Response.Status, 'Status should be WaitingToStart');
    end;

    [Test]
    procedure Result_StatusPending()
    var
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubStatus.SetStatus('pending');

        // Act
        Response := Result.Result('Dummy Task Id', StubStatus);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::Pending, Response.Status, 'Status should be Pending');
    end;

    [Test]
    procedure Result_StatusPaused()
    var
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubStatus.SetStatus('paused');

        // Act
        Response := Result.Result('Dummy Task Id', StubStatus);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::Paused, Response.Status, 'Status should be Paused');
    end;

    [Test]
    procedure Result_StatusRunning()
    var
        Result: Codeunit "Midjourney - Result";
        StubPercentage: Codeunit "Stub Send - Running";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubPercentage.SetPercentage(3.14);

        // Act
        Response := Result.Result('Dummy Task Id', StubPercentage);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::Running, Response.Status, 'Status should be Running');
        Assert.AreEqual(3.14, Response.Percentage, 'Percentage was not properly parsed');
    end;

    [Test]
    procedure Result_StatusError()
    var
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubStatus.SetStatus('rejected-by-ai');

        // Act
        Response := Result.Result('Dummy Task Id', StubStatus);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::Error, Response.Status, 'Status should be Error');
        Assert.AreEqual('rejected-by-ai', Response."Error Message", 'Error was not properly parsed');
    end;

    [Test]
    procedure Result_StatusDone()
    var
        Result: Codeunit "Midjourney - Result";
        StubDone: Codeunit "Stub Send - Done";
        Response: Record "Midjourney Result" temporary;
    begin
        // Arrange
        StubDone.SetImageURL('https://vjeko.com/');

        // Act
        Response := Result.Result('Dummy Task Id', StubDone);

        // Assert
        Assert.AreEqual("Midjourney Request Status"::Done, Response.Status, 'Status should be Done');
        Assert.AreEqual('https://vjeko.com/', Response.URL, 'URL was not properly parsed');
    end;
}
