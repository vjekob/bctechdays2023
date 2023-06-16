codeunit 50208 "Stub Result Status Error" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Factory: Codeunit ImagineFactory) Result: Record "Midjourney Result" temporary;
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());

        Result.Status := "Midjourney Request Status"::Error;
        Result."Error Message" := 'Error Message';
    end;


}