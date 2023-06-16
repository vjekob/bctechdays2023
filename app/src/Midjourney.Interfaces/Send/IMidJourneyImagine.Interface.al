interface "IMidjourneyImagine"
{
    procedure Imagine(Prompt: Text; var Setup: Record "Midjourney Setup"; Send: Interface IMidJourneySend; ResponseHandler: Interface "IMidJourneySend ResponseHandler") TaskId: Text
}