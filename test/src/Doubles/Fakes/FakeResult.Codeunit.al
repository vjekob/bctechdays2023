codeunit 50230 "Fake Result" implements IMidjourneyResult
{
    var
        _send: Interface IMidjourneySend;

    procedure Initialize(Send: Interface IMidjourneySend);

    begin
        _send := Send;
    end;

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
    begin
        ResponseBody := _send.Send('Result', RequestBody);

        Result.Status := "Midjourney Request Status"::Done;
        Result.URL := 'https://www.waldo.be/'
    end;
}