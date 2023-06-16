codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend) TaskId: Text
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request);

        error('Invalid Url');
    end;
}