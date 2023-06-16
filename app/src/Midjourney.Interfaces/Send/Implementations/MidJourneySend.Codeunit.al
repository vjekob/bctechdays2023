codeunit 50069 "MidJourney - Send" implements IMidjourneySend
{
    var
        Factory: Codeunit "Midjourney Factory";

    procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    var
        Setup: Record "Midjourney Setup";
        ResponseHandler: interface "IMidJourneySend ResponseHandler";
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        RequestBodyText: Text;
        ResponseBodyText: Text;
        BlockedByEnvironmentErr: Label 'Calling Http APIs is blocked by your Business Central configuration.';
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        Setup := factory.Setup();

        RequestBody.WriteTo(RequestBodyText);
        Request.Content.WriteFrom(RequestBodyText);

        Request.Method := 'POST';
        Request.SetRequestUri(Setup.GetMidjourneyEndpoint(Path));

        Request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', Setup.GetMidjourneyAuthKey());

        Request.Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        Client.Send(Request, Response);

        ResponseHandler := Factory.ResponseHandler();
        ResponseHandler.HandleResponse(Response);

        // TODO Do something else when this happens
        Response.Content.ReadAs(ResponseBodyText);
        ResponseBody.ReadFrom(ResponseBodyText);

    end;

}