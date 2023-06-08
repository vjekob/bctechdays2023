codeunit 50022 "MidJourney" implements IMidJourney
{
    procedure Imagine(Prompt: Text) MidJourneyResponse: Record "Midjourney Response";
    begin
        DoImagine(Prompt, MidJourneyResponse);
    end;

    procedure Result(TaskId: Text; Position: integer) MidJourneyResponse: Record "Midjourney Response";
    begin

    end;

    procedure Upscale(TaskId: Text; Position: Integer) MidJourneyResponse: Record "Midjourney Response";
    begin

    end;

    local procedure DoImagine(Prompt: Text; var Result: Record "Midjourney Response" temporary);
    var
        RequestBody: JsonObject;
        ResponseBody: JsonObject;
        Token: JsonToken;
    begin
        Clear(Result);
        Result.Status := "Midjourney Request Status"::Error;
        Result.Reason := 'Request was not yet sent';

        RequestBody.Add('prompt', prompt);
        ResponseBody := Send('imagine', RequestBody);

        Result.Reason := 'Response parsing error';

        ResponseBody.Get('taskId', Token);
        Result.TaskId := Token.AsValue().AsText();

        Result.Status := "Midjourney Request Status"::Sent;
        Result.Reason := '';
    end;

    local procedure Send(Path: Text; RequestBody: JsonObject) ResponseBody: JsonObject
    var
        Setup: Record "Midjourney Setup";
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        RequestBodyText: Text;
        ResponseBodyText: Text;
        BlockedByEnvironmentErr: Label 'Calling HTTP APIs is blocked by your Business Central configuration.';
        HttpStatusErr: Label '%1: %2', Comment = '%1 is HTTP status code (number), %2 is HTTP status message';
    begin
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

}