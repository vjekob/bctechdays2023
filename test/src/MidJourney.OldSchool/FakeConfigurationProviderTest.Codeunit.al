codeunit 50222 "FakeConfigurationProviderTest"
{
    Subtype = Test;

    var
        Assert: Codeunit "Assert";

    [Test]
    procedure GetSetConfiguration()
    var
        TestValue: Text;
        Fake: Codeunit "FakeConfigurationProvider";
    begin
        Fake.Set('TestKey', 'TestValue', DataScope::Company);

        Fake.Get('TestKey', DataScope::Company, TestValue);
        Assert.AreEqual('TestValue', TestValue, 'Not Equal');
    end;

    [Test]
    procedure ContainsConfiguration_true()
    var
        Fake: Codeunit "FakeConfigurationProvider";
        Result: Boolean;
    begin
        Fake.Set('TestKey', 'TestValue', DataScope::Company);
        assert.IsTrue(fake.Contains('TestKey', DataScope::Company), 'Does not contain TestKey.');
    end;

    [Test]
    procedure ContainsConfiguration_false()
    var
        Fake: Codeunit "FakeConfigurationProvider";
    begin
        assert.IsFalse(fake.Contains('TestKey', DataScope::Company), 'Contains TestKey.');
    end;

    [Test]
    procedure DeleteConfiguration()
    var
        TestValue: Text;
        Fake: Codeunit "FakeConfigurationProvider";
    begin
        Fake.Set('TestKey', 'TestValue', DataScope::Company);

        fake.Delete('TestKey', DataScope::Company);

        assert.IsFalse(fake.Contains('TestKey', DataScope::Company), 'Not deleted.');
    end;


}