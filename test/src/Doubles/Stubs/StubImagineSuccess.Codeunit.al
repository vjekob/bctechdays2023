codeunit 50203 "Stub Imagine Success" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Factory: Codeunit ImagineFactory) TaskId: Text
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());

        TaskId := '12345';
    end;

}