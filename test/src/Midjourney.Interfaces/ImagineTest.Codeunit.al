codeunit 50235 ImagineTest
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Factory: Codeunit "Midjourney Factory";
        Assert: Codeunit Assert;

    [Test]
    procedure SendFails_NoTaskId()
    var
        Imagine: Codeunit "Midjourney - Imagine";
        StubNoTaskId: Codeunit "Stub Send - No TaskId";
    begin
        Factory.Reset();
        Factory.SetMidjourneySend(StubNoTaskId);

        asserterror Imagine.Imagine('Dummy prompt');

        Assert.ExpectedError('There is no property with the ''taskId'' key on the JSON object.');
    end;

    [Test]
    procedure SendSucceeds_TaskId()
    var
        Imagine: Codeunit "Midjourney - Imagine";
        StubSuccess: Codeunit "Stub Send - Success";
        TaskId: Text;
    begin
        Factory.Reset();
        Factory.SetMidjourneySend(StubSuccess);

        TaskId := Imagine.Imagine('Dummy prompt');

        Assert.IsTrue(TaskId <> '', 'TaskId is empty');
    end;
}
