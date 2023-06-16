codeunit 50210 "Stub Imagine Unauthorized" implements IMidJourneyImagine
{
    procedure Initialize(Send: Interface IMidJourneySend)
    begin
    end;


    procedure Imagine(Prompt: Text) TaskId: Text
    begin
        Error('401: Unauthorized');
    end;
}