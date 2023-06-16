codeunit 50069 "MidJourney - Send" implements IMidJourneySend
{
    var
        _setup: Record "Midjourney Setup";

    procedure Initialize(var SetupIn: Record "Midjourney Setup")
    begin
        _setup := SetupIn;
    end;

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        RequestBodyText: Text;
        ResponseBodyText: Text;
        BlockedByEnvironmentErr: Label 'Calling Http APIs is blocked by your Business Central configuration.';
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        RequestBody.WriteTo(RequestBodyText);
        Request.Content.WriteFrom(RequestBodyText);

        Request.Method := 'POST';
        Request.SetRequestUri(_setup.GetMidjourneyEndpoint(Path));

        Request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', _setup.GetMidjourneyAuthKey());

        Request.Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        Client.Send(Request, Response);

        // TODO Send e-mail to admin
        if Response.IsBlockedByEnvironment() then
            Error(BlockedByEnvironmentErr);

        // TODO Show a nicely formatted error message for this
        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode, Response.ReasonPhrase);

        // TODO Do something else when this happens
        Response.Content.ReadAs(ResponseBodyText);
        ResponseBody.ReadFrom(ResponseBodyText);

    end;

}