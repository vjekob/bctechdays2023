codeunit 50203 "Stub Imagine Success" implements IMidJourneyImagine
{

    procedure Initialize(Send: Interface IMidjourneySend)
    begin
    end;

    procedure Imagine(Prompt: Text) TaskId: Text
    begin
        TaskId := '12345';
    end;

}