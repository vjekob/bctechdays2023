codeunit 50204 "Stub Result Status Done" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Factory: Codeunit ImagineFactory) Result: Record "Midjourney Result" temporary;
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());

        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}