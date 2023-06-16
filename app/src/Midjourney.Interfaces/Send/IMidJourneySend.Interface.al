interface "IMidJourneySend"
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup"; ResponseHandler: Interface "IMidJourneySend ResponseHandler")

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
}