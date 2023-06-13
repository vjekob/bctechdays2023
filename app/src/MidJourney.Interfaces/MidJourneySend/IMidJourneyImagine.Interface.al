interface "IMidJourneyImagine"
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; IMidJourneySend: Interface IMidJourneySend) TaskId: Text
}