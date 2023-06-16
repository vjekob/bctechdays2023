codeunit 50208 "Stub Result Status Error" implements IMidJourneyResult
{
    procedure Initialize(Send: Interface IMidjourneySend);
    begin
    end;

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    begin
        Result.Status := "Midjourney Request Status"::Error;
        Result."Error Message" := 'Error Message';
    end;


}