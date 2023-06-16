codeunit 50209 "Stub Result Status Running" implements IMidJourneyResult
{
    procedure Result(TaskId: Text; var Factory: Codeunit ImagineFactory) Result: Record "Midjourney Result" temporary;
    var
        Request: JsonObject;
    begin
        Factory.Send().Send('Path', Factory.Setup(), Request, Factory.ResponseHandler());


        Result.Percentage := 50;
        Result.Status := "Midjourney Request Status"::Done; //We set it to Done, to stop the loop, but it won't have a URL.
    end;
}