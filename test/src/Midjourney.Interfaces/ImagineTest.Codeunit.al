codeunit 50235 ImagineTest
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure SendFails_NoTaskId()
    var
        Factory: Codeunit "Midjourney Factory";
        Imagine: Codeunit "Midjourney - Imagine";
        StubNoTaskId: Codeunit "Stub Send - No TaskId";
    begin
        Factory.SetMidjourneySend(StubNoTaskId);

        asserterror Imagine.Imagine('Dummy prompt', Factory);

        Assert.ExpectedError('There is no property with the ''taskId'' key on the JSON object.');
    end;

    [Test]
    procedure SendSucceeds_TaskId()
    var
        Factory: Codeunit "Midjourney Factory";
        Imagine: Codeunit "Midjourney - Imagine";
        StubSuccess: Codeunit "Stub Send - Success";
        TaskId: Text;
    begin
        Factory.SetMidjourneySend(StubSuccess);

        TaskId := Imagine.Imagine('Dummy prompt', Factory);

        Assert.IsTrue(TaskId <> '', 'TaskId is empty');
    end;
}
