codeunit 50210 "Stub Imagine Unauthorized" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
    begin
        Error('401: Unauthorized')
    end;

}