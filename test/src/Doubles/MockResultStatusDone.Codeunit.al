codeunit 50204 "Mock Result Status Done" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup") Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}