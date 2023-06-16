interface "IMidJourneySend"
{
    procedure Send(Path: Text; Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
}