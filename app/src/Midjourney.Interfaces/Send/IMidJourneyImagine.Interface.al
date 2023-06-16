interface "IMidjourneyImagine"
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend) TaskId: Text
}