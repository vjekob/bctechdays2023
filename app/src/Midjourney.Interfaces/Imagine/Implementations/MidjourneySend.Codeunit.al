codeunit 50069 "Midjourney - Send" implements IMidjourneySend
{
    procedure Send(Path: Text; RequestBody: JsonObject; Factory: Interface IMidjourneyFactory) ResponseBody: JsonObject
    var
        Setup: Interface IMidjourneySetup;
        Client: Interface IHttpClient;
        Request: HttpRequestMessage;
        Response: Interface IHttpResponseMessage;
        Headers: HttpHeaders;
        RequestBodyText: Text;
    begin
        Setup := Factory.GetMidjourneySetup();
        Client := Factory.GetHttpClient();

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

        if not Client.Send(Request, Response) then begin
            if Response.IsBlockedByEnvironment() then
                BlockedByEnvironment(Request, Factory)
            else
                TransportError(Factory);
            Error('');
        end;

        if not Response.IsSuccessStatusCode() then begin
            HttpError(Response, Factory);
            Error('');
        end;

        ResponseBody := Response.GetResponseBody();
    end;

    local procedure BlockedByEnvironment(Message: HttpRequestMessage; Factory: Interface IMidjourneyFactory)
    var
        BlockedByEnvironmentHandler: Interface IBlockedByEnvironmentHandler;
    begin
        BlockedByEnvironmentHandler := Factory.GetBlockedByEnvironmentHandler();
        BlockedByEnvironmentHandler.HandleBlockedByEnvironment(Message.Method, Message.GetRequestUri());
    end;

    local procedure HttpError(Response: Interface IHttpResponseMessage; Factory: Interface IMidjourneyFactory)
    var
        HttpErrorHandler: Interface IHttpErrorHandler;
        Body: Text;
    begin
        Body := Response.GetResponseBodyAsText();
        HttpErrorHandler := Factory.GetHttpErrorHandler();
        HttpErrorHandler.HandleError(Response.HttpStatusCode, Response.ReasonPhrase, Body);
    end;

    local procedure TransportError(Factory: Interface IMidjourneyFactory)
    var
        TransportErrorHandler: Interface ITransportErrorHandler;
    begin
        TransportErrorHandler := Factory.GetTransportErrorHandler();
        TransportErrorHandler.HandleError(GetLastErrorText());
    end;
}
