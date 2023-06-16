codeunit 50225 "Stub Send Error" implements IMidjourneySend
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup"; ResponseHandler: Interface "IMidJourneySend ResponseHandler")
    begin
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    begin
        Error('Some Error');
    end;
}