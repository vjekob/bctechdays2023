interface "IMidJourneySend"
{
    procedure Send(Path: Text; RequestBody: JsonObject; ResponseHandler: Interface "IMidJourneySend ResponseHandler") ResponseBody: JsonObject
}