interface "IMidJourneySend"
{
    procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
}