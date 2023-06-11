interface "IMIdJourney Send"
{
    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JSonObject;
}