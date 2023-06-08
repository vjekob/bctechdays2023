interface "MidJourney HTTP Invoker"
{
    procedure Post(Request: HTTPRequestMessage) Content: JsonObject
}