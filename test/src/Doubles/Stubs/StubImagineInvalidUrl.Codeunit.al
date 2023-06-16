codeunit 50223 "Stub Imagine InvalidUrl" implements IMidJourneyImagine
{
    procedure Initialize(Send: Interface IMidjourneySend)
    begin
    end;

    procedure Imagine(Prompt: Text) TaskId: Text
    begin
        error('Invalid Url');
    end;
}