codeunit 50238 ResultTest
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure Result_StatusUnknown()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        StubStatus.SetStatus('unknown');
        Factory.SetMidjourneySend(StubStatus);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::WaitingToStart, Response.Status, 'Status should be WaitingToStart');
    end;

    [Test]
    procedure Result_StatusWaitingToStart()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        StubStatus.SetStatus('waiting-to-start');
        Factory.SetMidjourneySend(StubStatus);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::WaitingToStart, Response.Status, 'Status should be WaitingToStart');
    end;

    [Test]
    procedure Result_StatusPending()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        StubStatus.SetStatus('pending');
        Factory.SetMidjourneySend(StubStatus);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::Pending, Response.Status, 'Status should be Pending');
    end;

    [Test]
    procedure Result_StatusPaused()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        StubStatus.SetStatus('paused');
        Factory.SetMidjourneySend(StubStatus);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::Paused, Response.Status, 'Status should be Paused');
    end;

    [Test]
    procedure Result_StatusRunning()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubPercentage: Codeunit "Stub Send - Running";
        Response: Record "Midjourney Result" temporary;
    begin
        StubPercentage.SetPercentage(3.14);
        Factory.SetMidjourneySend(StubPercentage);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::Running, Response.Status, 'Status should be Running');
        Assert.AreEqual(3.14, Response.Percentage, 'Percentage was not properly parsed');
    end;

    [Test]
    procedure Result_StatusError()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubStatus: Codeunit "Stub Send - Status";
        Response: Record "Midjourney Result" temporary;
    begin
        StubStatus.SetStatus('rejected-by-ai');
        Factory.SetMidjourneySend(StubStatus);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::Error, Response.Status, 'Status should be Error');
        Assert.AreEqual('rejected-by-ai', Response."Error Message", 'Error was not properly parsed');
    end;

    [Test]
    procedure Result_StatusDone()
    var
        Factory: Codeunit "Midjourney Factory";
        Result: Codeunit "Midjourney - Result";
        StubDone: Codeunit "Stub Send - Done";
        Response: Record "Midjourney Result" temporary;
    begin
        StubDone.SetImageURL('https://vjeko.com/');
        Factory.SetMidjourneySend(StubDone);

        Response := Result.Result('Dummy Task Id', Factory);

        Assert.AreEqual("Midjourney Request Status"::Done, Response.Status, 'Status should be Done');
        Assert.AreEqual('https://vjeko.com/', Response.URL, 'URL was not properly parsed');
    end;
}
