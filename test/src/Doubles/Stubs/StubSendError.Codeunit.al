codeunit 50225 "Stub Send Error" implements IMidJourneySend
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup")
    begin
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    begin
        Error('Some Error');
    end;
}