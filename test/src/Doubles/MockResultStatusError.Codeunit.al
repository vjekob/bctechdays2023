codeunit 50208 "Mock Result Status Error" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup") Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := "Midjourney Request Status"::Error;
        Result."Error Message" := 'Error Message';
    end;


}