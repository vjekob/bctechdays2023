codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Imagine(Prompt: Text) TaskId: Text
    begin
        error('Invalid Url');
    end;

}