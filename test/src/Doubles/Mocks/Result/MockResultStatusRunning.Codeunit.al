codeunit 50209 "Mock Result Status Running" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; var IMidJourneySend: interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
    begin

        Result.Percentage := 50;
        Result.Status := "Midjourney Request Status"::Done; //We set it to Done, to stop the loop, but it won't have a URL.
    end;
}