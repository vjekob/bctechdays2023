codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Factory: Codeunit ImagineFactory) TaskId: Text
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());

        error('Invalid Url');
    end;
}