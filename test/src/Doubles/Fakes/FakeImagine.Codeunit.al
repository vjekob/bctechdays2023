codeunit 50229 "Fake Imagine" implements IMidjourneyImagine
{
    var
        _send: Interface IMidJourneySend;

    procedure Initialize(Send: Interface IMidJourneySend)
    begin
        _send := Send;
    end;

    procedure Imagine(Prompt: Text) TaskId: Text;
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
    begin
        ResponseBody := _send.Send('Imagine', RequestBody);

        exit('12345');
    end;
}