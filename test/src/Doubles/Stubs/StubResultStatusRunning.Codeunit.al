codeunit 50209 "Stub Result Status Running" implements IMidJourneyResult
{
    procedure Initialize(Send: Interface IMidjourneySend)
    begin

    end;

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    begin
        Result.Percentage := 50;
        Result.Status := "Midjourney Request Status"::Done; //We set it to Done, to stop the loop, but it won't have a URL.
    end;
}