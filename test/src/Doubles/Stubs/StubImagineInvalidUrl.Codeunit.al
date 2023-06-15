codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
    begin
        error('Invalid Url');
    end;

}