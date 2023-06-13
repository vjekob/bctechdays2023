interface "IMidJourneyResult"
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; var IMidJourneySend: Interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
}