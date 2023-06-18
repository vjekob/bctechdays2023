interface IMidjourneyResult
{
    procedure Result(TaskId: Text; MidjourneySend: Interface IMidjourneySend) Result: Record "Midjourney Result" temporary;
}