interface "IMidJourneyPrompt"
{
    procedure Prompt(ImageUrl: Text; IMidJourneySetting: Interface "IMidJourney Setting"; IMidJourneyStyle: Interface "IMidJourney Style"; IMidJourneyAspectRatio: Interface "IMidJourney Aspect Ratio"; CustomPrompt: Text) Prompt: Text
}