interface "MidJourney Http Invoker"
{
    procedure Post(Request: HttpRequestMessage) Content: JsonObject
}