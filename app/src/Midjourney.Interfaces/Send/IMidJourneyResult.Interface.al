interface "IMidjourneyResult"
{
    procedure Result(TaskId: Text; var Factory: codeunit ImagineFactory) Result: Record "Midjourney Result" temporary;
}