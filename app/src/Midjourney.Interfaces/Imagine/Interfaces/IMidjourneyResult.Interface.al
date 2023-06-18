interface IMidjourneyResult
{
    procedure Result(TaskId: Text; Factory: Interface IMidjourneyFactory) Result: Record "Midjourney Result" temporary;
}