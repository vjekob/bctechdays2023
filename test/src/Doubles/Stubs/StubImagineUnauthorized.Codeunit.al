codeunit 50210 "Stub Imagine Unauthorized" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend; ResponseHandler: Interface "IMidJourneySend ResponseHandler") TaskId: Text
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request, ResponseHandler);

        Error('401: Unauthorized')
    end;

}