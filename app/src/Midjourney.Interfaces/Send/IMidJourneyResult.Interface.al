interface "IMidjourneyResult"
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend) Result: Record "Midjourney Result" temporary;
}