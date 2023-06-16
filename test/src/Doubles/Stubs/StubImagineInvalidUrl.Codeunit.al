codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend; ResponseHandler: Interface "IMidJourneySend ResponseHandler") TaskId: Text
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request, ResponseHandler);

        error('Invalid Url');
    end;
}