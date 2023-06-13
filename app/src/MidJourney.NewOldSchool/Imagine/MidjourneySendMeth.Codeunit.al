codeunit 50010 "Midjourney Send Meth"
{
    internal procedure Send(Path: Text; var Setup: Record "Midjourney Setup"; RequestBody: JsonObject) ResponseBody: JsonObject
    var
        IsHandled: Boolean;
    begin
        OnBeforeSend(Path, RequestBody, ResponseBody, IsHandled);
        DoSend(Path, RequestBody, Setup, ResponseBody, IsHandled);
        OnAfterSend(Path, RequestBody, ResponseBody);
    end;

    local procedure DoSend(Path: Text; RequestBody: JsonObject; var Setup: Record "Midjourney Setup"; var ResponseBody: JsonObject; IsHandled: Boolean);
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
        if IsHandled then
            exit;

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

        // TODO Send e-mail to admin
        Client.Send(Request, Response);
        if Response.IsBlockedByEnvironment() then
            Error(BlockedByEnvironmentErr);

        // TODO Show a nicely formatted error message for this
        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode, Response.ReasonPhrase);

        // TODO Do something else when this happens
        Response.Content.ReadAs(ResponseBodyText);
        ResponseBody.ReadFrom(ResponseBodyText);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSend(Path: Text; RequestBody: JsonObject; var ResponseBody: JsonObject; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSend(Path: Text; RequestBody: JsonObject; ResponseBody: JsonObject);
    begin
    end;
}