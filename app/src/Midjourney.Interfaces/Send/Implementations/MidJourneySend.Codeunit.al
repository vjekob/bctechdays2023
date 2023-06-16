codeunit 50069 "MidJourney - Send" implements IMidJourneySend
{
    var
        _setup: Record "Midjourney Setup";
        _responseHandler: Interface "IMidJourneySend ResponseHandler";

    procedure Initialize(var SetupIn: Record "Midjourney Setup"; ResponseHandler: Interface "IMidJourneySend ResponseHandler")
    begin
        _setup := SetupIn;
        _responseHandler := ResponseHandler;
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

        _responseHandler.HandleResponse(Response);

        // TODO Do something else when this happens
        Response.Content.ReadAs(ResponseBodyText);
        ResponseBody.ReadFrom(ResponseBodyText);

    end;

}