codeunit 50069 "Midjourney - Send" implements IMidjourneySend
{
    procedure Send(Path: Text; RequestBody: JsonObject; Factory: Interface IMidjourneyFactory) ResponseBody: JsonObject
    var
        Setup: Interface IMidjourneySetup;
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        RequestBodyText: Text;
        ResponseBodyText: Text;
        BlockedByEnvironmentErr: Label 'Calling Http APIs is blocked by your Business Central configuration.';
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        Setup := Factory.GetMidjourneySetup();

        RequestBody.WriteTo(RequestBodyText);
        Request.Content.WriteFrom(RequestBodyText);

        Request.Method := 'POST';
        Request.SetRequestUri(Setup.GetEndpoint(Path));

        Request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', Setup.AuthorizationKey());

        Request.Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        if not Client.Send(Request, Response) then
            if Response.IsBlockedByEnvironment() then
                Error(BlockedByEnvironmentErr)
            else
                Error(GetLastErrorText());

        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode, Response.ReasonPhrase);

        Response.Content.ReadAs(ResponseBodyText);
        ResponseBody.ReadFrom(ResponseBodyText);
    end;
}
