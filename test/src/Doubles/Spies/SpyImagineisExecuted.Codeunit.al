codeunit 50220 "Spy Imagine isExecuted" implements IMidJourneyImagine
{
    SingleInstance = true;

    var
        IsExecuted: Boolean;

    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; IMidJourneySend: interface IMidJourneySend) TaskId: Text
    begin
        IsExecuted := true;
    end;

    procedure ResetIsExecuted()
    begin
        IsExecuted := false;
    end;

    procedure GetIsExecuted(): Boolean
    begin
        exit(IsExecuted);
    end;
}