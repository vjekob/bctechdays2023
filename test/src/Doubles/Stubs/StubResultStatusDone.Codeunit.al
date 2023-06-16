codeunit 50204 "Stub Result Status Done" implements IMidJourneyResult
{
    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}