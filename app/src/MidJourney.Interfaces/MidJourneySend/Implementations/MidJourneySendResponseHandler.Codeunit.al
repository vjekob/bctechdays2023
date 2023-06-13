codeunit 50071 "MidJourneySend ResponseHandler" implements "IMidJourneySend ResponseHandler"
{
    procedure HandleResponse(var Response: HttpResponseMessage);
    var
        BlockedByEnvironmentErr: Label 'Calling Http APIs is blocked by your Business Central configuration.';
        HttpStatusErr: Label '%1: %2', Comment = '%1 is Http status code (number), %2 is Http status message';
    begin
        // TODO Send e-mail to admin
        if Response.IsBlockedByEnvironment() then
            Error(BlockedByEnvironmentErr);

        // TODO Show a nicely formatted error message for this
        if not Response.IsSuccessStatusCode() then
            Error(HttpStatusErr, Response.HttpStatusCode, Response.ReasonPhrase);
    end;

}