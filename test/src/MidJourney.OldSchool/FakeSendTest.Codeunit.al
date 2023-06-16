codeunit 50228 "Fake Send Test"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;

    [Test]
    procedure FakeSendReturnsUrl()
    var
        FakeSend: Codeunit "Fake Send";
        Setup: Record "Midjourney Setup";
        Request: JsonObject;
        SpyResponseHandler: Codeunit "Spy ResponseHandler";
        ResponseBody: JsonObject;
    begin
        ResponseBody := FakeSend.Send('Imagine', Setup, Request, SpyResponseHandler);

        Assert.IsTrue(ResponseBody.Contains('imageURL'), 'Doesn''t contain imageURL');
    end;

    [Test]
    procedure FakeSendHandlesResponse()
    var
        FakeSend: Codeunit "Fake Send";
        Setup: Record "Midjourney Setup";
        Request: JsonObject;
        SpyResponseHandler: Codeunit "Spy ResponseHandler";
        ResponseBody: JsonObject;
    begin
        ResponseBody := FakeSend.Send('Imagine', Setup, Request, SpyResponseHandler);

        Assert.IsTrue(SpyResponseHandler.WasCalled, 'Response handler was not called');
    end;
}