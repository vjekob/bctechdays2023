codeunit 50210 "Stub Imagine Unauthorized" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend) TaskId: Text
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request);

        Error('401: Unauthorized')
    end;

}