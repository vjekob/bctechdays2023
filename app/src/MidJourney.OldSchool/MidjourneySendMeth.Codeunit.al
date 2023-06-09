codeunit 50010 "Midjourney Send Meth"
{
    internal procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    var
        IsHandled: Boolean;
    begin
        OnBeforeSend(Path, RequestBody, ResponseBody, IsHandled);
        DoSend(Path, RequestBody, ResponseBody, IsHandled);
        OnAfterSend(Path, RequestBody, ResponseBody);
    end;

    local procedure DoSend(Path: Text; RequestBody: JsonObject; var ResponseBody: JsonObject; IsHandled: Boolean);
    var
        Setup: Record "Midjourney Setup";
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

        Setup.GetForMidjourney();

        RequestBody.WriteTo(RequestBodyText);
        Request.Content.WriteFrom(RequestBodyText);

        Request.Method := 'POST';
        Request.SetRequestUri(Setup.GetMidjourneyEndpoint('imagine'));

        Request.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Authorization', Setup.GetMidjourneyAuthKey());

        Request.Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');

        Client.Send(Request, Response);
        if Response.IsBlockedByEnvironment() then
            Error(BlockedByEnvironmentErr);

        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode, Response.ReasonPhrase);

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