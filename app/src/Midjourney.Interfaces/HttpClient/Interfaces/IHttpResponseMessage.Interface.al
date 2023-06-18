interface IHttpResponseMessage
{
    procedure IsBlockedByEnvironment(): Boolean;
    procedure IsSuccessStatusCode(): Boolean;
    procedure HttpStatusCode(): Integer;
    procedure ReasonPhrase(): Text;
    procedure GetResponseBody(): JsonObject;
    procedure GetResponseBodyAsText(): Text;
}
