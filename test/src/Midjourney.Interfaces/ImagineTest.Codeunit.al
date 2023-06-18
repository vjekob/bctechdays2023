codeunit 50235 ImagineTest
{
    TestPermissions = Disabled;
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure SendFails_NoTaskId()
    var
        Imagine: Codeunit "Midjourney - Imagine";
        StubNoTaskId: Codeunit "Stub Send - No TaskId";
    begin
        // Act
        asserterror Imagine.Imagine('Dummy prompt', StubNoTaskId);

        // Assert
        Assert.ExpectedError('There is no property with the ''taskId'' key on the JSON object.');
    end;

    [Test]
    procedure SendSucceeds_TaskId()
    var
        Imagine: Codeunit "Midjourney - Imagine";
        StubSuccess: Codeunit "Stub Send - Success";
        TaskId: Text;
    begin
        // Act
        TaskId := Imagine.Imagine('Dummy prompt', StubSuccess);

        // Assert
        Assert.IsTrue(TaskId <> '', 'TaskId is empty');
    end;
}
