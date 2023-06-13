interface "IMidJourneyResult"
{
    procedure Result(TaskId: Text; var Setup: Record "Midjourney Setup") Result: Record "Midjourney Result" temporary;
}