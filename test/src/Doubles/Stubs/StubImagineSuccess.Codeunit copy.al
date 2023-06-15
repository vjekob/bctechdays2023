codeunit 50203 "Stub Imagine Success" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
    begin
        TaskId := '12345';
    end;

}