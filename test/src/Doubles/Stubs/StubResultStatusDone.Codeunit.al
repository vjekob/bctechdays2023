codeunit 50204 "Stub Result Status Done" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; Send: interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
    var
        Request: JsonObject;
    begin
        Send.Send('Path', Setup, Request);

        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}