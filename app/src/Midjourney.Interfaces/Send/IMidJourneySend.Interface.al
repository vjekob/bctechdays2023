interface "IMidJourneySend"
{
    procedure Initialize(var SetupIn: Record "Midjourney Setup")

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
}