interface "IMidJourneyResult"
{
    procedure Result(TaskId: Text; IMidJourneySend: Interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
}