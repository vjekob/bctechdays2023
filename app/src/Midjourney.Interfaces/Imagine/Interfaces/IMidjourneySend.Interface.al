interface IMidjourneySend
{
    procedure Send(Path: Text; RequestBody: JsonObject; Factory: Interface IMidjourneyFactory) ResponseBody: JsonObject
}
