codeunit 50225 "Stub Send Error" implements IMidJourneySend
{
    procedure Send(Path: Text; Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject;
    begin
        Error('Some Error');
    end;
}