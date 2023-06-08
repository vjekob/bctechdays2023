interface "IMidJourney"
{
    procedure Imagine(Prompt: Text) MidJourneyResponse: Record "Midjourney Response"
    procedure Result(TaskId: Text; Position: integer) MidJourneyResponse: Record "Midjourney Response"
    procedure Upscale(TaskId: Text; Position: integer) MidJourneyResponse: Record "Midjourney Response"
}