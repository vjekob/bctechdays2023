codeunit 50204 "Stub Result Status Done" implements IMidJourneyResult
{
    procedure Initialize(Send: Interface IMidJourneySend)
    begin
    end;

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}