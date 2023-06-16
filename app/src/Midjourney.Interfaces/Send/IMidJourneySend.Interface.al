interface "IMidjourneySend"
{

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
}