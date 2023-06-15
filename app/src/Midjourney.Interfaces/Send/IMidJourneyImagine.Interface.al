interface "IMidjourneyImagine"
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup") TaskId: Text
}