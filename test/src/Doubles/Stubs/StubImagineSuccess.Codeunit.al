codeunit 50203 "Stub Imagine Success" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend) TaskId: Text
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request);

        TaskId := '12345';
    end;

}