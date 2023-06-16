interface "IMidJourneySend"
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject) ResponseBody: JsonObject
}