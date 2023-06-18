codeunit 50233 "Spy - Result" implements IMidjourneyResult
{
    var
        _invoked: Boolean;

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
    begin
        _invoked := true;
    end;

    procedure IsInvoked(): Boolean
    begin
        exit(_invoked);
    end;
}
