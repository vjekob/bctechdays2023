codeunit 50203 "Mock Imagine Success" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; IMidJourneySend: interface IMidJourneySend) TaskId: Text
    begin
        TaskId := '12345';
    end;
}