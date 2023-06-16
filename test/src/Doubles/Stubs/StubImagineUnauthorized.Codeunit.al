codeunit 50210 "Stub Imagine Unauthorized" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Factory: Codeunit ImagineFactory) TaskId: Text
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());

        Error('401: Unauthorized')
    end;

}