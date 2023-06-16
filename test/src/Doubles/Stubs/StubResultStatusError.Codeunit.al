codeunit 50208 "Stub Result Status Error" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request);

        Result.Status := "Midjourney Request Status"::Error;
        Result."Error Message" := 'Error Message';
    end;


}