codeunit 50240 "Stub Send - Running" implements IMidjourneySend
{
    var
        _percentage: Decimal;

    procedure SetPercentage(Percentage: Decimal);
    begin
        _percentage := Percentage;
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject;
    begin
        ResponseBody.ReadFrom(StrSubstNo('{ "status": "running", "percentage": %1 }', _percentage));
    end;
}
