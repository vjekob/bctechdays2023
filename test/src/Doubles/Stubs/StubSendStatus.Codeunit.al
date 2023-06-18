codeunit 50239 "Stub Send - Status" implements IMidjourneySend
{
    var
        _status: Text;

    procedure SetStatus(Status: Text);
    begin
        _status := Status;
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom(StrSubstNo('{ "status": "%1" }', _status));
    end;
}