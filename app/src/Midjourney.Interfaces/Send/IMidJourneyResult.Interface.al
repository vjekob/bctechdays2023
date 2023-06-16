interface "IMidjourneyResult"
{
    procedure Initialize(Send: Interface IMidJourneySend);

    procedure Result(TaskId: Text) Result: Record "Midjourney Result" temporary;
}