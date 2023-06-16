interface "IMidjourneyResult"
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend; ResponseHandler: Interface "IMidJourneySend ResponseHandler") Result: Record "Midjourney Result" temporary;
}