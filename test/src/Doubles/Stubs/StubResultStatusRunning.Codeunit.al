codeunit 50209 "Stub Result Status Running" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup") Result: Record "Midjourney Result" temporary;
    begin

        Result.Percentage := 50;
        Result.Status := "Midjourney Request Status"::Done; //We set it to Done, to stop the loop, but it won't have a URL.
    end;
}