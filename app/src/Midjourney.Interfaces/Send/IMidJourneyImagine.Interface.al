interface "IMidjourneyImagine"
{
    procedure Initialize(Send: Interface IMidJourneySend);

    procedure Imagine(Prompt: Text) TaskId: Text
}